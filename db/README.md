# db · GourmetAdvisor 数据库设计

> 项目代号：GourmetAdvisor · 内部代号 03-美食 · v0.1 · 2026-08-26
> 关联文件：[schema.sql](./schema.sql) · [项目开发计划.md](../项目开发计划.md) Phase 0 · 任务 6

---

## 一、设计目标

为 Phase 0 任务 2「提取菜谱 200+ 道 → recipes.json」和后续 Phase 1 任务「SQLite → PostgreSQL + Neo4j 迁移脚本」提供 **可执行、可追溯、可扩展** 的关系型结构。

设计原则：

1. **5 张主表 + 1 张多对多桥接**：菜谱、食材行项、步骤、标签字典、营养聚合 + 菜谱-标签桥接
2. **留好 FK 与索引**：冰箱反查（按食材名）、减脂推荐（按热量）、菜系筛选（按 cuisine）三类高频查询都建了索引
3. **数据来源可追溯**：`recipe.source` / `recipe.source_ref` 字段记录知识库 md 路径或网络 URL，避免 LLM 虚构菜谱
4. **AI 生成标记**：`recipe.is_ai_generated` 显式区分"知识库提取 vs AI 生成"，保护公信力
5. **营养一对一**：`nutrition` 一菜一份聚合值，简化推荐引擎的"低卡 / 高蛋白"筛选

---

## 二、5+1 表 ER 概览

```
                ┌──────────────────────────────┐
                │           recipe             │
                │  菜谱主体(1)                │
                │  - name / cuisine / difficulty│
                │  - time / servings / source  │
                └──────────┬───────────────────┘
                           │ 1
       ┌───────────────────┼────────────────────┐
       │ N                 │ N                  │ 1:1
       ▼                   ▼                    ▼
┌──────────────┐   ┌────────────────┐   ┌─────────────────┐
│ ingredient   │   │     step       │   │   nutrition     │
│ 食材行项     │   │  烹饪步骤      │   │  营养聚合       │
│ - name/qty/  │   │ - step_no      │   │ - kcal/P/C/F    │
│   unit/note  │   │ - content/tip  │   │ - source(权威)  │
└──────────────┘   └────────────────┘   └─────────────────┘

                ┌──────────────────────────────┐
                │            tag               │
                │  标签字典(N,全局唯一)        │
                │  - name (辣/低糖/快手/川菜)  │
                │  - category (4 类)           │
                └──────────┬───────────────────┘
                           │ M:N
                           ▼
                ┌──────────────────────────────┐
                │        recipe_tag            │
                │  菜谱 ↔ 标签 桥接表          │
                │  (recipe_id, tag_id) PK     │
                └──────────────────────────────┘
```

---

## 三、字段语义补充

### 3.1 recipe 关键字段

| 字段 | 用途 | 示例 |
|------|------|------|
| `cuisine` | 8 大菜系 + 西餐/日料筛选 | 川 / 鲁 / 粤 / 淮扬 / 浙 / 闽 / 徽 / 湘 / 西餐 / 日料 |
| `source` | 数据来源分级 | 知识库 / 网络 / 书籍 / 用户贡献 / AI 生成 |
| `source_ref` | 精确引用（可点击） | `../09_健康快手食谱/健康快手食谱.md#L42` |
| `is_ai_generated` | AI 虚构菜谱显式标记 | 0 = 提取，1 = AI（推荐 UI 显示"⚠️ AI 生成"） |

### 3.2 ingredient 行项

- **name**：食材原始名（"豆腐"），不存别名（"嫩豆腐 / 内酯豆腐" 走 `note` 备注）
- **qty / unit**：浮点 + 文本单位，留 `适量` 作为 unit 的合法值
- **is_optional**：区分"主料 vs 调料可选"，推荐引擎可据此做"家里缺料也能做"
- **idx_ingredient_name**：冰箱识别 → 菜谱反查的核心索引

### 3.3 step 步骤

- **step_no + UNIQUE(recipe_id, step_no)**：保证步骤顺序唯一不重复
- **duration_sec**：可选秒数，Phase 1 智能音箱可据此做"剩余 N 秒"语音播报
- **tip**：单步骤小贴士（如"中火收汁"），不喧宾夺主

### 3.4 tag 字典

- 4 类：`flavor`（风味）/ `scenario`（场景）/ `diet`（饮食目标）/ `cuisine`（菜系补充）
- 已预置 25 个高频标签（见 schema.sql 末尾 `INSERT OR IGNORE`，v0.1 初始 23 + 2026-09-03 新增「甜品」+「微波」），Phase 0 任务 2 提取菜谱可直接复用
- **不用 VARCHAR enum**：字典表更易扩展（"增肌"是新加的，`category='diet'` 直接 insert）

### 3.5 nutrition 营养

- 一菜一份聚合值（UNIQUE recipe_id），由 Phase 0 任务 4「中国食物成分表导入」提供基础数据 + Phase 1 服务层按 ingredient 行项做加权求和
- **source 字段**：明确"中国食物成分表 / USDA / 估算 / 混合"，避免单一来源误差，呼应"项目开发计划 §八 风险表 · 营养数据误差"
- **idx_nutrition_cal**：减脂推荐按热量升序扫描的核心索引

---

## 四、Phase 0 → Phase 1 迁移要点

SQLite → PostgreSQL 14+ 兼容清单：

| 维度 | SQLite v0.1 | PostgreSQL 14+ v1.0 |
|------|-------------|---------------------|
| 自增主键 | `INTEGER PRIMARY KEY AUTOINCREMENT` | `SERIAL` 或 `BIGSERIAL` |
| 时间戳 | `TEXT` (ISO 8601) | `TIMESTAMP WITH TIME ZONE` |
| CHECK 约束 | 完全兼容 | 完全兼容 |
| 字符串长度 | 无限制 | 视情况加 `VARCHAR(N)` |
| 索引命名 | 兼容 | 兼容 |
| JSON 字段 | TEXT (手工解析) | JSONB (结构化查询) |
| 全文搜索 | FTS5 虚拟表 | `tsvector` + GIN 索引 |

Neo4j 同步策略（v1.1）：

- 节点：`(:Recipe {id, name, cuisine})` / `(:Ingredient {name})` / `(:Tag {name, category})`
- 关系：
  - `(:Recipe)-[:REQUIRES {qty, unit}]->(:Ingredient)`
  - `(:Recipe)-[:HAS_STEP]->(:Step)`
  - `(:Recipe)-[:TAGGED_AS]->(:Tag)`
  - `(:Ingredient)-[:PAIRS_WITH {weight}]->(:Ingredient)`（搭配图谱，Phase 2 风味推荐用）

---

## 五、当前 v0.1 状态

- ✅ schema.sql 已落地（v0.1 初始 + 2026-09-03 增 2 tag → 25 个标签种子，10 cuisine / 9 flavor / 7 diet / 10 scenario）
- ⏳ Phase 0 任务 2「菜谱 200+ 提取」待启动（schema 已就绪可灌数据）
- ⏳ Phase 0 任务 4「中国食物成分表导入」待启动（nutrition.source 待关联）
- ⏳ Phase 0 任务 7「SQLite → PG/Neo4j 迁移脚本」待启动（迁移清单已在上节列清）

**下一步建议**：执行 Phase 0 任务 2，参考 `../knowledge_index.md` 第 80-150 行（09_健康快手食谱 章节定位）从知识库提取 50 道验证 schema，跑通端到端后再向 200 道推。
