-- ============================================================================
-- GourmetAdvisor · 菜谱 Seed 数据 v0.1
-- 项目代号:GourmetAdvisor · 内部代号 03-美食 · 2026-08-27
-- 关联文件:schema.sql(同目录)· 项目开发计划.md Phase 0 · 任务 2 起步
-- 数据来源:知识库 _GourmetLib/09_健康快手食谱/健康快手食谱.md
-- 数据量:10 道(目标 200+,v0.1 首批 5 道 + v0.2 追加 5 道 2026-08-28)
-- 执行:sqlite3 gourmet.db < schema.sql && sqlite3 gourmet.db < seed_recipes.sql
-- ============================================================================

-- ============================================================================
-- 1. 隔夜燕麦(早餐 · 3 分钟 · 低糖 · 快手)
-- ============================================================================
INSERT INTO recipe (name, cuisine, difficulty, prep_time_min, cook_time_min, servings,
                    description, source, source_ref, is_ai_generated)
VALUES ('隔夜燕麦', '西餐', 1, 3, 0, 1,
        'No-Cook 隔夜燕麦,早起即食,适合控糖/减脂人群',
        '知识库', '../../_GourmetLib/09_健康快手食谱/健康快手食谱.md#L36', 0);

INSERT INTO ingredient (recipe_id, name, qty, unit, note, is_optional, order_no) VALUES
    (1, '燕麦片', 50, 'g', '即食型', 0, 1),
    (1, '牛奶', 150, 'ml', '或用酸奶', 0, 2),
    (1, '奇亚籽', 1, '勺', NULL, 1, 3),
    (1, '香蕉', 1, '根', '切片', 0, 4),
    (1, '蓝莓', 30, 'g', NULL, 0, 5),
    (1, '蜂蜜', 1, '小勺', '或枫糖浆', 1, 6);

INSERT INTO step (recipe_id, step_no, content, duration_sec, tip) VALUES
    (1, 1, '前一晚:燕麦+牛奶+奇亚籽混合,盖盖放冰箱', NULL, '密封防串味'),
    (1, 2, '早上:取出,加香蕉片+蓝莓+蜂蜜', NULL, NULL);

INSERT INTO nutrition (recipe_id, calories_kcal, protein_g, carb_g, fat_g, fiber_g, sodium_mg, source, note) VALUES
    (1, 380, 14, 62, 8, 9, 95, '估算', '蜂蜜按 1 小勺 5g 计,酸奶/牛奶按脂肪 3%');

INSERT OR IGNORE INTO tag (name, category) VALUES ('早餐', 'scenario');
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 1, id FROM tag WHERE name = '早餐' AND category = 'scenario';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 1, id FROM tag WHERE name = '快手' AND category = 'scenario';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 1, id FROM tag WHERE name = '低糖' AND category = 'diet';

-- ============================================================================
-- 2. 牛油果鸡蛋吐司(早餐 · 5 分钟 · 减脂 · 快手)
-- ============================================================================
INSERT INTO recipe (name, cuisine, difficulty, prep_time_min, cook_time_min, servings,
                    description, source, source_ref, is_ai_generated)
VALUES ('牛油果鸡蛋吐司', '西餐', 1, 3, 2, 1,
        '5 分钟搞定的健康早餐,优质脂肪 + 蛋白质组合',
        '知识库', '../../_GourmetLib/09_健康快手食谱/健康快手食谱.md#L53', 0);

INSERT INTO ingredient (recipe_id, name, qty, unit, note, is_optional, order_no) VALUES
    (2, '全麦面包', 2, '片', NULL, 0, 1),
    (2, '牛油果', 0.5, '个', '压泥', 0, 2),
    (2, '鸡蛋', 1, '个', '太阳蛋或水煮', 0, 3),
    (2, '柠檬汁', 0.5, '勺', '防氧化', 0, 4),
    (2, '黑胡椒', 0.5, 'g', NULL, 0, 5),
    (2, '辣椒片', 0.5, 'g', NULL, 1, 6);

INSERT INTO step (recipe_id, step_no, content, duration_sec, tip) VALUES
    (2, 1, '面包烤 2 分钟(可跳过)', 120, '吐司机中火'),
    (2, 2, '牛油果压泥 + 柠檬汁 + 盐拌匀', 30, NULL),
    (2, 3, '煎一个太阳蛋(或水煮蛋切片)', 180, '中小火盖盖焖,蛋黄溏心'),
    (2, 4, '牛油果抹面包,铺上鸡蛋,撒黑胡椒', 20, NULL);

INSERT INTO nutrition (recipe_id, calories_kcal, protein_g, carb_g, fat_g, fiber_g, sodium_mg, source, note) VALUES
    (2, 420, 18, 38, 22, 8, 380, '估算', '牛油果脂肪按 15g/半个,全麦面包按 30g/片');

INSERT OR IGNORE INTO tag (name, category) VALUES ('高蛋白', 'diet');
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 2, id FROM tag WHERE name = '高蛋白' AND category = 'diet';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 2, id FROM tag WHERE name = '快手' AND category = 'scenario';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 2, id FROM tag WHERE name = '减脂' AND category = 'diet';

-- ============================================================================
-- 3. 蒜蓉西兰花炒鸡胸(午餐/晚餐 · 10 分钟 · 高蛋白 · 低脂)
-- ============================================================================
INSERT INTO recipe (name, cuisine, difficulty, prep_time_min, cook_time_min, servings,
                    description, source, source_ref, is_ai_generated)
VALUES ('蒜蓉西兰花炒鸡胸', '粤菜', 2, 5, 10, 2,
        '一锅出 · 蛋白 + 蔬菜,减脂增肌通用',
        '知识库', '../../_GourmetLib/09_健康快手食谱/健康快手食谱.md#L92', 0);

INSERT INTO ingredient (recipe_id, name, qty, unit, note, is_optional, order_no) VALUES
    (3, '鸡胸肉', 200, 'g', '横切薄片', 0, 1),
    (3, '西兰花', 300, 'g', '切小朵', 0, 2),
    (3, '大蒜', 5, '瓣', '切末', 0, 3),
    (3, '盐', 2, 'g', NULL, 0, 4),
    (3, '料酒', 1, '勺', NULL, 0, 5),
    (3, '生抽', 1, '勺', NULL, 0, 6),
    (3, '黑胡椒', 0.5, 'g', NULL, 1, 7);

INSERT INTO step (recipe_id, step_no, content, duration_sec, tip) VALUES
    (3, 1, '鸡胸切薄片(横切易熟)+ 盐 + 料酒腌制', 180, '横切纤维断,易熟且嫩'),
    (3, 2, '热锅冷油,中火煎鸡胸,每面 3 分钟至金黄', 360, '锅够热再下,锁水'),
    (3, 3, '同一锅,加蒜末爆香,下西兰花大火快炒', 60, NULL),
    (3, 4, '加盐 + 少许水,盖盖焖 2 分钟至断生', 120, '不要盖太久,西兰花会发黄');

INSERT INTO nutrition (recipe_id, calories_kcal, protein_g, carb_g, fat_g, fiber_g, sodium_mg, source, note) VALUES
    (3, 320, 46, 12, 9, 6, 580, '估算', '鸡胸脂肪按 3% 算,2 人份分摊');

INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 3, id FROM tag WHERE name = '高蛋白' AND category = 'diet';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 3, id FROM tag WHERE name = '低脂' AND category = 'diet';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 3, id FROM tag WHERE name = '快手' AND category = 'scenario';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 3, id FROM tag WHERE name = '粤菜' AND category = 'cuisine';

-- ============================================================================
-- 4. 番茄鸡蛋粉丝(午餐/晚餐 · 10 分钟 · 咸鲜 · 快手)
-- ============================================================================
INSERT INTO recipe (name, cuisine, difficulty, prep_time_min, cook_time_min, servings,
                    description, source, source_ref, is_ai_generated)
VALUES ('番茄鸡蛋粉丝', '川菜', 1, 3, 7, 2,
        '国民家常菜,汤汁浓郁,厨房零基础也能做',
        '知识库', '../../_GourmetLib/09_健康快手食谱/健康快手食谱.md#L110', 0);

INSERT INTO ingredient (recipe_id, name, qty, unit, note, is_optional, order_no) VALUES
    (4, '番茄', 2, '个', '切块', 0, 1),
    (4, '鸡蛋', 2, '个', '打散', 0, 2),
    (4, '粉丝', 100, 'g', '冷水泡软', 0, 3),
    (4, '葱花', 5, 'g', NULL, 0, 4),
    (4, '盐', 3, 'g', NULL, 0, 5),
    (4, '生抽', 1, '勺', NULL, 0, 6);

INSERT INTO step (recipe_id, step_no, content, duration_sec, tip) VALUES
    (4, 1, '粉丝冷水泡软(提前 5 分钟泡)', 300, '热水泡会坨'),
    (4, 2, '鸡蛋炒散,盛出备用', 90, '八成熟盛出,后面会再加热'),
    (4, 3, '番茄下锅炒出汁(加少许盐促出汁)', 180, '加盐析水,加速出汁'),
    (4, 4, '加水 400ml 烧开,下粉丝煮 2 分钟', 120, NULL),
    (4, 5, '加鸡蛋、生抽调味,撒葱花', 30, NULL);

INSERT INTO nutrition (recipe_id, calories_kcal, protein_g, carb_g, fat_g, fiber_g, sodium_mg, source, note) VALUES
    (4, 380, 16, 58, 9, 3, 720, '估算', '粉丝碳水高,2 人份分摊');

INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 4, id FROM tag WHERE name = '川菜' AND category = 'cuisine';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 4, id FROM tag WHERE name = '咸鲜' AND category = 'flavor';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 4, id FROM tag WHERE name = '快手' AND category = 'scenario';

-- ============================================================================
-- 5. 麻婆豆腐(20 分钟进阶 · 川菜 · 麻辣 · 经典)
-- ============================================================================
INSERT INTO recipe (name, cuisine, difficulty, prep_time_min, cook_time_min, servings,
                    description, source, source_ref, is_ai_generated)
VALUES ('麻婆豆腐', '川菜', 3, 5, 15, 2,
        '川菜经典 · 麻辣鲜香烫,豆腐嫩而不碎',
        '知识库', '../../_GourmetLib/09_健康快手食谱/健康快手食谱.md#L188', 0);

INSERT INTO ingredient (recipe_id, name, qty, unit, note, is_optional, order_no) VALUES
    (5, '嫩豆腐', 1, '盒', '内酯豆腐,切 1.5cm 方块', 0, 1),
    (5, '猪肉末', 100, 'g', '肥瘦 3:7', 0, 2),
    (5, '豆瓣酱', 1, '勺', '郫县豆瓣', 0, 3),
    (5, '蒜末', 5, 'g', NULL, 0, 4),
    (5, '姜末', 5, 'g', NULL, 0, 5),
    (5, '葱花', 5, 'g', NULL, 0, 6),
    (5, '花椒粉', 2, 'g', '出锅撒', 0, 7),
    (5, '辣椒粉', 2, 'g', '出锅撒', 1, 8),
    (5, '生抽', 1, '勺', NULL, 0, 9),
    (5, '淀粉', 0.5, '勺', '勾芡', 0, 10);

INSERT INTO step (recipe_id, step_no, content, duration_sec, tip) VALUES
    (5, 1, '豆腐切 1.5cm 方块,焯水(去豆腥)', 120, '盐水焯不易碎'),
    (5, 2, '热锅冷油,下肉末炒散变色', 90, NULL),
    (5, 3, '加豆瓣酱 + 蒜末 + 姜末,小火炒出红油', 60, '小火防糊'),
    (5, 4, '加水/高汤 200ml,下豆腐,中火煮 3 分钟', 180, '不要用锅铲翻,晃锅'),
    (5, 5, '加生抽调味,淀粉水勾薄芡', 60, '分两次勾,薄芡'),
    (5, 6, '出锅撒花椒粉 + 葱花 + 辣椒粉', 15, '出锅再撒,保留香气');

INSERT INTO nutrition (recipe_id, calories_kcal, protein_g, carb_g, fat_g, fiber_g, sodium_mg, source, note) VALUES
    (5, 320, 22, 12, 21, 2, 980, '估算', '豆瓣酱钠高,2 人份分摊');

INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 5, id FROM tag WHERE name = '川菜' AND category = 'cuisine';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 5, id FROM tag WHERE name = '麻辣' AND category = 'flavor';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 5, id FROM tag WHERE name = '宴客' AND category = 'scenario';

-- ============================================================================
-- 6. 凉拌黄瓜(凉菜 · 3 分钟 · 鲁菜 · 爽口 · 快手)
-- ============================================================================
INSERT INTO recipe (name, cuisine, difficulty, prep_time_min, cook_time_min, servings,
                    description, source, source_ref, is_ai_generated)
VALUES ('凉拌黄瓜', '鲁菜', 1, 3, 0, 2,
        '夏日必备 · 拍黄瓜 · 酸辣开胃,3 分钟搞定',
        '知识库', '../../_GourmetLib/09_健康快手食谱/健康快手食谱.md#L236', 0);

INSERT INTO ingredient (recipe_id, name, qty, unit, note, is_optional, order_no) VALUES
    (6, '黄瓜', 2, '根', '拍碎切段', 0, 1),
    (6, '蒜末', 5, 'g', NULL, 0, 2),
    (6, '香醋', 1, '勺', NULL, 0, 3),
    (6, '生抽', 1, '勺', NULL, 0, 4),
    (6, '香油', 0.5, '勺', NULL, 0, 5),
    (6, '辣椒油', 0.5, '勺', NULL, 1, 6),
    (6, '白糖', 0.5, '勺', '中和酸味', 1, 7),
    (6, '盐', 1, 'g', NULL, 0, 8);

INSERT INTO step (recipe_id, step_no, content, duration_sec, tip) VALUES
    (6, 1, '黄瓜洗净,刀背拍碎切段(不切断)', 30, '拍比切更入味'),
    (6, 2, '加盐腌 5 分钟出水,挤干', 300, '出水后再调味更脆'),
    (6, 3, '蒜末 + 香醋 + 生抽 + 香油 + 糖 + 辣椒油 调汁', 30, NULL),
    (6, 4, '汁拌黄瓜,冰箱冷藏 10 分钟风味更佳', NULL, '现做现吃也行');

INSERT INTO nutrition (recipe_id, calories_kcal, protein_g, carb_g, fat_g, fiber_g, sodium_mg, source, note) VALUES
    (6, 60, 2, 8, 3, 2, 580, '估算', '低卡凉菜,2 人份分摊');

INSERT OR IGNORE INTO tag (name, category) VALUES ('鲁菜', 'cuisine');
INSERT OR IGNORE INTO tag (name, category) VALUES ('凉菜', 'scenario');
INSERT OR IGNORE INTO tag (name, category) VALUES ('酸辣', 'flavor');
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 6, id FROM tag WHERE name = '鲁菜' AND category = 'cuisine';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 6, id FROM tag WHERE name = '快手' AND category = 'scenario';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 6, id FROM tag WHERE name = '凉菜' AND category = 'scenario';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 6, id FROM tag WHERE name = '酸辣' AND category = 'flavor';

-- ============================================================================
-- 7. 番茄蛋花汤(汤品 · 10 分钟 · 粤菜 · 咸鲜 · 暖胃)
-- ============================================================================
INSERT INTO recipe (name, cuisine, difficulty, prep_time_min, cook_time_min, servings,
                    description, source, source_ref, is_ai_generated)
VALUES ('番茄蛋花汤', '粤菜', 1, 3, 7, 2,
        '国民汤品 · 番茄酸甜 + 蛋花滑嫩,5 分钟上桌',
        '知识库', '../../_GourmetLib/04_膳食搭配与配比原则/膳食搭配原则.md', 0);

INSERT INTO ingredient (recipe_id, name, qty, unit, note, is_optional, order_no) VALUES
    (7, '番茄', 2, '个', '去皮切块', 0, 1),
    (7, '鸡蛋', 2, '个', '打散', 0, 2),
    (7, '葱花', 5, 'g', NULL, 0, 3),
    (7, '盐', 2, 'g', NULL, 0, 4),
    (7, '香油', 0.5, '勺', NULL, 0, 5),
    (7, '生抽', 0.5, '勺', '可选调色', 1, 6);

INSERT INTO step (recipe_id, step_no, content, duration_sec, tip) VALUES
    (7, 1, '番茄顶部划十字,开水烫 30 秒去皮', 60, '去皮口感更滑'),
    (7, 2, '热锅冷油,番茄下锅炒出汁(加少许盐促出汁)', 180, '小火慢炒,出红油'),
    (7, 3, '加水 600ml 烧开,转中火煮 3 分钟', 180, NULL),
    (7, 4, '蛋液画圈淋入,等 5 秒再轻搅成蛋花', 30, '不要立刻搅,蛋花更整齐'),
    (7, 5, '加盐调味,撒葱花淋香油', 15, NULL);

INSERT INTO nutrition (recipe_id, calories_kcal, protein_g, carb_g, fat_g, fiber_g, sodium_mg, source, note) VALUES
    (7, 140, 11, 10, 7, 2, 520, '估算', '低卡汤品,2 人份分摊');

INSERT OR IGNORE INTO tag (name, category) VALUES ('汤品', 'scenario');
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 7, id FROM tag WHERE name = '汤品' AND category = 'scenario';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 7, id FROM tag WHERE name = '粤菜' AND category = 'cuisine';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 7, id FROM tag WHERE name = '咸鲜' AND category = 'flavor';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 7, id FROM tag WHERE name = '快手' AND category = 'scenario';

-- ============================================================================
-- 8. 宫保鸡丁(主菜 · 15 分钟 · 川菜 · 糊辣酸甜 · 经典)
-- ============================================================================
INSERT INTO recipe (name, cuisine, difficulty, prep_time_min, cook_time_min, servings,
                    description, source, source_ref, is_ai_generated)
VALUES ('宫保鸡丁', '川菜', 3, 8, 8, 2,
        '川菜经典 · 糊辣酸甜 + 鸡丁嫩滑 + 花生酥脆',
        '知识库', '../../_GourmetLib/09_健康快手食谱/健康快手食谱.md#L163', 0);

INSERT INTO ingredient (recipe_id, name, qty, unit, note, is_optional, order_no) VALUES
    (8, '鸡腿肉', 250, 'g', '去骨切 1.5cm 丁', 0, 1),
    (8, '花生米', 50, 'g', '油酥', 0, 2),
    (8, '干辣椒', 8, '个', '剪段去籽', 0, 3),
    (8, '花椒', 1, '勺', NULL, 0, 4),
    (8, '葱白', 15, 'g', '切段', 0, 5),
    (8, '蒜末', 5, 'g', NULL, 0, 6),
    (8, '姜末', 3, 'g', NULL, 0, 7),
    (8, '生抽', 1, '勺', NULL, 0, 8),
    (8, '香醋', 1, '勺', NULL, 0, 9),
    (8, '白糖', 1, '勺', '酸甜平衡', 0, 10),
    (8, '料酒', 1, '勺', NULL, 0, 11),
    (8, '淀粉', 1, '勺', '上浆', 0, 12),
    (8, '盐', 1, 'g', NULL, 0, 13);

INSERT INTO step (recipe_id, step_no, content, duration_sec, tip) VALUES
    (8, 1, '鸡丁 + 盐 + 料酒 + 淀粉上浆,腌 10 分钟', 600, '上浆锁水,鸡丁嫩滑'),
    (8, 2, '调汁:生抽+醋+糖+少量水(2:2:2:1)备用', 30, '提前调汁,避免手忙脚乱'),
    (8, 3, '热油滑炒鸡丁至变色,盛出备用', 90, '六成熟盛出,后面会回锅'),
    (8, 4, '锅底油,小火煸花椒 + 干辣椒至深红色', 60, '小火防糊,出糊辣香'),
    (8, 5, '下葱白蒜末姜末爆香,下鸡丁大火快炒', 30, NULL),
    (8, 6, '淋入调汁,翻炒挂芡,加花生米颠锅', 30, '出锅前下花生,保脆');

INSERT INTO nutrition (recipe_id, calories_kcal, protein_g, carb_g, fat_g, fiber_g, sodium_mg, source, note) VALUES
    (8, 460, 32, 18, 28, 3, 780, '估算', '花生油脂高,2 人份分摊');

INSERT OR IGNORE INTO tag (name, category) VALUES ('糊辣', 'flavor');
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 8, id FROM tag WHERE name = '川菜' AND category = 'cuisine';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 8, id FROM tag WHERE name = '麻辣' AND category = 'flavor';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 8, id FROM tag WHERE name = '糊辣' AND category = 'flavor';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 8, id FROM tag WHERE name = '宴客' AND category = 'scenario';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 8, id FROM tag WHERE name = '高蛋白' AND category = 'diet';

-- ============================================================================
-- 9. 红烧肉(主菜 · 40 分钟 · 浙菜 · 咸甜 · 宴客大菜)
-- ============================================================================
INSERT INTO recipe (name, cuisine, difficulty, prep_time_min, cook_time_min, servings,
                    description, source, source_ref, is_ai_generated)
VALUES ('红烧肉', '浙菜', 3, 10, 30, 3,
        '浙菜经典 · 肥而不腻 · 入口即化 · 色泽红亮',
        '知识库', '../../_GourmetLib/07_中式养生食疗/中式养生食疗.md', 0);

INSERT INTO ingredient (recipe_id, name, qty, unit, note, is_optional, order_no) VALUES
    (9, '五花肉', 500, 'g', '带皮,切 3cm 方块', 0, 1),
    (9, '冰糖', 30, 'g', '炒糖色', 0, 2),
    (9, '生抽', 2, '勺', NULL, 0, 3),
    (9, '老抽', 0.5, '勺', '上色', 0, 4),
    (9, '料酒', 2, '勺', NULL, 0, 5),
    (9, '葱段', 15, 'g', NULL, 0, 6),
    (9, '姜片', 10, 'g', NULL, 0, 7),
    (9, '八角', 2, '个', NULL, 0, 8),
    (9, '香叶', 2, '片', NULL, 1, 9),
    (9, '盐', 2, 'g', '后下', 0, 10);

INSERT INTO step (recipe_id, step_no, content, duration_sec, tip) VALUES
    (9, 1, '五花肉冷水下锅焯水,撇浮沫,捞出沥干', 300, '冷水下锅,血水出得更彻底'),
    (9, 2, '小火,冰糖炒至枣红色(糖色)', 180, '小火,糖色过了会苦'),
    (9, 3, '下五花肉快速翻炒上色', 60, '上色均匀,后面炖出来才红亮'),
    (9, 4, '加葱姜八角香叶,淋料酒,加生抽老抽', 30, NULL),
    (9, 5, '加热水没过肉,大火烧开转小火炖 30 分钟', 1800, '小火慢炖,肥肉部分会化'),
    (9, 6, '最后 10 分钟大火收汁,加盐调味', 600, '收汁阶段多翻动,挂色均匀');

INSERT INTO nutrition (recipe_id, calories_kcal, protein_g, carb_g, fat_g, fiber_g, sodium_mg, source, note) VALUES
    (9, 580, 28, 12, 46, 0, 720, '估算', '高脂大菜,3 人份分摊;痛风/三高慎食');

INSERT OR IGNORE INTO tag (name, category) VALUES ('浙菜', 'cuisine');
INSERT OR IGNORE INTO tag (name, category) VALUES ('咸甜', 'flavor');
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 9, id FROM tag WHERE name = '浙菜' AND category = 'cuisine';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 9, id FROM tag WHERE name = '咸甜' AND category = 'flavor';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 9, id FROM tag WHERE name = '宴客' AND category = 'scenario';

-- ============================================================================
-- 10. 蛋炒饭(主食 · 10 分钟 · 中式 · 咸鲜 · 厨房入门)
-- ============================================================================
INSERT INTO recipe (name, cuisine, difficulty, prep_time_min, cook_time_min, servings,
                    description, source, source_ref, is_ai_generated)
VALUES ('蛋炒饭', '中式', 1, 5, 5, 1,
        '厨房入门第一课 · 蛋裹饭粒 · 粒粒分明',
        '知识库', '../../_GourmetLib/09_健康快手食谱/健康快手食谱.md', 0);

INSERT INTO ingredient (recipe_id, name, qty, unit, note, is_optional, order_no) VALUES
    (10, '隔夜米饭', 300, 'g', '冷饭更易炒散', 0, 1),
    (10, '鸡蛋', 2, '个', '打散', 0, 2),
    (10, '葱花', 10, 'g', '分两次', 0, 3),
    (10, '生抽', 1, '勺', '调色提鲜', 0, 4),
    (10, '盐', 2, 'g', NULL, 0, 5),
    (10, '料酒', 0.5, '勺', '去蛋腥', 0, 6),
    (10, '火腿丁', 50, 'g', '或用腊肠/虾仁', 1, 7);

INSERT INTO step (recipe_id, step_no, content, duration_sec, tip) VALUES
    (10, 1, '鸡蛋打散 + 料酒 + 少许盐,备用', 30, '加料酒去腥更嫩'),
    (10, 2, '热锅热油,蛋液下锅快速划散至半凝固', 30, '油要够热,蛋花才嫩'),
    (10, 3, '立刻下冷饭,中火压散饭团,翻炒 2 分钟', 120, '饭要压散,粒粒分明'),
    (10, 4, '加火腿丁、葱花一半、生抽,大火快炒 30 秒', 30, '生抽沿锅边淋,出锅气'),
    (10, 5, '出锅前撒剩余葱花,颠锅 2 下', 10, '葱花最后下,香气足');

INSERT INTO nutrition (recipe_id, calories_kcal, protein_g, carb_g, fat_g, fiber_g, sodium_mg, source, note) VALUES
    (10, 520, 18, 72, 16, 1, 680, '估算', '主食量足,1 人份');

INSERT OR IGNORE INTO tag (name, category) VALUES ('中式', 'cuisine');
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 10, id FROM tag WHERE name = '中式' AND category = 'cuisine';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 10, id FROM tag WHERE name = '咸鲜' AND category = 'flavor';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 10, id FROM tag WHERE name = '快手' AND category = 'scenario';

-- ============================================================================
-- v0.2 seed 结束 · 10 道菜谱已就位
-- 验证方法:
--   sqlite3 gourmet.db < db/schema.sql
--   sqlite3 gourmet.db < db/seed_recipes.sql
--   sqlite3 gourmet.db "SELECT r.name, r.cuisine, COUNT(i.id) AS ingredients
--                       FROM recipe r LEFT JOIN ingredient i ON i.recipe_id = r.id
--                       GROUP BY r.id ORDER BY r.id;"
-- 预期:
--   隔夜燕麦|西餐|6
--   牛油果鸡蛋吐司|西餐|6
--   蒜蓉西兰花炒鸡胸|粤菜|7
--   番茄鸡蛋粉丝|川菜|6
--   麻婆豆腐|川菜|10
--   凉拌黄瓜|鲁菜|8
--   番茄蛋花汤|粤菜|6
--   宫保鸡丁|川菜|13
--   红烧肉|浙菜|10
--   蛋炒饭|中式|7
-- ============================================================================
