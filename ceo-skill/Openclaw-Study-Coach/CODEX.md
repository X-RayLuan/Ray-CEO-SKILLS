# CODEX.md — Codex CLI 用户快速入门

> 这份文件只为 [OpenAI Codex CLI](https://github.com/openai/codex) 用户存在。如果你用 Claude Code,请看 `CLAUDE.md`。Codex 不读 `CLAUDE.md`,所以两份文件并存,各自服务各自的入口。

## 1 分钟启动

```bash
# 1. cd 进 workspace
cd Openclaw-Study-Coach

# 2. 改孩子信息(只需要改 USER.md 一份)
vim USER.md

# 3. 启动 Codex
codex
```

## 必做:第一次启动后发这句话

Codex 启动后,**第一句话**发以下指令,让它完成初始化协议:

```
请读 AGENTS.md,然后按 AGENTS.md 顶部的「初始化协议」section 依次读 SOUL.md / USER.md / TOOLS.md / data/profile/weakness-profile.md / data/profile/strengths.md / data/profile/interests.md。读完后用 3 句话总结你是谁、面对的孩子是谁、当前最关注的 pattern,然后等我下一步指令。
```

读完这一批文件,Codex 就"加载完了"你的辅导员角色。后面照常用即可。

## 后续使用

跟用 Claude Code 一样:

**孩子端**:
- 发文字作业 / 图片作业
- 问单道题"这题我不会"
- 报告完成"我做完了" → 触发日报

**家长端**:
- "生成今日日报" → 日报 + 今晚父母 1 件事
- "生成本周周报" → 周报 + 周末活动
- "看一下她最近怎么样" → 综合汇报

## Codex vs Claude Code 的微妙差别

| 维度 | Claude Code | Codex |
|---|---|---|
| 入口文件 | `CLAUDE.md`(自动加载) | `AGENTS.md`(自动加载) |
| 加载 SOUL/USER/TOOLS | `@import` 自动 | 需要你**第一句话**触发(见上) |
| Skill 加载 | `.claude/skills/` 自动索引,Skill tool 触发 | Codex 看 AGENTS.md 里的「Skill 索引表」**按需 read** 对应文件 |
| 输出风格 | Anthropic Claude(更温柔、长文善于) | OpenAI GPT(更结构化、列表友好) |
| 多模态(图片输入) | 原生支持 | 取决于 Codex 版本(部分支持) |
| 长文 context | Claude 4.x 200k tokens | GPT-5 ≥ 128k tokens |

## 如果 Codex 跑得不"像辅导员"

最常见原因:**你忘了发"初始化协议"那句话**,Codex 没把 SOUL/USER 加载进 system prompt。

解决:再发一次:

```
请重新执行 AGENTS.md 的初始化协议,确认你已读 SOUL.md / USER.md / 三件套画像。
```

## 如果你想跟 Claude Code 同步用

完全可以。一个 workspace 同时用两个 agent 跑没问题——它们读写的都是同一份 `data/`。但要注意:

- **不要同时跑两个 agent**(防止 file race condition)。一次只跑一个。
- 一份 `data/profile/` 是共享的,两个 agent 都会读到最新画像。
- 你今天用 Codex 跑了一天,明天用 Claude Code 跑,**Claude Code 完全无缝接上**——所有数据本来就在文件里。

## 进阶:OpenClaw 作为 Codex 的"工作区管理器"

如果你用 OpenClaw(跟 Codex 同样读 AGENTS.md),可以把这份 workspace 作为 OpenClaw 的一个 agent:

1. 在 OpenClaw Control 创建 agent `study-coach`
2. 把 workspace path 指向这个目录
3. OpenClaw 会读 AGENTS.md 作为系统指令

这等同于"Codex + workspace 管理 + 飞书入口"的组合。详见 [README.md 的「飞书 / Lark 入口」节](README.md#兼容性)。
