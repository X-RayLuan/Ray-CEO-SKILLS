# Hot Cache

`hot.md` is a root-level startup cache for fresh agent sessions.

It should answer four questions quickly:

1. What is the active topic?
2. What are the latest trusted conclusions?
3. Which pages should the agent read next?
4. What is the next concrete step?

Recommended frontmatter:

```yaml
---
type: hot_cache
object_id: hot-cache
status: verified
visibility: internal
owner: knowledge
source:
  - internal
last_reviewed: 2026-06-08
---
```

Recommended body shape:

```markdown
2026-06-08 | Enterprise KB | Current focus is OpenClaw Q&A readiness. Recent conclusions: products, sales quote drafts, and service intake are covered; risky commitments still need human approval. Related pages: Home.md, 00-Dashboard/Agent-Actions.md, actions/Create-Quote-Draft.md. Next step: run QA tests and log wrong answers.
```

Keep it short:

- Chinese: 500 characters or less.
- English: roughly 900 characters or less.

`hot.md` is not a customer-facing evidence source. If an answer needs a factual claim, cite the underlying verified object page or evidence note.

