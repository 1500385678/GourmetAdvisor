-- ============================================================================
-- GourmetAdvisor · 菜谱库 Schema v0.1
-- 项目代号:GourmetAdvisor · 内部代号 03-美食 · 2026-08-26
-- 关联文件:项目开发计划.md Phase 0 · 任务 6 (设计菜谱表)
-- 引擎:SQLite 3(Phase 0) → PostgreSQL 14+(Phase 1 迁移)
-- 设计原则:5 张主表 + 1 张多对多桥接表,留好 FK 与索引
-- ============================================================================

-- ----------------------------
-- 1. recipe · 菜谱主体
-- ----------------------------
CREATE TABLE IF NOT EXISTS recipe (
    id              INTEGER PRIMARY KEY AUTOINCREMENT,
    name            TEXT    NOT NULL,                       -- 菜名,如 "麻婆豆腐"
    cuisine         TEXT    NOT NULL DEFAULT '未知',         -- 菜系:川/鲁/粤/淮扬/浙/闽/徽/湘/西餐/日料...
    difficulty      INTEGER NOT NULL DEFAULT 1               -- 难度 1-5(1=简单,5=复杂)
                    CHECK (difficulty BETWEEN 1 AND 5),
    prep_time_min   INTEGER NOT NULL DEFAULT 0,             -- 备料时间(分钟)
    cook_time_min   INTEGER NOT NULL DEFAULT 0,             -- 烹饪时间(分钟)
    servings        INTEGER NOT NULL DEFAULT 1               -- 份数(几人份)
                    CHECK (servings > 0),
    description     TEXT,                                    -- 一句话简介
    source          TEXT    NOT NULL DEFAULT '知识库',        -- 来源:知识库/网络/书籍/用户贡献/AI 生成
    source_ref      TEXT,                                    -- 具体引用,如 "../09_健康快手食谱/健康快手食谱.md#L42"
    is_ai_generated INTEGER NOT NULL DEFAULT 0               -- 0=人工/知识库提取,1=AI 生成(需标记)
                    CHECK (is_ai_generated IN (0, 1)),
    created_at      TEXT    NOT NULL DEFAULT (datetime('now')),
    updated_at      TEXT    NOT NULL DEFAULT (datetime('now'))
);

CREATE INDEX IF NOT EXISTS idx_recipe_cuisine    ON recipe(cuisine);
CREATE INDEX IF NOT EXISTS idx_recipe_difficulty ON recipe(difficulty);
CREATE INDEX IF NOT EXISTS idx_recipe_source     ON recipe(source);

-- ----------------------------
-- 2. ingredient · 食材行项(每菜多行)
-- ----------------------------
CREATE TABLE IF NOT EXISTS ingredient (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    recipe_id   INTEGER NOT NULL,
    name        TEXT    NOT NULL,                           -- 食材名,如 "豆腐"
    qty         REAL    NOT NULL DEFAULT 1,                 -- 数量(浮点)
    unit        TEXT    NOT NULL DEFAULT 'g',               -- 单位:g/ml/个/勺/茶匙/适量
    note        TEXT,                                       -- 备注:切丁/去骨/可选/替换
    is_optional INTEGER NOT NULL DEFAULT 0                  -- 0=必备,1=可选
                CHECK (is_optional IN (0, 1)),
    order_no    INTEGER NOT NULL DEFAULT 0,                 -- 在食材列表中的顺序
    FOREIGN KEY (recipe_id) REFERENCES recipe(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_ingredient_recipe ON ingredient(recipe_id);
CREATE INDEX IF NOT EXISTS idx_ingredient_name   ON ingredient(name);   -- 冰箱识别反查用

-- ----------------------------
-- 3. step · 烹饪步骤(每菜多步)
-- ----------------------------
CREATE TABLE IF NOT EXISTS step (
    id            INTEGER PRIMARY KEY AUTOINCREMENT,
    recipe_id     INTEGER NOT NULL,
    step_no       INTEGER NOT NULL,                         -- 步骤序号 1,2,3...
    content       TEXT    NOT NULL,                         -- 步骤描述
    duration_sec  INTEGER,                                  -- 该步骤时长(秒,可选)
    tip           TEXT,                                     -- 小贴士(可选)
    FOREIGN KEY (recipe_id) REFERENCES recipe(id) ON DELETE CASCADE,
    UNIQUE (recipe_id, step_no)
);

CREATE INDEX IF NOT EXISTS idx_step_recipe ON step(recipe_id);

-- ----------------------------
-- 4. tag · 标签字典(全局唯一)
-- ----------------------------
CREATE TABLE IF NOT EXISTS tag (
    id       INTEGER PRIMARY KEY AUTOINCREMENT,
    name     TEXT    NOT NULL UNIQUE,                       -- 标签名,如 "辣"、"低糖"、"快手"、"减脂"
    category TEXT    NOT NULL DEFAULT 'flavor'              -- 类别:flavor(风味)/scenario(场景)/diet(饮食)/cuisine(菜系补充)
             CHECK (category IN ('flavor', 'scenario', 'diet', 'cuisine'))
);

CREATE INDEX IF NOT EXISTS idx_tag_category ON tag(category);

-- ----------------------------
-- 5. nutrition · 营养(每菜聚合后一份)
-- ----------------------------
CREATE TABLE IF NOT EXISTS nutrition (
    id            INTEGER PRIMARY KEY AUTOINCREMENT,
    recipe_id     INTEGER NOT NULL UNIQUE,                  -- 一对一:每菜一份聚合营养
    calories_kcal REAL    NOT NULL DEFAULT 0,               -- 热量(千卡/份)
    protein_g     REAL    NOT NULL DEFAULT 0,               -- 蛋白质(克/份)
    carb_g        REAL    NOT NULL DEFAULT 0,               -- 碳水(克/份)
    fat_g         REAL    NOT NULL DEFAULT 0,               -- 脂肪(克/份)
    fiber_g       REAL    NOT NULL DEFAULT 0,               -- 膳食纤维(克/份)
    sodium_mg     REAL    NOT NULL DEFAULT 0,               -- 钠(毫克/份)
    source        TEXT    NOT NULL DEFAULT '估算',           -- 数据来源:中国食物成分表/USDA/估算/混合
    note          TEXT,                                     -- 备注:数据精度/参考份量
    FOREIGN KEY (recipe_id) REFERENCES recipe(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_nutrition_recipe ON nutrition(recipe_id);
CREATE INDEX IF NOT EXISTS idx_nutrition_cal    ON nutrition(calories_kcal);  -- 减脂推荐用

-- ----------------------------
-- 6. recipe_tag · 菜谱 ↔ 标签 多对多桥接
-- ----------------------------
CREATE TABLE IF NOT EXISTS recipe_tag (
    recipe_id  INTEGER NOT NULL,
    tag_id     INTEGER NOT NULL,
    PRIMARY KEY (recipe_id, tag_id),
    FOREIGN KEY (recipe_id) REFERENCES recipe(id) ON DELETE CASCADE,
    FOREIGN KEY (tag_id)    REFERENCES tag(id)    ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_recipe_tag_tag ON recipe_tag(tag_id);

-- ============================================================================
-- 初始化:塞入 8 大菜系标签字典(便于 Phase 0 任务 2 菜谱提取时直接打标)
-- ============================================================================
INSERT OR IGNORE INTO tag (name, category) VALUES
    ('川菜', 'cuisine'), ('鲁菜', 'cuisine'), ('粤菜', 'cuisine'),
    ('淮扬菜', 'cuisine'), ('浙菜', 'cuisine'), ('闽菜', 'cuisine'),
    ('徽菜', 'cuisine'), ('湘菜', 'cuisine'),
    -- 风味
    ('麻辣', 'flavor'), ('咸鲜', 'flavor'), ('清淡', 'flavor'), ('酸甜', 'flavor'),
    -- 场景
    ('快手', 'scenario'), ('宴客', 'scenario'), ('便当', 'scenario'), ('宵夜', 'scenario'),
    -- 饮食目标
    ('低糖', 'diet'), ('低脂', 'diet'), ('减脂', 'diet'), ('增肌', 'diet'),
    ('高蛋白', 'diet'), ('控盐', 'diet'), ('素食', 'diet');

-- ============================================================================
-- v0.1 schema 结束 · 后续 Phase 1 视需要扩展:
--   - allergen(过敏原字典) + recipe_allergen(多对多)
--   - cuisine(菜系字典,便于国际化)
--   - equipment(厨电,如"空气炸锅"标签)
--   - user_favorites / user_history(用户行为,需鉴权)
-- 迁移要点(SQLite → PostgreSQL):
--   1. INTEGER PRIMARY KEY AUTOINCREMENT → SERIAL 或 BIGSERIAL
--   2. TEXT 时间戳 → TIMESTAMP WITH TIME ZONE
--   3. CHECK 约束语法完全兼容
--   4. json 字段(如需存结构化 source_ref)改用 JSONB
-- ============================================================================
