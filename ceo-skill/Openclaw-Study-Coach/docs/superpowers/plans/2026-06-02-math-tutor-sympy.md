# Math Tutor SymPy Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build a child-safe math tutoring skill with a small SymPy helper that supports internal verification without turning Lisa into a direct answer bot.

**Architecture:** Add one new skill folder with a concise `SKILL.md` plus a focused Python helper script. Keep the helper pure and structured so the tutoring behavior stays in the skill instructions, then mirror the skill file into `.claude/skills` to match the current workspace convention.

**Tech Stack:** Markdown skills, Python 3, SymPy, unittest

---

## File Structure

- Create: `skills/math-tutor-sympy/SKILL.md`
- Create: `skills/math-tutor-sympy/scripts/solve_with_sympy.py`
- Create: `skills/math-tutor-sympy/tests/test_solve_with_sympy.py`
- Create: `.claude/skills/math-tutor-sympy/SKILL.md`

### Task 1: Add failing tests for the SymPy helper

**Files:**
- Create: `skills/math-tutor-sympy/tests/test_solve_with_sympy.py`
- Test: `skills/math-tutor-sympy/tests/test_solve_with_sympy.py`

- [ ] **Step 1: Write the failing test**

```python
import json
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SCRIPT = ROOT / "scripts" / "solve_with_sympy.py"


def run_case(payload):
    proc = subprocess.run(
        [sys.executable, str(SCRIPT)],
        input=json.dumps(payload),
        text=True,
        capture_output=True,
        check=False,
    )
    return proc


def parse_stdout(proc):
    return json.loads(proc.stdout)


def test_solves_linear_equation():
    proc = run_case({"type": "solve_equation", "equation": "2*x + 3 = 11", "symbol": "x"})
    assert proc.returncode == 0
    data = parse_stdout(proc)
    assert data["ok"] is True
    assert data["type"] == "solve_equation"
    assert data["result"]["solutions"] == ["4"]


def test_evaluates_fraction_expression_exactly():
    proc = run_case({"type": "evaluate_expression", "expression": "1/3 + 1/6"})
    assert proc.returncode == 0
    data = parse_stdout(proc)
    assert data["ok"] is True
    assert data["result"]["value"] == "1/2"


def test_checks_candidate_answer():
    proc = run_case(
        {
            "type": "check_answer",
            "equation": "x + 5 = 12",
            "symbol": "x",
            "candidate": "7",
        }
    )
    assert proc.returncode == 0
    data = parse_stdout(proc)
    assert data["ok"] is True
    assert data["result"]["is_correct"] is True


def test_rejects_invalid_payload():
    proc = run_case({"type": "unknown"})
    assert proc.returncode == 0
    data = parse_stdout(proc)
    assert data["ok"] is False
    assert data["warnings"]
```

- [ ] **Step 2: Run test to verify it fails**

Run: `python3 -m unittest discover -s skills/math-tutor-sympy/tests -p 'test_*.py' -v`
Expected: FAIL because `solve_with_sympy.py` does not exist yet.

- [ ] **Step 3: Commit**

```bash
git add skills/math-tutor-sympy/tests/test_solve_with_sympy.py
git commit -m "test: add SymPy helper coverage"
```

### Task 2: Implement the minimal SymPy helper

**Files:**
- Create: `skills/math-tutor-sympy/scripts/solve_with_sympy.py`
- Test: `skills/math-tutor-sympy/tests/test_solve_with_sympy.py`

- [ ] **Step 1: Write minimal implementation**

```python
#!/usr/bin/env python3
import json
import sys
from sympy import Eq, simplify, solve, sympify


def emit(payload):
    sys.stdout.write(json.dumps(payload, ensure_ascii=True) + "\n")


def error_result(kind, warning):
    return {"ok": False, "type": kind, "result": {}, "notes": [], "warnings": [warning]}


def parse_equation(raw):
    if "=" not in raw:
        raise ValueError("equation must contain '='")
    left, right = raw.split("=", 1)
    return Eq(sympify(left.strip()), sympify(right.strip()))


def solve_equation(payload):
    symbol_name = payload.get("symbol", "x")
    equation = parse_equation(payload["equation"])
    symbol = sympify(symbol_name)
    solutions = solve(equation, symbol)
    return {
        "ok": True,
        "type": "solve_equation",
        "result": {"solutions": [str(item) for item in solutions]},
        "notes": [],
        "warnings": [],
    }


def evaluate_expression(payload):
    value = simplify(sympify(payload["expression"]))
    return {
        "ok": True,
        "type": "evaluate_expression",
        "result": {"value": str(value)},
        "notes": [],
        "warnings": [],
    }


def check_answer(payload):
    symbol_name = payload.get("symbol", "x")
    symbol = sympify(symbol_name)
    candidate = sympify(payload["candidate"])
    equation = parse_equation(payload["equation"])
    substituted = equation.subs(symbol, candidate)
    is_correct = bool(simplify(substituted.lhs - substituted.rhs) == 0)
    return {
        "ok": True,
        "type": "check_answer",
        "result": {"is_correct": is_correct, "candidate": str(candidate)},
        "notes": [],
        "warnings": [],
    }


def simplify_expression(payload):
    value = simplify(sympify(payload["expression"]))
    return {
        "ok": True,
        "type": "simplify_expression",
        "result": {"value": str(value)},
        "notes": [],
        "warnings": [],
    }


HANDLERS = {
    "solve_equation": solve_equation,
    "evaluate_expression": evaluate_expression,
    "check_answer": check_answer,
    "simplify_expression": simplify_expression,
}


def main():
    try:
        payload = json.load(sys.stdin)
        kind = payload.get("type", "unknown")
        handler = HANDLERS.get(kind)
        if handler is None:
            emit(error_result(kind, "unsupported type"))
            return 0
        emit(handler(payload))
        return 0
    except Exception as exc:
        emit(error_result("internal_error", str(exc)))
        return 0


if __name__ == "__main__":
    raise SystemExit(main())
```

- [ ] **Step 2: Run test to verify it passes**

Run: `python3 -m unittest discover -s skills/math-tutor-sympy/tests -p 'test_*.py' -v`
Expected: PASS for equation solving, exact fraction evaluation, answer checking, and invalid input handling.

- [ ] **Step 3: Commit**

```bash
git add skills/math-tutor-sympy/scripts/solve_with_sympy.py skills/math-tutor-sympy/tests/test_solve_with_sympy.py
git commit -m "feat: add SymPy verification helper"
```

### Task 3: Add the skill instructions

**Files:**
- Create: `skills/math-tutor-sympy/SKILL.md`

- [ ] **Step 1: Write the skill**

```markdown
---
name: math-tutor-sympy
description: 小学到初中数学辅导,默认一步一步带孩子做题,必要时用 SymPy 在后台验算、解方程、检查答案,但不直接把完整解答倒给孩子。当孩子发来数学题、说“这题不会”、家长说“带她做数学”,或要检查一道数学错题时使用。
---

# 数学辅导 SymPy Skill

## 什么时候触发

满足任一条件:
- 孩子发来数学题
- 孩子说“这题不会”“这道应用题怎么做”“这个方程怎么列”
- 家长说“带她做这道数学题”“看看她这题为什么错”
- 图片里是可辨认的数学作业或错题

## 默认模式

默认是**孩子辅导型**,不是直接解题器。
除非用户明确说“直接给答案 / 直接解”,否则不要直接给完整答案。

## 一般流程

1. 先用大白话复述题目,确认问的是什么。
2. 先问孩子想到哪一步了。
3. 一次只推进一小步。
4. 孩子卡住时,给 2-3 个方向让她选。
5. 需要时再用 SymPy 在后台验算,不要把原始输出贴给孩子。
6. 收尾给一句“下次这类题怎么办”的方法金句。

## 小学题怎么带

优先顺序:
- 找条件
- 找问题
- 判断是算总数、比较、平均、倍数,还是单位换算
- 帮她先列出第一步算式

不要一口气把整道应用题全拆完。

## 初中题怎么带

优先顺序:
- 先找未知数
- 重写题目里的式子或方程
- 一次只做一步变形
- 每做一步都检查“这一步为什么能这样变”

## SymPy 什么时候用

可以用在后台做这些事:
- 验算分数、小数、百分数
- 解一元一次方程或基础方程做校验
- 化简代数式
- 检查孩子的答案对不对

不要这样用:
- 不要先算出最终答案再假装引导
- 不要把 SymPy 的原始表达式直接发给孩子
- 不要把它当成竞赛题求解器

调用脚本:
`python3 skills/math-tutor-sympy/scripts/solve_with_sympy.py`

输入是 JSON,至少包含 `type`。支持:
- `solve_equation`
- `evaluate_expression`
- `simplify_expression`
- `check_answer`

## 反馈规则

- 先指出孩子哪里想对了,再纠偏
- 不说“粗心”
- 一次只给一道数学题
- 如果孩子明显烦了,先停,记进度,别硬推

## 落盘联动

如果看到了重复卡点:
- 走 `mistake-tracker` 的错题流程
- 在 `data/profile/weakness-profile.md` 追加一句观察

如果看到了明确进步:
- 在 `data/profile/strengths.md` 追加一句具体做对的瞬间

## 超出范围时

这些情况不要硬解:
- 奥数
- 证明题
- 图形信息缺太多的几何题

这时直接说这题超出平时辅导范围,先给一个能做的第一步,或者转成给家长的解释。
```

- [ ] **Step 2: Inspect the file for trigger coverage**

Run: `sed -n '1,240p' skills/math-tutor-sympy/SKILL.md`
Expected: The trigger text, default tutoring mode, SymPy policy, and fallback rules are all present.

- [ ] **Step 3: Commit**

```bash
git add skills/math-tutor-sympy/SKILL.md
git commit -m "feat: add math tutor skill instructions"
```

### Task 4: Mirror the skill into the Claude path and verify

**Files:**
- Create: `.claude/skills/math-tutor-sympy/SKILL.md`
- Verify: `skills/math-tutor-sympy/SKILL.md`

- [ ] **Step 1: Copy the skill file**

```bash
mkdir -p .claude/skills/math-tutor-sympy
cp skills/math-tutor-sympy/SKILL.md .claude/skills/math-tutor-sympy/SKILL.md
```

- [ ] **Step 2: Run final verification**

Run:
- `cmp -s skills/math-tutor-sympy/SKILL.md .claude/skills/math-tutor-sympy/SKILL.md`
- `python3 -m unittest discover -s skills/math-tutor-sympy/tests -p 'test_*.py' -v`

Expected:
- `cmp` exits 0
- all tests pass

- [ ] **Step 3: Commit**

```bash
git add .claude/skills/math-tutor-sympy/SKILL.md
git commit -m "chore: mirror math tutor skill for Claude"
```

## Self-Review

- Spec coverage: trigger logic, tutoring mode, SymPy boundary, helper script, mirror path, testing, and fallback handling are all covered by Tasks 1-4.
- Placeholder scan: no TODO/TBD markers remain.
- Type consistency: helper types are consistent across the plan and the documented script contract.
