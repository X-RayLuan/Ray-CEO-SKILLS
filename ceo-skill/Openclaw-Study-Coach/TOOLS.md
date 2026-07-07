# TOOLS.md — 落盘约定

## 文件命名规范

| 类型 | 路径 | 文件名格式 | 示例 |
|---|---|---|---|
| 原始作业 | `data/homework/inbox/` | `YYYY-MM-DD_homework.md` | `2026-05-22_homework.md` |
| 拆解后任务计划 | `data/homework/parsed/` | `YYYY-MM-DD_homework_plan.md` | `2026-05-22_homework_plan.md` |
| 已完成作业归档 | `data/homework/done/` | `YYYY-MM-DD_homework_done.md` | `2026-05-22_homework_done.md` |
| 错题卡(每题一文件) | `data/mistakes/subjects/<学科>/` | `YYYY-MM-DD_<知识点>_mistake.md` | `2026-05-22_分数加减_mistake.md` |
| 当日错题入口暂存 | `data/mistakes/inbox/` | `YYYY-MM-DD_HH-MM_raw.md` | 罕用 |
| 错题复习队列 | `data/mistakes/review_queue/` | `YYYY-MM-DD_queue.md` | `2026-05-22_queue.md` |
| 周复习计划 | `data/plans/weekly/` | `YYYY-Wxx_plan.md` | `2026-W21_plan.md` |
| 日复习清单 | `data/plans/daily/` | `YYYY-MM-DD_plan.md` | `2026-05-22_plan.md` |
| 日报 | `data/reports/daily/` | `YYYY-MM-DD_daily.md` | `2026-05-22_daily.md` |
| 周报 | `data/reports/weekly/` | `YYYY-Wxx_weekly.md` | `2026-W21_weekly.md` |
| 趋势数据 | `data/reports/trends/trends.csv` | 单一文件,追加行 | — |
| 积分日志 | `data/points/log.jsonl` | 单一文件,追加 JSONL | — |
| 评分细则 | `data/rubrics/<topic>.md` | 命名自由 | `data/rubrics/应用题审题.md` |

## 学科目录命名

错题归档下的 `<学科>` 一律用中文,固定 3 个:
- `数学/`
- `语文/`
- `英语/`

(以后加科学/物理等,在 SOUL.md 里先确认范围。)

## 日期与周编号

- 日期: 一律用 ISO `YYYY-MM-DD`,不要写"5月22日"或"2026/5/22"
- 周: 用 ISO `YYYY-Www`(`%G-W%V` 格式),比如 `2026-W21`。**周一为一周开始**。

## 落盘动作的强制要求

1. **每次写文件前,先打印目标路径**给用户看,让他知道你要写到哪。例:
   > 我把今天的作业计划写到 `data/homework/parsed/2026-05-22_homework_plan.md` 了。

2. **目录不存在就建**。用 mkdir -p 等价的方式确保父目录存在。

3. **覆盖 vs 追加**:
   - 日报/周报: 同一天/同一周如果已有文件,**追加**一个新 section,不要覆盖(可能下午一份、晚上一份)
   - 错题卡: 一题一文件,文件名带知识点,**新建**;如果同一题再错,新建带 `_v2` 后缀
   - 错题队列: 同一天 queue 文件,**追加**新条目
   - trends.csv: **永远追加**,从不覆盖
   - 积分 log.jsonl: **永远追加**

4. **写完后,告诉用户"已写入 [路径]"**,不要默默写。

## 积分 log 格式(JSONL,每行一个事件)

```json
{
  "ts": "2026-05-22T19:32:00",
  "kid": "kid1",
  "delta": 5,
  "reason": "完成数学第3关",
  "task_ref": "data/homework/parsed/2026-05-22_homework_plan.md#math-q3"
}
```

字段:
- `ts`: ISO 8601 时间戳,带时区也行,不带也行
- `kid`: USER.md 里的 kid_id
- `delta`: 加分数(正整数,**永远不能为负**)
- `reason`: 简短中文说明
- `task_ref` *(可选)*: 这次加分对应的任务文件 + anchor

## trends.csv 格式

文件首行必须是表头(initial-setup.sh 已经写好)。每天写完日报后,**追加一行**:

```csv
date,kid,homework_minutes,mistakes_new,main_subject,top_knowledge,top_reason,points_today,streak_days
2026-05-22,kid1,55,3,数学,分数加减,审题,28,6
```

字段说明:
- `homework_minutes`: 当天作业 + 复习的预计 / 实际总时长(分钟)
- `mistakes_new`: 当天新增错题数
- `main_subject`: 当天主要在哪一科出错(数学/语文/英语)
- `top_knowledge`: 当天最主要的薄弱知识点(自由文本,简短)
- `top_reason`: 当天最主要错因分类(审题/计算/概念/方法/书写/习惯)
- `points_today`: 当天净加分
- `streak_days`: 连续学习天数(写完日报后的值)

## 错题卡模板(必须包含的字段)

```markdown
---
学科: 数学
知识点: 分数加减
日期: 2026-05-22
错因分类: [审题]
回流日期: 2026-05-23
状态: pending
---

## 题目

(原题)

## 孩子的答案

(写错的内容)

## 正确思路

(≤ 6 句话)

## 一句纠错要点

(孩子能记住的)

## 类题建议

1. (题目描述)
2. (题目描述)

## 家长可看(可选)

(一句不指责的观察)
```

## 路径展示风格

跟用户提到路径时,**总是用相对路径**,从 workspace 根开始,比如:
- 对的: `data/reports/daily/2026-05-22_daily.md`
- 错的: `/Users/brian/Desktop/ray/study-coach/data/reports/daily/2026-05-22_daily.md`(太长,孩子也看不懂)

## 不要做的事

- ❌ 不要把数据写到 workspace 外
- ❌ 不要写隐藏文件(`.xxx`)在 `data/` 下
- ❌ 不要在文件名里用空格、中文标点(可以用中文字、连字符 `-`、下划线 `_`)
- ❌ 不要写二进制文件到 `data/`(图片放 `assets/attachments/`)
- ❌ 不要存包含老师、同学、家长真实姓名 / 学校全名的内容。代号化处理。
