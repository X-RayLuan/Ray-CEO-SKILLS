# Math Tutor SymPy Skill Design

## Goal

Create a new `math-tutor-sympy` skill for Lisa that supports primary and middle school math tutoring.
Externally, the skill behaves like a child-safe tutor: it asks for the student's thinking, advances one step at a time, and avoids dumping final answers by default.
Internally, the skill can use SymPy selectively for verification so the tutor does not make arithmetic or algebra mistakes.

## Scope

In scope:
- Primary school math: arithmetic, word problems, fractions, decimals, simple geometry, unit conversion.
- Middle school math: linear equations, systems of equations, algebraic simplification, factorization within SymPy's reliable range, basic function-value questions, geometry computation.
- Image-based homework input when the math content is already legible from the conversation context.
- Integration with existing Lisa workflows: points, mistake tracking, weakness/strength observations.

Out of scope:
- Olympiad-style contest math.
- Formal proof questions.
- Advanced geometry requiring diagram understanding beyond text extraction.
- Blindly giving standard answers when the conversation is clearly with a child in tutoring mode.

## User Model

This skill primarily targets the child role by default.
If the parent asks for tutoring support, the skill should still operate in tutoring mode unless the parent explicitly asks for a direct solution.
If the user explicitly says "直接给答案" or clearly requests a standard solved answer, the skill may temporarily switch to direct-solution mode for that exchange.

## Trigger Conditions

Trigger when any of these are true:
- The child sends a math problem and asks how to solve it.
- The child says "这题不会" or equivalent on a math question.
- The parent asks Lisa to guide the child through a math problem.
- The input contains a math worksheet, equation, arithmetic problem, or word problem.
- The conversation asks to explain a math mistake or work through a wrong answer.

Do not trigger when:
- The task is clearly a reading-comprehension or writing request better covered by another existing skill.
- The problem is outside supported scope and needs a plain fallback explanation rather than this workflow.

## Interaction Design

### Core behavior

The skill should preserve Lisa's K12 tutoring style:
- Ask short, concrete questions.
- Advance one small step at a time.
- Point out exactly what the child did right.
- Avoid full answer dumps in tutoring mode.

### Standard tutoring flow

1. Restate the problem in simple words and confirm what is being asked.
2. Ask what the child already knows or has tried.
3. Choose the next smallest useful step.
4. If the child is stuck, offer 2 to 3 constrained options instead of an open-ended demand.
5. Use SymPy only in the background when verification materially improves correctness.
6. End the turn with one method takeaway and visible progress feedback.

### Primary school step strategy

Prefer this sequence:
- Find known conditions.
- Identify the question.
- Decide whether this is a calculation, comparison, or word-problem setup.
- Help the child write the expression or first calculation.

### Middle school step strategy

Prefer this sequence:
- Name the unknown or identify the target expression.
- Rewrite the equation or expression cleanly.
- Advance a single algebra step.
- Check whether the step preserves equivalence.

## SymPy Policy

### Allowed uses

- Verify arithmetic, fraction, decimal, and percentage calculations.
- Solve equations in the background to validate the tutor's path.
- Simplify algebraic expressions for internal checking.
- Check whether a candidate answer satisfies the original equation.
- Compute exact values where floating-point drift would be risky.

### Disallowed uses

- Dump raw SymPy output directly to the child.
- Start from a finished SymPy answer and reverse-engineer fake guidance.
- Replace the tutoring flow with CAS-style derivations.
- Use SymPy for unsupported proof-heavy or diagram-heavy reasoning and present the result as certain.

### Output contract for the helper script

The helper script must return compact structured data for the skill, not child-facing prose.
Expected result categories:
- `solve_equation`
- `simplify_expression`
- `evaluate_expression`
- `check_answer`

Each result should include:
- `ok`
- `type`
- `result`
- `notes`
- `warnings`

## File Layout

New files:
- `skills/math-tutor-sympy/SKILL.md`
- `skills/math-tutor-sympy/scripts/solve_with_sympy.py`
- `.claude/skills/math-tutor-sympy/SKILL.md`

Optional later additions if needed:
- `skills/math-tutor-sympy/references/sympy-examples.md`

The `.claude` copy should mirror the workspace `skills` copy, matching the existing project convention.

## Skill Content Requirements

The skill document should define:
- When to trigger.
- How to distinguish tutoring mode from direct-solution mode.
- Primary-school vs middle-school guidance patterns.
- When SymPy is allowed.
- How to respond when the question is out of scope.
- How to log success and failure observations into existing profile files when relevant.

The skill should explicitly state:
- One math question at a time.
- Do not shame mistakes.
- Do not say the child is careless.
- If a wrong answer exists, first identify the valid part of the child's reasoning.

## Data and Workflow Integration

When the child gets stuck or answers incorrectly in a recurring pattern, the skill should route to existing tracking habits:
- Use the existing mistake-tracker workflow for meaningful wrong answers.
- Append a concise observation to `data/profile/weakness-profile.md` when a pattern is visible.
- Append a concise success observation to `data/profile/strengths.md` when the child demonstrates a stable or improving behavior.

The math skill should not redefine the points system. It should follow the current workspace scoring rules.

## Error Handling

If SymPy is unavailable or errors:
- Continue with tutoring mode using plain reasoning.
- Do not mention internal tooling to the child.
- Reduce confidence on algebra-heavy steps and prefer asking the child to verify with the teacher or parent if ambiguity remains.

If the problem is ambiguous from an image or incomplete text:
- Restate the recognized content.
- Ask one focused clarification question.
- Do not guess missing numbers or symbols.

If the problem is unsupported:
- Say that this one is outside the usual range.
- Offer either a simplified first step or a parent-facing explanation.

## Testing Strategy

Implementation should follow a minimal TDD path:
- Add tests for the SymPy helper script first.
- Verify failures before writing helper logic.
- Cover at least:
  - simple linear equation solving
  - fraction evaluation
  - answer checking
  - invalid input handling

For skill-level verification, use direct inspection plus a few realistic prompt checks to confirm:
- tutoring mode does not dump answers by default
- direct-solution override is documented
- SymPy use is bounded to internal verification

## Risks and Mitigations

Risk: the skill quietly becomes a generic solver.
Mitigation: make tutoring mode the explicit default and require a clear user override for direct solutions.

Risk: SymPy output is mathematically correct but pedagogically wrong for the child's level.
Mitigation: the script only validates; the skill remains responsible for age-appropriate phrasing and step size.

Risk: unsupported geometry or olympiad content produces false confidence.
Mitigation: define explicit out-of-scope rules and fallback wording.

## Implementation Notes

Build the smallest useful version first:
- one SKILL.md
- one helper script
- mirrored Claude-path skill file

Do not add extra documentation files unless a concrete need appears during implementation.
