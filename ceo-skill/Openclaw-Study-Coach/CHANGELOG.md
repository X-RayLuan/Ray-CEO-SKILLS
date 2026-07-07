# Changelog

All notable changes to **Openclaw Study Coach** are documented here.

Format based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
versioning follows [SemVer](https://semver.org/).

---

## [0.2] - 2026-05-22

### 🎓 大改:从"小学语文专攻"扩展到"K-12 全学科"

这是产品定位的一次重大升级。**从这一版开始,Openclaw Study Coach 覆盖 1-12 年级所有学段,语数英 + 理科(物化生) + 文综(史地政) 5 大学科**。设计哲学不变,但 skill 矩阵、语气适配、错题分类、出题难度全部按学段 + 学科自适应。

### Added

**5 个学科 tutor**(每个内部按 1-12 学段自动切档):

- `chinese-tutor` — 语文(K-12):阅读理解 / 作文 / 古诗 / 字词 / 文言文
- `math-tutor` — 数学(K-12):口算 / 应用题 / 代数 / 函数 / 几何 / 导数
- `english-tutor` — 英语(K-12):单词 / 语法 / 完形 / 阅读 / 写作 / 七选五 / 高考续写
- `science-tutor` — 理科(5-12):科学(5-6)/ 物理化学生物(7-12)
- `humanities-tutor` — 文综(K-12):道法(1-9)/ 历史地理政治(7-12)

**3 个通用思维方法**(被学科 tutor 调用,跨学科):

- `divergent-question-method` — 发散题 4 步法(从原 reading-comp-tutor 抽象出来的通用版,适用于**所有学科的开放性题**:语文阅读、历史评价、政治分析、地理"为什么"、物化生"现象解释"、英语推断)
- `calculation-method` — 计算题 5 步法(数理化通用:审题→列式画图→算→单位检查→答语)
- `memorization-loop` — 间隔重复 1/3/7/30 天 + 自测 + Leitner 5 盒子(适用于英语单词、语文古诗、文言虚词、历史年表、地理位置、政治概念、化学方程式)

**4 学段语气档**(SOUL.md):

- 启蒙期 (grade 1-3):句子 ≤ 20 字 / 任务 5 分钟 / 多 emoji 多比喻 / 不讲为什么
- 巩固期 (grade 4-6):反馈三段式 / 任务 5-20 分钟 / 引入"金句"方法论
- 初中期 (grade 7-9):应试技巧 / 任务 15-30 分钟 / 不用闯关叙事 / emoji 少
- 高中期 (grade 10-12):像同行 / 任务 20-40 分钟 / 高考视角 / 时间分配 / 选科考虑

**新增基础架构字段**:

- USER.md 加 `grade`(1-12)/ `learning_stage`(自动推导)/ `active_subjects`(激活学科列表)/ `subject_pain_points`(各学科痛点字典)
- USER.md 加"选科"字段(grade 10-12 必填,支持新高考 3+1+2 / 3+3 / 旧高考文理)
- AGENTS.md 加"学科路由"section(homework-intake 自动识别学科分发)
- AGENTS.md 错因分类按学科扩展:语文专属(代入/证据/联想)、数学专属(画图/分类讨论/取舍)、理科专属(画图/单位/化学符号/实验描述)、文综专属(史实/结构/材料结合)

**数据目录扩展**:

- `data/mistakes/subjects/{语文,数学,英语,理科,文综}/` 5 个学科子目录
- `data/memorization/queue.jsonl` 间隔重复队列文件
- `data/memorization/mastered.jsonl` 已掌握内容归档

**新增脚本**:

- `scripts/lark-bridge-daemon.sh` — lark-channel-bridge 的 SSH 友好 system-domain daemon 管理器(install / status / restart / stop / logs / uninstall)。解决 macOS Tahoe / Sequoia 拒绝 SSH session 操作 user-domain launchd 的痛点。

### Changed

- **README.md 完全重写**,定位从"小学语文专攻"改为"K-12 全学科"。SEO 关键词扩展(加 `k12` / `middle-school` / `high-school` / `gaokao` / `数学辅导` / `物化生辅导` / `史地政辅导` / `新高考` 等)
- **CLAUDE.md 重写**,skill 索引扩展到 17 个(原 9 + 新 8),硬规则从 19 条扩到 22 条
- **AGENTS.md 重写**,加学段自适应说明、学科路由判断、错因学科子类
- **SOUL.md 重写**,核心是 4 学段语气档(原版只有一档:小学中年级)
- **USER.md 重写**,新增 grade / active_subjects / 选科 / 教材版本 / subject_pain_points 字段
- **积分系统扩展**,高中(grade 10-12)用户支持 `reward_style: points / progress / silent` 三选一(高中生对加分反应弱,改用进度制更合适)

### Kept(向后兼容)

- `reading-comp-tutor` 和 `writing-coach` 保留(v0.1 时的语文阅读理解和作文专项 skill)。现在它们作为 `chinese-tutor` 的子调用,处理语文专属包装逻辑。
- `homework-intake` / `mistake-tracker` / `review-scheduler` / `weakness-tracker` / `daily-report` / `weekly-report` / `parent-playbook` 7 个流程 skill 全部保留,行为跨学科通用。
- 三件套画像(weakness / strengths / interests)结构不变,但内容扩展到跨学科 pattern。

### Removed

无。完全向后兼容。fork v0.1 的用户可以直接 git pull 升级。

### Skill 矩阵对比

| | v0.1 | v0.2 |
|---|---|---|
| Skill 总数 | 9 | 17 |
| 学科覆盖 | 主要小学语文 | K-12 + 5 学科 |
| 跨学科思维方法 | 1(只有 4 步法) | 3(4 步法 + 5 步法 + 间隔重复) |
| 学段适配 | 1 档(小学中年级) | 4 档(启蒙 / 巩固 / 初中 / 高中) |
| 高中选科支持 | ❌ | ✅(3+1+2 / 3+3 / 旧文理) |
| 错因分类 | 基础 6 类 + 阅读 3 子类 | 基础 6 类 + 学科专属 14 子类 |

### 升级提示(从 v0.1 升级)

```bash
git pull origin main
```

然后在 USER.md 里**补两个字段**(其他保持不变):

```yaml
grade: <填 1-12 数字>
active_subjects:
  - 语文
  - 数学
  - 英语
  # - 理科  # grade 5+ 才启用
  # - 文综  # grade 7+ 才有完整版
```

如果孩子是高中,**补"选科"**字段。其他不用动,数据完全兼容。

---

## [0.1] - 2026-05-21

### 初始版本

为 10 岁四年级女孩设计的语文专攻辅导系统。

**包含**:

- 5 个顶层规则文件(CLAUDE / SOUL / USER / AGENTS / TOOLS)
- 9 个 skill:
  - `homework-intake` / `reading-comp-tutor` / `writing-coach` / `mistake-tracker` / `review-scheduler` / `weakness-tracker` / `daily-report` / `weekly-report` / `parent-playbook`
- 三件套画像系统(weakness-profile / strengths / interests)
- 父母 Playbook(每天 3 分钟 + 周末 30 分钟亲子活动)
- 18 条核心设计规则(4 步法 + 5 阶段 + 视角分离)
- Codex CLI 兼容(`AGENTS.md` 初始化协议 + `CODEX.md` 向导)

**主线场景**:
- 小学语文阅读理解发散题(4 步法)
- 小学作文(5 阶段)

**设计灵感**:
- 微光游戏社《用 OpenClaw 给孩子搭全科辅导系统》系列
- 沈奕斐自驱力理论

**兼容**:
- Claude Code(主)
- Codex CLI
- OpenClaw

---

## Versioning Policy

- **major** (1.0 etc): 不向后兼容的重大架构改动 / Skill API 破坏性变更
- **minor** (0.2 / 0.3): 新功能或学段扩展,**向后兼容**(老 USER.md 配置仍能跑)
- **patch** (0.2.1): bug 修复 / 文档更新 / skill 内部规则调整

## Roadmap(可能的下一个 minor)

- **v0.3**: 国际学校 + 海外用户支持(英文系统 prompt 翻译版 + 海外教材适配 IB / AP / IGCSE / SAT)
- **v0.4**: 多孩子支持(在一个 workspace 内管理多个 kid_id 的画像,不互相串)
- **v0.5**: 飞书多维表格数据回灌(让家长在飞书表格里看孩子学习曲线)
