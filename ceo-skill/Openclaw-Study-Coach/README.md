<div align="center">

# Openclaw Study Coach

### K-12 全科 AI 辅导员 · K-12 AI Tutor · K-12 AI 学習チューター · K-12 AI 학습 튜터 · Tutor IA K-12

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Claude Code](https://img.shields.io/badge/Claude_Code-Compatible-blueviolet)](https://claude.com/claude-code)
[![Codex CLI](https://img.shields.io/badge/Codex_CLI-Compatible-green)](https://github.com/openai/codex)
[![OpenClaw](https://img.shields.io/badge/OpenClaw-Skill_Compatible-orange)](https://github.com/openclaw)
[![Feishu](https://img.shields.io/badge/飞书Lark-Bridge_Supported-blue)](https://github.com/X-RayLuan/Openclaw-Study-Coach#-飞书--lark-入口)
[![Version](https://img.shields.io/badge/Version-v0.2-brightgreen)](CHANGELOG.md)
[![Languages](https://img.shields.io/badge/Languages-中%20%2F%20EN%20%2F%20JP%20%2F%20KR%20%2F%20ES-red)](#-多语言介绍--multilingual--多言語--다국어--multilingüe)

[**📖 是什么**](#是什么) ·
[**🎓 K-12 全科**](#-k-12-全学科覆盖) ·
[**🚀 60 秒启动**](#-60-秒启动) ·
[**🧠 设计原则**](#-设计原则22-条核心规则) ·
[**👨‍👩‍👧 家长 Playbook**](#-家长-playbook父母可执行的事) ·
[**❓ FAQ**](#-faq常见问题)

</div>

---

## 🌐 多语言介绍 / Multilingual / 多言語 / 다국어 / Multilingüe

### 🇨🇳 中文

**Openclaw Study Coach** 是一个**给 K-12(小学 / 初中 / 高中)学生的 AI 学习辅导员**,以 **markdown skill 包**的形式分发。可以在 **Claude Code / Codex CLI / OpenClaw** 上直接跑,**不需要任何前端、不需要部署服务器、不需要 API key 之外的费用**。覆盖**语数英 + 理科(物化生)+ 文综(史地政)5 大学科**,1-12 年级**学段自适应**(启蒙 / 巩固 / 初中 / 高中 4 档语气自动切换),含**家长 Playbook**(每天 3 分钟可做的具体亲子活动)。设计哲学来自[微光游戏社的 OpenClaw 系列文章](https://mp.weixin.qq.com/s/weQmKdFKEQKf7Oys1P1x4w)和教育学者**沈奕斐**的自驱力理论。

### 🇬🇧 English

**Openclaw Study Coach** is an **AI tutoring agent for K-12 students** (grades 1-12: elementary / middle / high school) distributed as a **markdown skill pack**. It runs directly on **Claude Code, Codex CLI, or OpenClaw** — **no frontend, no server, no cost beyond your LLM API key**. Covers **5 subject areas** (Chinese / Math / English / Science [Physics + Chemistry + Biology] / Humanities [History + Geography + Politics]) with **grade-adaptive teaching style** (4 tiers: kindling 1-3 / consolidation 4-6 / middle 7-9 / high 10-12). Includes a **Parent Playbook** — concrete 3-minute family activities you can do tonight, with specific dialogue. The underlying frameworks (4-step method for divergent questions, 5-step calculation, spaced repetition) are language-agnostic; translations welcome via PR.

### 🇯🇵 日本語

**Openclaw Study Coach** は、中国の K-12(小・中・高校)カリキュラムに対応した **AI 学習チューター**です。**markdown 形式の skill パック**として配布され、**Claude Code / Codex CLI / OpenClaw** で直接動作します。**フロントエンド不要、サーバー不要、LLM API キー以外の費用は一切かかりません**。**5 教科**(国語(中国語)・数学・英語・理科(物理・化学・生物)・社会(歴史・地理・政治))を網羅し、学年(1〜12)に応じて口調と難易度が自動調整されます(啓蒙期 / 定着期 / 中学期 / 高校期 の 4 段階)。毎日 3 分でできる具体的な親子アクティビティを生成する **Parent Playbook** も搭載。発散問題の 4 ステップ法、計算問題の 5 ステップ法、間隔反復記憶などの基本フレームワークは言語非依存であり、PR による多言語対応を歓迎します。

### 🇰🇷 한국어

**Openclaw Study Coach** 는 중국 **K-12(초·중·고) 커리큘럼**에 맞춘 **AI 학습 튜터**입니다. **markdown skill 팩** 형태로 배포되며, **Claude Code / Codex CLI / OpenClaw** 에서 바로 실행됩니다. **프론트엔드 불필요, 서버 불필요, LLM API 키 외 추가 비용 없음**. **5 과목**(국어(중국어) / 수학 / 영어 / 이과(물리·화학·생물) / 사회(역사·지리·정치))을 모두 다루며, 학년(1-12)에 따라 말투와 난이도가 자동으로 조정됩니다(계몽기 / 정착기 / 중등 / 고등 4단계). 매일 3분 부모-자녀 활동을 구체적으로 제안하는 **Parent Playbook** 포함. 핵심 프레임워크(발산 문제 4단계법, 계산 문제 5단계법, 간격 반복 기억)는 언어 비의존적이며 PR 을 통한 다국어 지원을 환영합니다.

### 🇪🇸 Español

**Openclaw Study Coach** es un **agente tutor de IA para estudiantes de K-12** (grados 1-12: primaria / secundaria / preparatoria), basado en el currículo educativo chino y distribuido como un **paquete de skills en markdown**. Se ejecuta directamente en **Claude Code, Codex CLI u OpenClaw** — **sin frontend, sin servidor, sin costos más allá de tu clave API de LLM**. Cubre **5 áreas** (Lengua [chino] / Matemáticas / Inglés / Ciencias [Física + Química + Biología] / Humanidades [Historia + Geografía + Política]) con **estilo de enseñanza adaptado al grado** (4 niveles: iniciación 1-3 / consolidación 4-6 / secundaria 7-9 / preparatoria 10-12). Incluye un **Parent Playbook** con actividades familiares concretas de 3 minutos al día, hasta el nivel de diálogo específico. Los marcos centrales (método de 4 pasos para preguntas divergentes, 5 pasos para cálculo, repetición espaciada) son agnósticos al idioma; PRs para traducciones son bienvenidos.

---

## 是什么

**Openclaw Study Coach** 是一个**给 K-12(小学 / 初中 / 高中)学生的 AI 学习辅导员**,以 **markdown skill 包**的形式分发。可以在 **Claude Code / Codex CLI / OpenClaw** 上直接跑,**不需要任何前端、不需要部署服务器、不需要 API key 之外的费用**。

它解决五个真实痛点:

1. **任何学科的发散题**(语文阅读"读完什么感受"、历史"评价 X"、政治"分析这个现象"、物理"为什么会发生")—— 没标准答案,孩子无从下手,家长讲不清。
2. **作文** —— 找不到合适的辅导老师,孩子不知道从哪开头,写完不知道怎么改。
3. **数学应用题 / 计算题** —— 不审题、不画图、不带单位,80% 的错来自于"流程没走全"。
4. **大量记忆类内容**(英语单词、古诗、历史年表)—— 机械背诵 ≠ 真记得,需要间隔重复。
5. **家长不知道怎么把学科变成游戏** —— 沈奕斐讲自驱力要靠兴趣,但"想小游戏"对很多家长来说就是做不到。

这个系统:
- **学段自适应**:1-3 年级启蒙、4-6 巩固、7-9 初中、10-12 高中,语气 / 难度 / 任务时长全自动切档
- **学科自动识别**:孩子发题进来,自动判断是数学 / 语文 / 英语 / 理科 / 文综,路由到对应 tutor
- **纵向记得孩子**:三件套画像(weakness / strengths / interests),不重置
- **父母 playbook**:每天 3 分钟可做的具体亲子活动,周末 30 分钟深度互动
- **数据本地**:所有学习数据存为 markdown / CSV,不上云

> **一句话总结**: 一个**会记得 ta** 的辅导员,从一年级到高三都能用,语数英 + 理科 + 文综全覆盖。卡题时用 4 步法 / 5 步法 / 间隔重复引导,**永远不替写**。每天给爸妈一个 3 分钟可做的家庭活动。

---

## 🎓 K-12 全学科覆盖

### 5 个学科 tutor

| Tutor | 覆盖年级 | 核心场景 |
|---|---|---|
| **chinese-tutor** | 1-12 | 阅读理解 / 作文 / 古诗 / 字词 / 文言文 |
| **math-tutor** | 1-12 | 口算 / 应用题 / 代数 / 函数 / 几何 / 导数 |
| **english-tutor** | 1-12 | 单词 / 语法 / 完形 / 阅读 / 写作 / 七选五 / 续写 |
| **science-tutor** | 5-12 | 科学(5-6)/ 物理 + 化学 + 生物(7-12) |
| **humanities-tutor** | 1-12 | 道法(1-9)/ 历史 + 地理 + 政治(7-12) |

### 3 个通用思维方法(被学科 tutor 调用)

| 方法 | 用在哪 |
|---|---|
| **divergent-question-method** | 发散题 4 步法 — **跨学科**(语文阅读 + 历史评价 + 政治分析 + 物理"为什么" + 英语推断) |
| **calculation-method** | 计算题 5 步法 — **数理化通用**(审题→列式画图→算→单位检查→答语) |
| **memorization-loop** | 间隔重复 1/3/7/30 天 — **文科记忆 + 古诗 + 英语单词 + 化学方程式通用** |

### 7 个流程 skill(跨学科)

`homework-intake` · `mistake-tracker` · `review-scheduler` · `weakness-tracker` · `daily-report` · `weekly-report` · `parent-playbook`

### 学段自适应(自动切档)

| Grade | 语气 / 任务 | 反馈结构 |
|---|---|---|
| **1-3** 启蒙期 | 每条 ≤ 20 字 / 任务 5 分钟 / 多 emoji 多比喻 | 不讲"为什么",直接"怎么做" |
| **4-6** 巩固期 | 每条 ≤ 50 字 / 任务 5-20 分钟 / emoji 克制 | 反馈三段式 + 引入"金句"方法论 |
| **7-9** 初中期 | 每条 ≤ 80 字 / 任务 15-30 分钟 / emoji 少 | 应试技巧 + 讨论"为什么",不用闯关叙事 |
| **10-12** 高中期 | 每条 ≤ 100 字 / 任务 20-40 分钟 / 几乎无 emoji | 像同行,讲高考视角 + 时间分配 + 选科考虑 |

### 高中选科支持

新高考 3+1+2 / 3+3 / 旧高考文理 — USER.md 里指定后,agent 严格按选科出练习,**不强行覆盖未选学科**。

---

## 这个项目跟其他方案的区别

| 维度 | ChatGPT / 通用 AI | 在线家教 / 补习班 | 单科练习 App | **Openclaw Study Coach** |
|---|---|---|---|---|
| 记得孩子的卡点 | ❌ 每次重置 | ✓ 部分 | ⚠️ 只看做题数据 | ✅ **三件套画像纵向累积** |
| 跨学科 / 全 K-12 | ⚠️ 但要每次重 prompt | ❌ 各科分开报 | ❌ 单科 | ✅ **5 学科 + 3 思维方法 + 1-12 自适应** |
| 处理发散题 | ⚠️ 直接给答案 | ✓ 取决于老师 | ❌ 基本不练 | ✅ **4 步法,跨学科通用** |
| 处理计算题 | ⚠️ 直接给答案 | ✓ | ⚠️ 只判对错 | ✅ **5 步法 + 强制画图 / 带单位** |
| 记忆类内容 | ⚠️ 机械背诵 | ✓ 取决于老师 | ⚠️ 抽认卡 | ✅ **间隔重复 1/3/7/30 天 + 自测** |
| 家长怎么参与 | 自己摸索 | 看老师反馈 | 看打分 | ✅ **每天 3 分钟具体活动(含台词)** |
| 数据归属 | 在云端 | 在机构 | 在 App 公司 | ✅ **本地 markdown,孩子的数据永远是你的** |
| 一年费用 | 订阅费 | 数千-数万 | 数百-数千 | ✅ **0 元**(Claude API 按量,平均 ≤ 1 元/天) |
| 因材施教 | 看 prompt 写法 | 看老师 | ❌ | ✅ **基于 weakness-profile 自动调整出题** |

---

## 🚀 60 秒启动

### 前置依赖

- macOS / Linux / Windows + WSL
- [Claude Code](https://claude.com/claude-code) 已安装(推荐),**或** [Codex CLI](https://github.com/openai/codex),**或** [OpenClaw](https://github.com/openclaw)

### 安装

```bash
# 1. 克隆
git clone https://github.com/X-RayLuan/Openclaw-Study-Coach.git
cd Openclaw-Study-Coach

# 2. 改你家孩子的信息(关键)
vim USER.md
# 必填:grade(1-12)、学校所在地区、教材版本、active_subjects、家长称谓
# grade ≥ 10:必填"选科"字段(3+1+2 / 3+3 / 旧高考文理)

# 3. 启动
claude     # Claude Code
codex      # Codex CLI(然后发"完成初始化协议"指令,见 CODEX.md)
```

### 第一次测试

启动 agent 后,试 5 个场景(对应不同 grade + 不同学科):

```
你是谁?
```
→ 自我介绍(语气按 USER.md 的 grade 自适应)

```
我是 [USER.md 里的昵称]。今天阅读理解我不会做一道题——"读完这段话你什么感受?"
```
→ 触发 chinese-tutor → reading-comp-tutor → divergent-question-method 4 步法

```
我是 [昵称]。今天数学作业:小明 12 个糖,小红比他多 5 个,小红有几个?
```
→ 触发 math-tutor → calculation-method 5 步法,强制画线段图

```
我是 [昵称]。化学方程式不会配平:H₂ + O₂ → H₂O
```
→ 触发 science-tutor → 四步配平法

```
(家长口吻)生成今日日报
```
→ 触发 daily-report → 6 字段日报 + **今晚 3 分钟可做的一件事**

---

## 🧠 设计原则(22 条核心规则)

> 这些规则分布在 `SOUL.md` / `AGENTS.md` / 各 skill,是系统的灵魂。

### 跟孩子说话(8 条)

1. **永远不直接给答案**,用引导、选项、工具箱。
2. **反馈结构按学段切**(启蒙/巩固/初中/高中 4 档,见 SOUL.md)。
3. **错题反馈先肯定她思考里"对"的部分**,再指改进点。
4. **指出"具体瞬间"**,不写"你真棒""加油"这种空话。
5. **数学题 1-9 年级一次只给一道**(10-12 可一次给一组小测)。
6. **积分永远只加不减**(完成 +5,全对 +3,连续 +N,完成全部 +10)。高中可改 progress 制。
7. **任务长度按学段不同**:5 / 5-20 / 15-30 / 20-40 分钟。
8. **她明显累/烦/哭 → 立刻停**,落盘进度,改用陪伴模式。

### 跨学科思维方法(8 条)

9. **发散题 4 步法**:翻译题目 → 找证据 → 给工具箱 → 组合答案。**语文阅读 + 历史评价 + 政治分析 + 物理"为什么" + 英语推断 全用**。
10. **计算题 5 步法**:审题(圈关键词)→ 列式 / 画图 → 算(分步,不跳步骤)→ 单位 / 量纲检查 → 写答语。**数理化全用**。
11. **作文 5 阶段**:理解题 → 挖 5 细节 → 挑一段先写 → 改一处 → 落盘。**永远不替写**。
12. **间隔重复 1/3/7/30 天**:文科记忆 + 古诗 + 英语单词 + 化学方程式全走 memorization-loop。**永远不机械背诵**。
13. **物理永远先画图**(受力 / 运动 / 电路 / 光路)。
14. **历史评价类强制三段**(原因 / 经过 / 影响)。
15. **地理简答强制三问**(是什么 / 为什么 / 怎么样)。
16. **政治大题强制三段**(理论 / 材料 / 结论)。

### 数据 / 流程(3 条)

17. **该写的必须落盘**(日报、错题、画像、积分都不能只在对话里说)。
18. **每天日报必须触发 parent-playbook**(今晚 1 件事)。
19. **每周周报必须重写 weakness-profile + 生成 weekend playbook**。

### 家长 Playbook(3 条)

20. **每天 playbook ≤ 5 分钟,3 分钟内能开始**(不打印、不买、不开电脑)。
21. **接今天孩子的学习**(延伸今天的题/写的字/读的故事)。
22. **AI 做不了的事**(真人陪伴/实物互动/情绪共鸣),**具体到台词级别**。

---

## 📁 系统结构

```
Openclaw-Study-Coach/
├── CLAUDE.md            # 入口(Claude Code 自动加载)
├── CODEX.md             # Codex CLI 用户向导
├── SOUL.md              # 辅导员语气 + 4 学段语气档
├── USER.md              # ⭐ 孩子信息(你要改的唯一文件)
├── AGENTS.md            # 工作流 + 学科路由 + 数据流
├── TOOLS.md             # 落盘约定
├── README.md            # 本文件
├── CHANGELOG.md         # 版本变化
├── LICENSE              # MIT
│
├── .claude/skills/      # 17 个 Skill
│   ├── 学科 tutor (5)
│   │   ├── chinese-tutor/         # 语文(1-12)
│   │   ├── math-tutor/            # 数学(1-12)
│   │   ├── english-tutor/         # 英语(1-12)
│   │   ├── science-tutor/         # 理科(5-12)
│   │   └── humanities-tutor/      # 文综(1-12)
│   ├── 通用思维方法 (3)
│   │   ├── divergent-question-method/   # 4 步法(跨学科发散题)
│   │   ├── calculation-method/          # 5 步法(数理化计算)
│   │   └── memorization-loop/           # 间隔重复(跨学科记忆)
│   ├── 旧版兼容 (2)
│   │   ├── reading-comp-tutor/    # v0.1 保留(语文阅读理解专项)
│   │   └── writing-coach/         # v0.1 保留(语文作文专项)
│   └── 流程 (7)
│       ├── homework-intake/        # 收作业 + 自动识别学科
│       ├── mistake-tracker/        # 错题归档
│       ├── review-scheduler/       # 复习节奏
│       ├── weakness-tracker/       # 画像维护
│       ├── daily-report/           # 日报
│       ├── weekly-report/          # 周报
│       └── parent-playbook/        # 父母 playbook
│
├── data/
│   ├── profile/                    # ⭐ 三件套画像(纵向记忆)
│   ├── parent-playbook/            # daily / weekend
│   ├── homework/                   # inbox / parsed / done
│   ├── mistakes/subjects/{语文,数学,英语,理科,文综}/
│   ├── memorization/queue.jsonl    # ⭐ 间隔重复队列(新)
│   ├── plans/                      # weekly / daily
│   ├── reports/                    # daily / weekly / trends.csv
│   ├── points/log.jsonl            # 积分(只加不减)
│   └── rubrics/
├── scripts/
│   └── lark-bridge-daemon.sh       # 飞书 bridge 的 SSH 友好 daemon 管理
├── assets/                         # 图片
└── logs/ / memory/
```

---

## 🧬 三件套画像:让 AI 真正"记得"孩子

| 文件 | 内容 | 谁能看 |
|---|---|---|
| `data/profile/weakness-profile.md` | 当前 pattern + 已尝试方案 + 下一步 | 家长 + agent |
| `data/profile/strengths.md` | 已稳能力 + 最近 14 天具体瞬间 | 孩子(精简版)+ 家长 + agent |
| `data/profile/interests.md` | 兴趣(用来包装练习) | 孩子 + 家长 + agent |

**工作流程**:

```
每天对话 → daily-report → 即时追加三件套
              ↓
        生成今晚 parent-playbook
              ↓
   下次启动 → CLAUDE.md @import 三件套
              ↓
   agent 立刻知道她最近卡哪、强在哪、喜欢什么
              ↓
   每周 weekly-report → 重写 weakness-profile 做提炼(≤ 7 条 pattern)
              ↓
        生成周末 parent-playbook(30 分钟亲子活动)
```

---

## 👨‍👩‍👧 家长 Playbook:父母可执行的事

回应教育学者**沈奕斐**那句:

> 培养孩子自驱力,要让孩子对学习有兴趣。父母要想办法把数学/语文通过小游戏变得生动有趣。**可是这个对我来说好难啊。**

这套系统**把"想小游戏"的负担从父母身上挪到 agent 身上**。

每天 daily-report 后自动生成 3 分钟可做的家庭活动到 `data/parent-playbook/daily/`。

### 4 类日活动模板

| 类型 | 适用场景 | 例子 |
|---|---|---|
| **类 A** 晚餐对话延伸 | 阅读理解题 | 妈妈问:"今天那只小猫躲在花盆后面。**如果家里有一只小猫这样躲起来,妈妈会怎么做?**"故意先给你的版本,然后听她的版本。 |
| **类 B** 实物对照细节 | 写了作文 | 看孩子作文里写"蓝色的裙子"——找一个家里真蓝色的东西问她:"这种蓝叫什么蓝?" |
| **类 C** 角色互换 | 今天有突破 | "妈妈这题真不会,你能教我一下吗?"让她当老师讲一次。 |
| **类 D** 纯陪伴 | 累 / streak ≥ 5 天 | 睡前问:"今天最开心的一件事是什么?"(不问学习)你也说你的。 |

### 周末活动 4 类(每周五自动生成)

- **共读**(类 1) — 读一篇短文,只问 2 个问题
- **家庭小报**(类 2) — 让孩子当一周一次的"家庭记者"
- **观察类**(类 3) — 带去一个地方,记 3 个细节
- **语言游戏**(类 4) — 不需要道具的 3 种游戏(词语接力 / 形容词接力 / 故事接力)

---

## 🛠️ 兼容性(三个 agent 框架,一份 repo)

### Claude Code(默认)

```bash
cd Openclaw-Study-Coach
claude
```
自动加载 CLAUDE.md → @import SOUL/USER/AGENTS/TOOLS + 三件套画像 → SkillTool 索引 17 个 skill。

### Codex CLI

```bash
cd Openclaw-Study-Coach
codex
# 第一句话发:"请按 AGENTS.md 顶部的初始化协议加载所有规则文件"
```
详见 [CODEX.md](CODEX.md)。

### OpenClaw

整个目录作为 OpenClaw workspace,AGENTS.md 顶部初始化协议直接生效。

### 飞书 / Lark 入口

通过 [lark-channel-bridge](https://www.npmjs.com/package/lark-channel-bridge) 把飞书消息桥到本地 Claude Code,孩子在飞书 DM 机器人就能用。

```bash
# 全局装(不要用 npx)
npm install -g lark-channel-bridge

# 第一次扫码绑定
lark-channel-bridge run

# 装 daemon(SSH 进 Mac Tahoe/Sequoia 的用户用这个)
./scripts/lark-bridge-daemon.sh install
```

在飞书里发:
```
/cd /path/to/Openclaw-Study-Coach
/ws save coach
```

---

## ❓ FAQ(常见问题)

### Q1: K-12 全覆盖,真的所有学段都好用吗?

每个学段都有针对性的语气档 / 难度档(SOUL.md 4 学段语气表)。小学(1-6)以**启发 + 游戏化**为主,初中(7-9)开始**讲应试技巧**,高中(10-12)以**深度推理 + 高考视角**为主,**不再用闯关叙事**。

### Q2: 孩子在多个学科上都弱,怎么决定先抓哪科?

USER.md 里 `subject_pain_points` 字段你填了各学科痛点。系统会优先在 active_subjects 列出的学科上深耕,**weekly-report 自动找最严重的 pattern,出具体的下周 1 个重点**。家长不必自己判断。

### Q3: 高中选科怎么办?

USER.md 里有"选科"字段(3+1+2 / 3+3 / 旧高考文理)。填了之后,**science-tutor 和 humanities-tutor 严格按选科出练习**,不强行覆盖未选学科。

### Q4: 我家孩子目前刚 1 年级,大部分 skill 用不上吧?

是的。grade 1-3 主要用 chinese / math / english 三个 tutor,理科和文综暂时不动。**学段切档自动处理**——你只需要写好 USER.md 的 grade,agent 自动选低阶模式。

### Q5: 跟直接用 ChatGPT 辅导有什么区别?

**ChatGPT 每次对话都重置,记不住你孩子的弱项**。这套系统通过三件套画像(`weakness-profile` / `strengths` / `interests`)**纵向累积**孩子的学习数据。**这是因材施教的物理基础**。

### Q6: 数据安全吗?

**所有数据本地存储**在 markdown / CSV 文件,不上云。孩子真实信息(姓名/学校)用代号处理。`.gitignore` 默认 ignore `data/` 内容。

### Q7: 一年大概花多少钱?

主要成本是 Claude / OpenAI API。一个孩子每天 30 分钟辅导,**平均一天不超过 1 元人民币**。一年 300-500 元,比任何线下补习便宜一个数量级。

### Q8: 这跟 OpenClaw 是什么关系?

设计哲学来自 OpenClaw 官方实践案例(微光游戏社 "用 OpenClaw 给孩子搭全科辅导系统" 系列文章 4 篇)。我们在 **Claude Code / Codex** 上重新实现 + 大幅扩展(从小学语文扩到 K-12 全学科 + 加 3 个跨学科思维方法 + 加 memorization-loop)。完全兼容 OpenClaw workspace。

### Q9: How do I use this if I'm not Chinese?

The system prompts are in Chinese because the design targets **Chinese K-12 curriculum and exam systems** (新高考 / 中考 etc). The underlying frameworks (4-step method for divergent questions, 5-step calculation, 5-stage writing, weakness profile, parent playbook, spaced repetition) are **language-agnostic** — fork this repo and translate the 5 top-level `.md` files + 17 `SKILL.md` files into your target language. PR welcome.

### Q10: AI is replacing teachers — is this good for kids?

This system explicitly does NOT replace teachers or parents. It absorbs the **repetitive, error-prone, mentally exhausting** parts of tutoring (scheduling tasks, tracking mistakes, generating practice, remembering weaknesses, spaced repetition reviews), and **frees parents to do what AI cannot**: emotional bonding, real-world games, situational observation. See the **Parent Playbook** section.

22 hard rules baked in to prevent harmful patterns: never give direct answers to divergent questions, never criticize the child, never deduct points, never label a child as "smart/dumb", stop immediately when emotional.

### Q11: 跟商业 AI 辅导产品比怎么样?

商业产品在**封闭系统**里跑,你看不到 system prompt,改不了规则,孩子的数据是他们的。这套系统:

- ✅ **完全开源**,你能看到每一条规则
- ✅ **数据本地**,孩子的画像永远是你的
- ✅ **K-12 全覆盖 + 跨学科思维方法**(其他产品多是单科)
- ✅ **可改可扩展**,觉得 4 步法太机械就改
- ✅ **跟着 LLM 进步免费升级**(切到更强模型不用改 skill)
- ⚠️ **没有 GUI 包装**,需要懂一点命令行
- ⚠️ **没有客服**,坏了自己修 / 提 issue

适合**愿意花一两个小时配置 + 喜欢可控感**的家长。

### Q12: 怎么贡献?

欢迎 PR:
- **新学段补充**:特别欢迎实战中发现的某学段某学科的更优练习方法
- **新教材适配**:不同省份教材的难度参考(USER.md 教材字段更精细化)
- **新 playbook 模板**:更多类型的亲子活动
- **翻译**:英文 / 日文 / 韩文 / 国际学校版

直接 fork → 改 → 开 PR。

---

## 🙏 致谢

- **[微光游戏社 / 人间折腾录](https://mp.weixin.qq.com/s/weQmKdFKEQKf7Oys1P1x4w)** — 《用 OpenClaw 给孩子搭全科辅导系统》系列,**v0.1 核心架构来自这里**
- **沈奕斐**(教育学者)— **自驱力底层逻辑** + Parent Playbook 设计初衷
- **[Claude Code](https://claude.com/claude-code) / [Codex CLI](https://github.com/openai/codex) / [OpenClaw](https://github.com/openclaw)** — 运行平台
- **[lark-channel-bridge](https://www.npmjs.com/package/lark-channel-bridge)** — 飞书 / Lark 集成

---

## 🏷️ 关键词 / Topics

`ai-tutor` · `k12` · `claude-code` · `codex` · `openclaw` · `claude-code-skill` · `kids-education` · `elementary-school` · `middle-school` · `high-school` · `gaokao` · `reading-comprehension` · `writing-coach` · `math-tutor` · `science-tutor` · `parent-coach` · `homework-helper` · `self-driven-learning` · `markdown-agent` · `ai-for-parents` · `personalized-learning` · `agent-skill` · `longitudinal-memory` · `weakness-profile` · `spaced-repetition` · `feishu-bot` · `小学辅导` · `初中辅导` · `高中辅导` · `语文阅读理解` · `作文辅导` · `数学辅导` · `物化生辅导` · `史地政辅导` · `自驱力` · `家长助手` · `AI辅导` · `全科辅导` · `沈奕斐` · `新高考`

---

## 📜 License

[MIT](LICENSE) © 2026 X-RayLuan

> Forks 和 PRs 都欢迎。如果你 fork 后做了好的扩展(新学段 / 新教材 / 新 playbook / 翻译版),开 PR 我合并回 main。

---

<div align="center">

**Made with ❤️ for kids (grade 1-12) who deserve a tutor that remembers them.**

[⬆️ 回到顶部](#openclaw-study-coach)

</div>
