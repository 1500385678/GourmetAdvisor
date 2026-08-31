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
-- v0.3 seed · 2026-08-29 追加 5 道(11-15),覆盖蒸菜/凉菜/素食/中式/西餐越南菜
-- ============================================================================

-- ============================================================================
-- 11. 蔬菜蛋饼 · 微波炉版(早餐 · 4 分钟 · 快手 · 高蛋白)
-- ============================================================================
INSERT INTO recipe (name, cuisine, difficulty, prep_time_min, cook_time_min, servings,
                    description, source, source_ref, is_ai_generated)
VALUES ('蔬菜蛋饼', '中式', 1, 2, 2, 1,
        '微波炉版 · 4 分钟搞定 · 蔬菜 + 蛋白一锅出',
        '知识库', '../../_GourmetLib/09_健康快手食谱/健康快手食谱.md#L72', 0);

INSERT INTO ingredient (recipe_id, name, qty, unit, note, is_optional, order_no) VALUES
    (11, '鸡蛋', 2, '个', '打散', 0, 1),
    (11, '胡萝卜丝', 30, 'g', NULL, 0, 2),
    (11, '西葫芦丝', 30, 'g', '或换黄瓜丝', 0, 3),
    (11, '盐', 1, 'g', NULL, 0, 4),
    (11, '黑胡椒', 0.5, 'g', '出锅撒', 0, 5),
    (11, '油', 1, '小勺', '抹碗用', 0, 6);

INSERT INTO step (recipe_id, step_no, content, duration_sec, tip) VALUES
    (11, 1, '鸡蛋打散 + 胡萝卜丝 + 西葫芦丝 + 盐搅匀', 30, '丝要细,易熟'),
    (11, 2, '倒入抹油的小碗(微波可用),高火 2 分钟', 120, '碗底抹油,方便脱模'),
    (11, 3, '出锅撒黑胡椒,切块装盘', 10, '可挤少许番茄酱');

INSERT INTO nutrition (recipe_id, calories_kcal, protein_g, carb_g, fat_g, fiber_g, sodium_mg, source, note) VALUES
    (11, 220, 14, 8, 14, 2, 320, '估算', '微波少油,脂肪可控;1 人份');

INSERT OR IGNORE INTO tag (name, category) VALUES ('微波', 'scenario');
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 11, id FROM tag WHERE name = '早餐' AND category = 'scenario';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 11, id FROM tag WHERE name = '快手' AND category = 'scenario';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 11, id FROM tag WHERE name = '高蛋白' AND category = 'diet';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 11, id FROM tag WHERE name = '中式' AND category = 'cuisine';

-- ============================================================================
-- 12. 黄瓜拌鸡胸丝(凉菜 · 15 分钟 · 高蛋白 · 低脂 · 减脂)
-- ============================================================================
INSERT INTO recipe (name, cuisine, difficulty, prep_time_min, cook_time_min, servings,
                    description, source, source_ref, is_ai_generated)
VALUES ('黄瓜拌鸡胸丝', '中式', 1, 3, 12, 2,
        '手撕鸡丝 + 脆黄瓜 · 减脂增肌首选凉菜',
        '知识库', '../../_GourmetLib/09_健康快手食谱/健康快手食谱.md#L128', 0);

INSERT INTO ingredient (recipe_id, name, qty, unit, note, is_optional, order_no) VALUES
    (12, '鸡胸肉', 150, 'g', '整块煮', 0, 1),
    (12, '黄瓜', 2, '根', '切丝', 0, 2),
    (12, '姜片', 5, 'g', '煮鸡用', 0, 3),
    (12, '生抽', 1, '勺', NULL, 0, 4),
    (12, '香醋', 1, '勺', NULL, 0, 5),
    (12, '蒜末', 5, 'g', NULL, 0, 6),
    (12, '香油', 0.5, '勺', NULL, 0, 7),
    (12, '辣椒油', 0.5, '勺', NULL, 1, 8),
    (12, '盐', 1, 'g', NULL, 0, 9);

INSERT INTO step (recipe_id, step_no, content, duration_sec, tip) VALUES
    (12, 1, '鸡胸整块冷水下锅 + 姜片,大火煮开转小火 12 分钟', 720, '冷水下锅,血沫出得彻底'),
    (12, 2, '捞出放凉(可冰水镇 2 分钟),沿纹理撕细丝', 180, '冰水镇后肉更紧实'),
    (12, 3, '黄瓜切丝,加少许盐腌 3 分钟出水,挤干', 180, '出水后更脆'),
    (12, 4, '鸡丝 + 黄瓜丝 + 蒜末 + 生抽 + 醋 + 香油 + 辣椒油 拌匀', 60, '现拌现吃,口感最佳');

INSERT INTO nutrition (recipe_id, calories_kcal, protein_g, carb_g, fat_g, fiber_g, sodium_mg, source, note) VALUES
    (12, 200, 28, 6, 6, 1, 520, '估算', '高蛋白低脂,2 人份分摊');

INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 12, id FROM tag WHERE name = '凉菜' AND category = 'scenario';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 12, id FROM tag WHERE name = '快手' AND category = 'scenario';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 12, id FROM tag WHERE name = '高蛋白' AND category = 'diet';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 12, id FROM tag WHERE name = '低脂' AND category = 'diet';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 12, id FROM tag WHERE name = '减脂' AND category = 'diet';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 12, id FROM tag WHERE name = '中式' AND category = 'cuisine';

-- ============================================================================
-- 13. 清蒸鲈鱼(主菜 · 13 分钟 · 粤菜 · 高蛋白 · 宴客)
-- ============================================================================
INSERT INTO recipe (name, cuisine, difficulty, prep_time_min, cook_time_min, servings,
                    description, source, source_ref, is_ai_generated)
VALUES ('清蒸鲈鱼', '粤菜', 2, 5, 8, 2,
        '粤菜经典蒸鱼 · 鱼肉嫩滑 · 宴客不输大菜',
        '知识库', '../../_GourmetLib/09_健康快手食谱/健康快手食谱.md#L143', 0);

INSERT INTO ingredient (recipe_id, name, qty, unit, note, is_optional, order_no) VALUES
    (13, '鲈鱼', 1, '条', '约 400g,处理干净', 0, 1),
    (13, '葱丝', 15, 'g', '铺面用', 0, 2),
    (13, '姜丝', 10, 'g', NULL, 0, 3),
    (13, '红椒丝', 5, 'g', '配色', 1, 4),
    (13, '蒸鱼豉油', 2, '勺', '或用生抽+糖调', 0, 5),
    (13, '料酒', 1, '勺', NULL, 0, 6),
    (13, '盐', 2, 'g', NULL, 0, 7),
    (13, '热油', 1, '勺', '葱丝上激香', 0, 8);

INSERT INTO step (recipe_id, step_no, content, duration_sec, tip) VALUES
    (13, 1, '鱼身两侧划几刀(方便入味),撒盐 + 料酒 + 姜片腌 5 分钟', 300, '划刀别太深,防断裂'),
    (13, 2, '水开后上锅,大火蒸 8 分钟(根据鱼大小 ±2 分钟)', 480, '水必须大开,蒸气足'),
    (13, 3, '出锅倒掉蒸盘里的水(去腥关键)', 15, '蒸出的水腥味重'),
    (13, 4, '铺葱丝 + 姜丝 + 红椒丝,淋蒸鱼豉油', 15, NULL),
    (13, 5, '烧热油至冒烟,淋在葱姜丝上激香', 30, '油温要够,激出葱香');

INSERT INTO nutrition (recipe_id, calories_kcal, protein_g, carb_g, fat_g, fiber_g, sodium_mg, source, note) VALUES
    (13, 240, 36, 1, 10, 0, 480, '估算', '高蛋白低脂,2 人份分摊');

INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 13, id FROM tag WHERE name = '粤菜' AND category = 'cuisine';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 13, id FROM tag WHERE name = '高蛋白' AND category = 'diet';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 13, id FROM tag WHERE name = '低脂' AND category = 'diet';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 13, id FROM tag WHERE name = '宴客' AND category = 'scenario';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 13, id FROM tag WHERE name = '清淡' AND category = 'flavor';

-- ============================================================================
-- 14. 蒜蓉粉丝蒸娃娃菜(蒸菜 · 15 分钟 · 粤菜 · 素食 · 低脂)
-- ============================================================================
INSERT INTO recipe (name, cuisine, difficulty, prep_time_min, cook_time_min, servings,
                    description, source, source_ref, is_ai_generated)
VALUES ('蒜蓉粉丝蒸娃娃菜', '粤菜', 2, 7, 8, 2,
        '素食蒸菜 · 蒜香浓郁 · 粉丝吸汁一绝',
        '知识库', '../../_GourmetLib/09_健康快手食谱/健康快手食谱.md#L208', 0);

INSERT INTO ingredient (recipe_id, name, qty, unit, note, is_optional, order_no) VALUES
    (14, '娃娃菜', 2, '棵', '切 6 瓣', 0, 1),
    (14, '粉丝', 50, 'g', '冷水泡软', 0, 2),
    (14, '蒜末', 30, 'g', '3 勺量,蒜香关键', 0, 3),
    (14, '生抽', 1.5, '勺', NULL, 0, 4),
    (14, '蚝油', 1, '勺', NULL, 0, 5),
    (14, '白糖', 0.5, '勺', '提鲜', 0, 6),
    (14, '盐', 1, 'g', '焯水用', 0, 7),
    (14, '葱花', 5, 'g', '出锅撒', 0, 8),
    (14, '热油', 1, '勺', '激蒜香', 0, 9);

INSERT INTO step (recipe_id, step_no, content, duration_sec, tip) VALUES
    (14, 1, '娃娃菜切 6 瓣,沸水 + 少许盐焯 1 分钟,铺盘底', 60, '焯水保色,不发黄'),
    (14, 2, '泡软的粉丝铺在娃娃菜上', 30, '粉丝别太长,易夹'),
    (14, 3, '蒜末 + 生抽 + 蚝油 + 糖 调匀,淋在粉丝上', 30, '蒜要多才香'),
    (14, 4, '水开上锅,大火蒸 8 分钟', 480, '水开再上,蒸气足'),
    (14, 5, '出锅撒葱花,烧热油淋上激香', 30, '油温够热,葱香出');

INSERT INTO nutrition (recipe_id, calories_kcal, protein_g, carb_g, fat_g, fiber_g, sodium_mg, source, note) VALUES
    (14, 180, 5, 25, 7, 3, 620, '估算', '素食低脂,2 人份分摊');

INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 14, id FROM tag WHERE name = '粤菜' AND category = 'cuisine';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 14, id FROM tag WHERE name = '素食' AND category = 'diet';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 14, id FROM tag WHERE name = '低脂' AND category = 'diet';
INSERT OR IGNORE INTO tag (name, category) VALUES ('蒸菜', 'scenario');
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 14, id FROM tag WHERE name = '蒸菜' AND category = 'scenario';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 14, id FROM tag WHERE name = '咸鲜' AND category = 'flavor';

-- ============================================================================
-- 15. 越南春卷(凉菜 · 10 分钟 · 西餐 · 减脂 · 高蛋白)
-- ============================================================================
INSERT INTO recipe (name, cuisine, difficulty, prep_time_min, cook_time_min, servings,
                    description, source, source_ref, is_ai_generated)
VALUES ('越南春卷', '西餐', 2, 8, 2, 1,
        '低卡春卷 · 鲜虾 + 蔬菜 + 米纸 · 减脂餐颜值担当',
        '知识库', '../../_GourmetLib/09_健康快手食谱/健康快手食谱.md#L255', 0);

INSERT INTO ingredient (recipe_id, name, qty, unit, note, is_optional, order_no) VALUES
    (15, '越南米纸', 3, '张', '温水泡 10 秒', 0, 1),
    (15, '虾仁', 100, 'g', '提前烫熟', 0, 2),
    (15, '生菜', 2, '片', '撕小', 0, 3),
    (15, '黄瓜', 0.5, '根', '切条', 0, 4),
    (15, '胡萝卜', 0.5, '根', '切丝', 0, 5),
    (15, '薄荷叶', 5, 'g', '或罗勒叶', 0, 6),
    (15, '鱼露', 1, '勺', '蘸汁用', 0, 7),
    (15, '柠檬汁', 1, '勺', '蘸汁用', 0, 8),
    (15, '蒜末', 3, 'g', '蘸汁用', 0, 9),
    (15, '小米辣', 1, '个', '蘸汁用,切圈', 1, 10);

INSERT INTO step (recipe_id, step_no, content, duration_sec, tip) VALUES
    (15, 1, '米纸放入温水(常温即可)泡 10 秒变软,平铺案板', 10, '水别太热,米纸会化'),
    (15, 2, '中间铺生菜 + 胡萝卜丝 + 黄瓜条 + 薄荷 + 虾仁 2-3 只', 30, '食材控干水分'),
    (15, 3, '两边向中间折,再从下往上卷紧(类似卷寿司)', 30, '卷紧防散'),
    (15, 4, '调蘸汁:鱼露 + 柠檬汁 + 蒜末 + 小米辣 拌匀', 30, '酸辣开胃,蘸食');

INSERT INTO nutrition (recipe_id, calories_kcal, protein_g, carb_g, fat_g, fiber_g, sodium_mg, source, note) VALUES
    (15, 250, 20, 30, 5, 3, 580, '估算', '3 个春卷为 1 人份;米纸碳水低');

INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 15, id FROM tag WHERE name = '减脂' AND category = 'diet';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 15, id FROM tag WHERE name = '高蛋白' AND category = 'diet';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 15, id FROM tag WHERE name = '快手' AND category = 'scenario';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 15, id FROM tag WHERE name = '凉菜' AND category = 'scenario';

-- ============================================================================
-- 16. 蒜蓉蒸虾(海鲜 · 12 分钟 · 粤菜 · 高蛋白 · 宴客)
-- ============================================================================
INSERT INTO recipe (name, cuisine, difficulty, prep_time_min, cook_time_min, servings,
                    description, source, source_ref, is_ai_generated)
VALUES ('蒜蓉蒸虾', '粤菜', 2, 5, 7, 2,
        '蒜香大虾 · 鲜嫩多汁 · 5 分钟出锅',
        '知识库', '../../_GourmetLib/09_健康快手食谱/健康快手食谱.md#L312', 0);

INSERT INTO ingredient (recipe_id, name, qty, unit, note, is_optional, order_no) VALUES
    (16, '大虾', 12, '只', '约 400g,开背去虾线', 0, 1),
    (16, '蒜末', 40, 'g', '4 勺量,蒜香关键', 0, 2),
    (16, '生抽', 2, '勺', NULL, 0, 3),
    (16, '蚝油', 1, '勺', NULL, 0, 4),
    (16, '白糖', 0.5, '勺', '提鲜', 0, 5),
    (16, '料酒', 1, '勺', '去腥', 0, 6),
    (16, '葱花', 5, 'g', '出锅撒', 0, 7),
    (16, '热油', 2, '勺', '激蒜香', 0, 8),
    (16, '粉丝', 50, 'g', '铺底吸汁', 1, 9);

INSERT INTO step (recipe_id, step_no, content, duration_sec, tip) VALUES
    (16, 1, '大虾开背去虾线,留尾,平铺盘(可用粉丝铺底)', 60, '开背要深,入味'),
    (16, 2, '蒜末 + 生抽 + 蚝油 + 糖 + 料酒 调匀,淋在虾上', 30, '蒜末一半生一半熟更香'),
    (16, 3, '水开上锅,大火蒸 5 分钟(虾变色卷起即熟)', 300, '别超 6 分钟,虾肉老'),
    (16, 4, '出锅撒葱花,烧热油淋上激香', 30, '油温够热,蒜香出');

INSERT INTO nutrition (recipe_id, calories_kcal, protein_g, carb_g, fat_g, fiber_g, sodium_mg, source, note) VALUES
    (16, 320, 38, 6, 16, 1, 720, '估算', '2 人份分摊;高蛋白海鲜');

INSERT OR IGNORE INTO tag (name, category) VALUES ('海鲜', 'flavor');
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 16, id FROM tag WHERE name = '海鲜' AND category = 'flavor';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 16, id FROM tag WHERE name = '高蛋白' AND category = 'diet';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 16, id FROM tag WHERE name = '蒸菜' AND category = 'scenario';

-- ============================================================================
-- 17. 牛奶鸡蛋羹(早餐 · 8 分钟 · 中式 · 微波 · 宵夜)
-- ============================================================================
INSERT INTO recipe (name, cuisine, difficulty, prep_time_min, cook_time_min, servings,
                    description, source, source_ref, is_ai_generated)
VALUES ('牛奶鸡蛋羹', '中式', 1, 3, 5, 1,
        '微波炉 5 分钟搞定的嫩滑蛋羹,像布丁一样',
        '知识库', '../../_GourmetLib/09_健康快手食谱/健康快手食谱.md#L340', 0);

INSERT INTO ingredient (recipe_id, name, qty, unit, note, is_optional, order_no) VALUES
    (17, '鸡蛋', 2, '个', '常温', 0, 1),
    (17, '牛奶', 200, 'ml', '或温水', 0, 2),
    (17, '盐', 1, 'g', '提底味', 0, 3),
    (17, '生抽', 0.5, '勺', '调味', 0, 4),
    (17, '香油', 0.5, '勺', '增香', 0, 5),
    (17, '葱花', 3, 'g', '点缀', 0, 6),
    (17, '虾皮', 1, 'g', '提鲜', 1, 7);

INSERT INTO step (recipe_id, step_no, content, duration_sec, tip) VALUES
    (17, 1, '鸡蛋打散,加牛奶 + 盐 搅匀(1:1.5 蛋液:奶比例最嫩)', 30, '别打太发,有气泡'),
    (17, 2, '过筛 1-2 次去掉气泡(嫩滑关键)', 30, '过筛不可省'),
    (17, 3, '盖保鲜膜,微波中火 3-4 分钟(中途观察防溢出)', 240, '中火比高火嫩'),
    (17, 4, '出锅淋生抽 + 香油 + 葱花,完成', 15, '趁热吃最嫩');

INSERT INTO nutrition (recipe_id, calories_kcal, protein_g, carb_g, fat_g, fiber_g, sodium_mg, source, note) VALUES
    (17, 220, 14, 8, 14, 0, 480, '估算', '1 人份;嫩滑高蛋白');

INSERT OR IGNORE INTO tag (name, category) VALUES ('宵夜', 'scenario');
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 17, id FROM tag WHERE name = '宵夜' AND category = 'scenario';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 17, id FROM tag WHERE name = '早餐' AND category = 'scenario';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 17, id FROM tag WHERE name = '微波' AND category = 'scenario';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 17, id FROM tag WHERE name = '咸鲜' AND category = 'flavor';

-- ============================================================================
-- 18. 凉拌木耳(凉菜 · 8 分钟 · 浙菜 · 素食 · 低脂)
-- ============================================================================
INSERT INTO recipe (name, cuisine, difficulty, prep_time_min, cook_time_min, servings,
                    description, source, source_ref, is_ai_generated)
VALUES ('凉拌木耳', '浙菜', 1, 5, 3, 2,
        '清爽开胃 · 凉拌经典 · 素食餐桌常客',
        '知识库', '../../_GourmetLib/09_健康快手食谱/健康快手食谱.md#L368', 0);

INSERT INTO ingredient (recipe_id, name, qty, unit, note, is_optional, order_no) VALUES
    (18, '干黑木耳', 20, 'g', '冷水泡发 2 小时', 0, 1),
    (18, '蒜末', 15, 'g', '约 1.5 勺', 0, 2),
    (18, '小米辣', 2, '个', '切圈,不吃辣可省', 1, 3),
    (18, '香菜', 5, 'g', '切段', 0, 4),
    (18, '生抽', 2, '勺', NULL, 0, 5),
    (18, '香醋', 1.5, '勺', NULL, 0, 6),
    (18, '白糖', 1, '勺', '提鲜', 0, 7),
    (18, '香油', 1, '勺', NULL, 0, 8),
    (18, '盐', 2, 'g', NULL, 0, 9);

INSERT INTO step (recipe_id, step_no, content, duration_sec, tip) VALUES
    (18, 1, '木耳泡发后撕小朵,沸水焯 2 分钟捞出过凉水', 120, '过凉保持脆感'),
    (18, 2, '蒜末 + 小米辣 + 生抽 + 醋 + 糖 + 香油 + 盐 调汁', 30, '酸甜比例可按口味调'),
    (18, 3, '木耳沥干水分,淋上料汁拌匀,撒香菜', 30, '现拌现吃最脆');

INSERT INTO nutrition (recipe_id, calories_kcal, protein_g, carb_g, fat_g, fiber_g, sodium_mg, source, note) VALUES
    (18, 90, 3, 12, 4, 6, 580, '估算', '2 人份分摊;素食低脂,木耳富含膳食纤维');

INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 18, id FROM tag WHERE name = '浙菜' AND category = 'cuisine';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 18, id FROM tag WHERE name = '凉菜' AND category = 'scenario';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 18, id FROM tag WHERE name = '素食' AND category = 'diet';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 18, id FROM tag WHERE name = '低脂' AND category = 'diet';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 18, id FROM tag WHERE name = '酸辣' AND category = 'flavor';

-- ============================================================================
-- 19. 冬瓜排骨汤(汤品 · 60 分钟 · 浙菜 · 煲汤 · 宴客)
-- ============================================================================
INSERT INTO recipe (name, cuisine, difficulty, prep_time_min, cook_time_min, servings,
                    description, source, source_ref, is_ai_generated)
VALUES ('冬瓜排骨汤', '浙菜', 2, 10, 50, 3,
        '经典家常汤 · 清淡不腻 · 夏日消暑首选',
        '知识库', '../../_GourmetLib/09_健康快手食谱/健康快手食谱.md#L395', 0);

INSERT INTO ingredient (recipe_id, name, qty, unit, note, is_optional, order_no) VALUES
    (19, '猪肋排', 500, 'g', '斩小块', 0, 1),
    (19, '冬瓜', 400, 'g', '去皮去瓤切块', 0, 2),
    (19, '姜片', 15, 'g', '约 5 片', 0, 3),
    (19, '料酒', 1, '勺', '焯水用', 0, 4),
    (19, '盐', 5, 'g', '出锅前调', 0, 5),
    (19, '葱段', 10, 'g', '点缀', 0, 6),
    (19, '白胡椒粉', 1, 'g', '去腥提鲜', 1, 7);

INSERT INTO step (recipe_id, step_no, content, duration_sec, tip) VALUES
    (19, 1, '排骨冷水下锅 + 姜片 + 料酒,焯水 3 分钟去血沫', 180, '冷水下锅,血沫出得净'),
    (19, 2, '捞出温水冲净,转砂锅加热水 + 姜片,大火烧开', 60, '热水下锅,汤更清'),
    (19, 3, '转小火炖 40 分钟,放入冬瓜块再炖 15 分钟', 2700, '小火慢炖,汤色奶白'),
    (19, 4, '出锅前 5 分钟加盐 + 白胡椒粉调味,撒葱段', 30, '盐别早放,肉发柴');

INSERT INTO nutrition (recipe_id, calories_kcal, protein_g, carb_g, fat_g, fiber_g, sodium_mg, source, note) VALUES
    (19, 280, 22, 8, 18, 1, 620, '估算', '3 人份分摊;清淡低脂,夏日首选');

INSERT OR IGNORE INTO tag (name, category) VALUES ('煲汤', 'scenario');
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 19, id FROM tag WHERE name = '煲汤' AND category = 'scenario';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 19, id FROM tag WHERE name = '汤品' AND category = 'scenario';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 19, id FROM tag WHERE name = '咸鲜' AND category = 'flavor';

-- ============================================================================
-- 20. 黑椒牛柳(主菜 · 20 分钟 · 粤菜 · 增肌 · 快手)
-- ============================================================================
INSERT INTO recipe (name, cuisine, difficulty, prep_time_min, cook_time_min, servings,
                    description, source, source_ref, is_ai_generated)
VALUES ('黑椒牛柳', '粤菜', 2, 10, 10, 2,
        '嫩滑牛柳 · 黑椒香气扑鼻 · 增肌补铁首选',
        '知识库', '../../_GourmetLib/09_健康快手食谱/健康快手食谱.md#L420', 0);

INSERT INTO ingredient (recipe_id, name, qty, unit, note, is_optional, order_no) VALUES
    (20, '牛里脊', 300, 'g', '切条,逆纹', 0, 1),
    (20, '青椒', 1, '个', '切块', 0, 2),
    (20, '洋葱', 0.5, '个', '切丝', 0, 3),
    (20, '蒜末', 10, 'g', '约 1 勺', 0, 4),
    (20, '黑胡椒碎', 1, '勺', '现磨更香', 0, 5),
    (20, '生抽', 1.5, '勺', NULL, 0, 6),
    (20, '蚝油', 1, '勺', NULL, 0, 7),
    (20, '料酒', 1, '勺', NULL, 0, 8),
    (20, '淀粉', 1, '勺', '嫩滑关键', 0, 9),
    (20, '蛋清', 1, '个', '嫩滑关键', 0, 10),
    (20, '盐', 2, 'g', '腌制', 0, 11),
    (20, '油', 2, '勺', '滑炒用', 0, 12);

INSERT INTO step (recipe_id, step_no, content, duration_sec, tip) VALUES
    (20, 1, '牛柳 + 盐 + 料酒 + 蛋清 + 淀粉 抓匀,腌 10 分钟', 600, '顺时针搅打上劲'),
    (20, 2, '热锅热油,牛柳滑炒至变色盛出(7 成熟)', 90, '大火快炒,别久'),
    (20, 3, '余油爆香蒜末 + 洋葱,加青椒翻炒 1 分钟', 60, '青椒别炒太久,保脆'),
    (20, 4, '回锅牛柳 + 生抽 + 蚝油 + 黑胡椒碎,大火翻匀出锅', 60, '黑椒最后下,香气浓');

INSERT INTO nutrition (recipe_id, calories_kcal, protein_g, carb_g, fat_g, fiber_g, sodium_mg, source, note) VALUES
    (20, 380, 32, 10, 22, 1, 680, '估算', '2 人份分摊;高蛋白补铁,增肌首选');

INSERT OR IGNORE INTO tag (name, category) VALUES ('增肌', 'diet');
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 20, id FROM tag WHERE name = '增肌' AND category = 'diet';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 20, id FROM tag WHERE name = '高蛋白' AND category = 'diet';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 20, id FROM tag WHERE name = '快手' AND category = 'scenario';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 20, id FROM tag WHERE name = '糊辣' AND category = 'flavor';

-- ============================================================================
-- v0.4 seed 结束 · 20 道菜谱已就位
-- 累计:早餐 4 / 凉菜 5 / 汤品 2 / 主菜 6 / 主食 1 / 蒸菜 1 / 宵夜 1 = 20 道
-- 菜系分布:川菜 3 / 粤菜 5 / 鲁菜 1 / 浙菜 3 / 中式 4 / 西餐 3 / 鲁菜 1 = 7 类
-- 标签字典累计:35 个(新增 海鲜/宵夜/煲汤/增肌)
-- 验证方法:
--   sqlite3 gourmet.db < db/schema.sql
--   sqlite3 gourmet.db < db/seed_recipes.sql
--   sqlite3 gourmet.db "SELECT r.name, r.cuisine, COUNT(i.id) AS ingredients
--                       FROM recipe r LEFT JOIN ingredient i ON i.recipe_id = r.id
--                       GROUP BY r.id ORDER BY r.id;"
-- 预期(v0.4 新增段):
--   蒜蓉蒸虾|粤菜|9
--   牛奶鸡蛋羹|中式|7
--   凉拌木耳|浙菜|9
--   冬瓜排骨汤|浙菜|7
--   黑椒牛柳|粤菜|12
-- ============================================================================

-- ============================================================================
-- v0.5 seed · 20→25 道 · 新增 4 大菜系(湘/徽/东北/闽)+ 1 经典淮扬
-- 21-25 · 选菜规则:补齐巡检建议的 4 个空白菜系 + 1 道淮扬名菜代表
-- ============================================================================

-- ============================================================================
-- 21. 剁椒鱼头(主菜 · 30 分钟 · 湘菜 · 蒸菜 · 宴客)
-- ============================================================================
INSERT INTO recipe (name, cuisine, difficulty, prep_time_min, cook_time_min, servings,
                    description, source, source_ref, is_ai_generated)
VALUES ('剁椒鱼头', '湘菜', 3, 10, 20, 3,
        '湘菜名菜 · 鱼头肥嫩 · 剁椒鲜辣开胃',
        '知识库', '../../_GourmetLib/06_烹饪方法与营养保留/烹饪方法与营养保留.md#蒸', 0);

INSERT INTO ingredient (recipe_id, name, qty, unit, note, is_optional, order_no) VALUES
    (21, '胖头鱼头', 1, '个', '约 1000g,从背部剖开', 0, 1),
    (21, '剁椒', 150, 'g', '市售坛装剁椒', 0, 2),
    (21, '蒜末', 20, 'g', '约 1 勺半', 0, 3),
    (21, '姜末', 10, 'g', '约 1 勺', 0, 4),
    (21, '豆豉', 10, 'g', '切碎', 0, 5),
    (21, '小葱', 10, 'g', '葱花', 0, 6),
    (21, '蒸鱼豉油', 2, '勺', NULL, 0, 7),
    (21, '料酒', 1, '勺', '去腥', 0, 8),
    (21, '盐', 3, 'g', '腌鱼头', 0, 9),
    (21, '油', 2, '勺', '激香用', 0, 10);

INSERT INTO step (recipe_id, step_no, content, duration_sec, tip) VALUES
    (21, 1, '鱼头剖开,抹盐 + 料酒,腌 10 分钟入味去腥', 600, '鱼头背部剖开更易入味'),
    (21, 2, '摆盘,铺剁椒 + 蒜末 + 姜末 + 豆豉,淋蒸鱼豉油', 60, '剁椒铺满,味才足'),
    (21, 3, '水开后大火蒸 12 分钟(鱼眼发白即熟)', 720, '超时鱼肉发柴'),
    (21, 4, '出锅撒葱花,烧热油至 200°C 浇上激香', 30, '热油激香,葱味瞬间释放');

INSERT INTO nutrition (recipe_id, calories_kcal, protein_g, carb_g, fat_g, fiber_g, sodium_mg, source, note) VALUES
    (21, 320, 32, 6, 18, 0, 720, '估算', '3 人份分摊;高蛋白低脂,但钠偏高(剁椒+豉油)');

INSERT OR IGNORE INTO tag (name, category) VALUES ('香辣', 'flavor');
INSERT OR IGNORE INTO tag (name, category) VALUES ('蒸菜', 'scenario');
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 21, id FROM tag WHERE name = '湘菜' AND category = 'cuisine';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 21, id FROM tag WHERE name = '宴客' AND category = 'scenario';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 21, id FROM tag WHERE name = '蒸菜' AND category = 'scenario';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 21, id FROM tag WHERE name = '海鲜' AND category = 'scenario';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 21, id FROM tag WHERE name = '麻辣' AND category = 'flavor';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 21, id FROM tag WHERE name = '香辣' AND category = 'flavor';

-- ============================================================================
-- 22. 徽州毛豆腐(主菜/小吃 · 20 分钟 · 徽菜 · 素食 · 特色)
-- ============================================================================
INSERT INTO recipe (name, cuisine, difficulty, prep_time_min, cook_time_min, servings,
                    description, source, source_ref, is_ai_generated)
VALUES ('徽州毛豆腐', '徽菜', 3, 5, 15, 2,
        '徽州传统发酵豆腐 · 煎至两面金黄 · 外脆内嫩如奶酪',
        '知识库', '../../_GourmetLib/06_烹饪方法与营养保留/烹饪方法与营养保留.md#煎', 0);

INSERT INTO ingredient (recipe_id, name, qty, unit, note, is_optional, order_no) VALUES
    (22, '毛豆腐', 400, 'g', '发酵豆腐,表面有白色菌丝', 0, 1),
    (22, '油', 3, '勺', '平底锅煎用', 0, 2),
    (22, '盐', 2, 'g', '出锅前撒', 0, 3),
    (22, '葱花', 5, 'g', NULL, 0, 4),
    (22, '香菜', 5, 'g', '提香', 1, 5),
    (22, '辣酱', 1, '勺', '蘸食,可选', 1, 6);

INSERT INTO step (recipe_id, step_no, content, duration_sec, tip) VALUES
    (22, 1, '毛豆腐切 1.5cm 厚片,小心保持完整', 120, '菌丝是精华,别洗太狠'),
    (22, 2, '平底锅热油,中火下毛豆腐煎 3 分钟定型', 180, '别急着翻,等底面金黄'),
    (22, 3, '翻面再煎 3 分钟至两面金黄外壳酥脆', 180, '中火慢煎,外脆内嫩'),
    (22, 4, '出锅撒盐 + 葱花 + 香菜,配辣酱蘸食', 30, '趁热吃,凉了外壳不脆');

INSERT INTO nutrition (recipe_id, calories_kcal, protein_g, carb_g, fat_g, fiber_g, sodium_mg, source, note) VALUES
    (22, 280, 18, 8, 20, 1, 480, '估算', '2 人份分摊;发酵豆制品含益生菌,助消化');

INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 22, id FROM tag WHERE name = '徽菜' AND category = 'cuisine';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 22, id FROM tag WHERE name = '素食' AND category = 'diet';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 22, id FROM tag WHERE name = '快手' AND category = 'scenario';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 22, id FROM tag WHERE name = '咸鲜' AND category = 'flavor';

-- ============================================================================
-- 23. 锅包肉(主菜 · 25 分钟 · 东北菜 · 宴客 · 酸甜)
-- ============================================================================
INSERT INTO recipe (name, cuisine, difficulty, prep_time_min, cook_time_min, servings,
                    description, source, source_ref, is_ai_generated)
VALUES ('锅包肉', '东北菜', 3, 10, 15, 2,
        '东北名菜 · 猪里脊酥脆 · 糖醋汁挂满金黄',
        '知识库', '../../_GourmetLib/06_烹饪方法与营养保留/烹饪方法与营养保留.md#炸', 0);

INSERT INTO ingredient (recipe_id, name, qty, unit, note, is_optional, order_no) VALUES
    (23, '猪里脊', 300, 'g', '切 0.5cm 厚片', 0, 1),
    (23, '土豆淀粉', 100, 'g', '挂糊用', 0, 2),
    (23, '蛋清', 1, '个', '调糊', 0, 3),
    (23, '油', 500, 'ml', '实耗 50ml,炸用', 0, 4),
    (23, '白糖', 50, 'g', '糖醋汁', 0, 5),
    (23, '米醋', 50, 'ml', '糖醋汁', 0, 6),
    (23, '生抽', 1, '勺', '调色', 0, 7),
    (23, '葱丝', 10, 'g', NULL, 0, 8),
    (23, '姜丝', 5, 'g', NULL, 0, 9),
    (23, '蒜末', 5, 'g', NULL, 0, 10),
    (23, '香菜', 5, 'g', '点缀', 0, 11),
    (23, '盐', 3, 'g', '腌肉', 0, 12);

INSERT INTO step (recipe_id, step_no, content, duration_sec, tip) VALUES
    (23, 1, '里脊片 + 盐 腌 10 分钟,土豆淀粉 + 蛋清 + 少量水调成稠糊', 600, '淀粉糊要稠到挂得住'),
    (23, 2, '肉片裹糊,油烧 170°C 下锅炸 3 分钟至金黄捞出', 180, '第一遍定型'),
    (23, 3, '油温升到 180°C,肉片复炸 30 秒至外壳酥脆', 30, '复炸是酥脆关键'),
    (23, 4, '留底油爆香葱姜蒜,加糖 + 醋 + 生抽煮沸成糖醋汁', 60, '糖醋比 1:1 是经典'),
    (23, 5, '倒炸肉大火快速翻匀,挂满糖醋汁,撒香菜出锅', 30, '快翻快出,保持酥脆');

INSERT INTO nutrition (recipe_id, calories_kcal, protein_g, carb_g, fat_g, fiber_g, sodium_mg, source, note) VALUES
    (23, 520, 28, 52, 22, 1, 580, '估算', '2 人份分摊;酸甜开胃但糖油偏高,建议配青菜');

INSERT OR IGNORE INTO tag (name, category) VALUES ('东北菜', 'cuisine');
INSERT OR IGNORE INTO tag (name, category) VALUES ('闽菜', 'cuisine');
INSERT OR IGNORE INTO tag (name, category) VALUES ('淮扬菜', 'cuisine');
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 23, id FROM tag WHERE name = '东北菜' AND category = 'cuisine';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 23, id FROM tag WHERE name = '宴客' AND category = 'scenario';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 23, id FROM tag WHERE name = '酸甜' AND category = 'flavor';

-- ============================================================================
-- 24. 沙茶面(主食 · 15 分钟 · 闽菜 · 早餐 · 海鲜)
-- ============================================================================
INSERT INTO recipe (name, cuisine, difficulty, prep_time_min, cook_time_min, servings,
                    description, source, source_ref, is_ai_generated)
VALUES ('沙茶面', '闽菜', 2, 5, 10, 1,
        '厦门街头经典 · 沙茶酱浓香 · 海鲜汤底鲜甜',
        '知识库', '../../_GourmetLib/06_烹饪方法与营养保留/烹饪方法与营养保留.md#煮', 0);

INSERT INTO ingredient (recipe_id, name, qty, unit, note, is_optional, order_no) VALUES
    (24, '碱水油面', 200, 'g', '或普通碱面', 0, 1),
    (24, '沙茶酱', 2, '勺', '潮汕/厦门风味', 0, 2),
    (24, '花生酱', 1, '勺', '增香增稠', 0, 3),
    (24, '鲜虾', 50, 'g', '去壳去虾线', 0, 4),
    (24, '鱿鱼', 50, 'g', '切花刀', 0, 5),
    (24, '猪肉片', 50, 'g', '里脊或梅花肉', 0, 6),
    (24, '小白菜', 50, 'g', '或油菜', 0, 7),
    (24, '高汤', 400, 'ml', '鸡/骨汤', 0, 8),
    (24, '蒜末', 5, 'g', NULL, 0, 9),
    (24, '葱花', 5, 'g', NULL, 0, 10),
    (24, '盐', 2, 'g', '调味', 0, 11);

INSERT INTO step (recipe_id, step_no, content, duration_sec, tip) VALUES
    (24, 1, '高汤烧开,加沙茶酱 + 花生酱搅匀煮沸出香', 90, '花生酱先用温水调开,免结块'),
    (24, 2, '放入猪肉片、鱿鱼、虾烫熟(约 2 分钟)', 120, '海鲜别久烫,保嫩'),
    (24, 3, '另锅煮面 3 分钟至弹牙,捞入碗中', 180, '碱水面不易煮烂'),
    (24, 4, '小白菜烫 30 秒铺面上,浇汤,撒蒜末葱花', 30, '小白菜烫过即可,保色保脆');

INSERT INTO nutrition (recipe_id, calories_kcal, protein_g, carb_g, fat_g, fiber_g, sodium_mg, source, note) VALUES
    (24, 580, 28, 65, 22, 2, 920, '估算', '1 人份;沙茶酱+花生酱热量高,钠偏高');

INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 24, id FROM tag WHERE name = '闽菜' AND category = 'cuisine';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 24, id FROM tag WHERE name = '海鲜' AND category = 'scenario';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 24, id FROM tag WHERE name = '宵夜' AND category = 'scenario';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 24, id FROM tag WHERE name = '快手' AND category = 'scenario';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 24, id FROM tag WHERE name = '糊辣' AND category = 'flavor';

-- ============================================================================
-- 25. 蟹粉狮子头(主菜/汤品 · 60 分钟 · 淮扬菜 · 宴客 · 经典)
-- ============================================================================
INSERT INTO recipe (name, cuisine, difficulty, prep_time_min, cook_time_min, servings,
                    description, source, source_ref, is_ai_generated)
VALUES ('蟹粉狮子头', '淮扬菜', 4, 20, 45, 3,
        '淮扬名菜 · 手工切肉 · 入口即化 · 蟹粉提鲜',
        '知识库', '../../_GourmetLib/06_烹饪方法与营养保留/烹饪方法与营养保留.md#炖', 0);

INSERT INTO ingredient (recipe_id, name, qty, unit, note, is_optional, order_no) VALUES
    (25, '猪五花肉', 500, 'g', '肥瘦 3:7,手工切丁不绞', 0, 1),
    (25, '蟹粉', 50, 'g', '或蟹黄+蟹肉', 0, 2),
    (25, '荸荠', 100, 'g', '切小丁,增脆', 0, 3),
    (25, '葱姜水', 50, 'ml', '葱姜泡温水 10 分钟', 0, 4),
    (25, '盐', 5, 'g', NULL, 0, 5),
    (25, '料酒', 1, '勺', NULL, 0, 6),
    (25, '淀粉', 2, '勺', '土豆/玉米淀粉', 0, 7),
    (25, '蛋清', 1, '个', NULL, 0, 8),
    (25, '小白菜', 200, 'g', '铺底', 0, 9),
    (25, '高汤', 500, 'ml', '鸡/骨汤', 0, 10),
    (25, '白胡椒粉', 1, 'g', '出锅前撒', 0, 11);

INSERT INTO step (recipe_id, step_no, content, duration_sec, tip) VALUES
    (25, 1, '五花肉手工切 0.5cm 丁(不用绞肉机,保口感)', 600, '手工切才松软,绞肉发柴'),
    (25, 2, '肉丁 + 葱姜水顺时针摔打 5 分钟上劲,加蟹粉、荸荠丁、盐、料酒、淀粉、蛋清拌匀', 600, '摔打出胶是关键,丸子才嫩'),
    (25, 3, '双手团成 4 个大丸子(直径 6-7cm),表面光滑', 120, '两手倒替摔几下排气'),
    (25, 4, '砂锅铺小白菜,放丸子,加高汤没过一半,大火烧开', 120, '汤别全没过,上半部蒸下半部煮'),
    (25, 5, '转小火盖盖炖 45 分钟,出锅撒白胡椒粉', 2700, '小火慢炖,肥肉化渣,瘦肉不柴');

INSERT INTO nutrition (recipe_id, calories_kcal, protein_g, carb_g, fat_g, fiber_g, sodium_mg, source, note) VALUES
    (25, 420, 28, 12, 30, 2, 680, '估算', '3 人份分摊;肥瘦相间但长时间炖后肥肉化渣,口感不腻');

INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 25, id FROM tag WHERE name = '淮扬菜' AND category = 'cuisine';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 25, id FROM tag WHERE name = '宴客' AND category = 'scenario';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 25, id FROM tag WHERE name = '汤品' AND category = 'scenario';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 25, id FROM tag WHERE name = '咸鲜' AND category = 'flavor';
INSERT INTO recipe_tag (recipe_id, tag_id)
    SELECT 25, id FROM tag WHERE name = '高蛋白' AND category = 'diet';

-- ============================================================================
-- v0.5 seed 结束 · 25 道菜谱已就位
-- 累计:早餐 5 / 凉菜 5 / 汤品 3 / 主菜 9 / 主食 2 / 蒸菜 1 = 25 道
-- 菜系分布:川菜 3 / 粤菜 5 / 鲁菜 1 / 浙菜 3 / 中式 4 / 西餐 3 / 湘菜 1 / 徽菜 1 / 东北菜 1 / 闽菜 1 / 淮扬菜 1 = 11 类
-- 标签字典累计:40 个(新增 香辣/蒸菜/东北菜/闽菜/淮扬菜)
-- 验证方法:
--   sqlite3 gourmet.db < db/schema.sql
--   sqlite3 gourmet.db < db/seed_recipes.sql
--   sqlite3 gourmet.db "SELECT r.name, r.cuisine, COUNT(i.id) AS ingredients
--                       FROM recipe r LEFT JOIN ingredient i ON i.recipe_id = r.id
--                       GROUP BY r.id ORDER BY r.id;"
--   sqlite3 gourmet.db "SELECT cuisine, COUNT(*) FROM recipe GROUP BY cuisine ORDER BY 2 DESC;"
-- 预期(v0.5 新增段):
--   剁椒鱼头|湘菜|10
--   徽州毛豆腐|徽菜|6
--   锅包肉|东北菜|12
--   沙茶面|闽菜|11
--   蟹粉狮子头|淮扬菜|11
-- 预期(菜系分布):
--   粤菜|5  中式|4  川菜|3  西餐|3  浙菜|3
--   鲁菜|1  湘菜|1  徽菜|1  东北菜|1  闽菜|1  淮扬菜|1
-- ============================================================================
