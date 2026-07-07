# Agentic RAG And Cross-Corpus Retrieval

Use this reference when designing an OpenClaw enterprise vault that must answer across multiple knowledge areas without guessing from partial context.

The pattern adapts agentic RAG ideas to a Markdown/Obsidian vault:

1. classify the business workflow,
2. route the query to the right corpora,
3. retrieve object frontmatter, body, and relationships,
4. run a sufficient-context check,
5. iterate retrieval or ask the shortest missing follow-up questions,
6. answer conservatively with citations and approval flags.

## Recommended Files

Add these reusable OpenClaw notes to enterprise vaults that need cross-corpus RAG behavior:

```text
openclaw/
├── README.md
├── manifest.json
├── Corpus-Descriptions.md
└── Agentic-RAG-Workflow.md
```

`Corpus-Descriptions.md` is a routing map. `Agentic-RAG-Workflow.md` is the answer-before-check workflow. Both are usually `visibility: internal` and should start as `status: needs_review` until a knowledge owner approves them.

## Corpus Descriptions Pattern

Create one internal note that describes each searchable knowledge area. Keep descriptions operational: when to route there, what questions it can answer, and what governance cautions apply.

Example:

```markdown
---
type: retrieval_config
object_id: corpus-descriptions
status: needs_review
visibility: internal
owner: knowledge
source:
  - internal
last_reviewed:
---

# Corpus Descriptions For Agentic Retrieval

## Routing Rule

For every business question:

1. Read governance and tool-contract notes first.
2. Identify the likely workflow.
3. Select the smallest set of corpora that can answer the workflow.
4. Prefer each note's frontmatter, body, and `## Relationships` section.
5. Run a sufficient-context check before answering.

## Corpora

### `openclaw/` — Governance And Runtime Contracts

Use for answer safety, visibility, approval gates, tool contracts, and startup behavior.

### `products/` — Product Objects And Specs

Use for model lookup, product family lookup, candidate product selection, configuration comparison, and product relationships.

Caution: unreviewed product pages must not be presented as confirmed external facts.

### `sales/` — RFQ, Quotation, Country, And Sales Rules

Use for missing RFQ fields, quote structure, country-specific intake questions, and commercial draft checklists.

Approval gates: price, payment terms, delivery date, warranty, validity, trade term, discount, freight scope, and final sending.

### `service/` — Service, Warranty, And Spare Parts

Use for symptom intake, support escalation, warranty boundaries, maintenance, and spare-parts identification.

Approval gates: final diagnosis, warranty result, final part number, stock, price, and shipment.

### `source-materials/` And `evidence/` — Source Inventory And Evidence

Use to determine what raw material exists, what has been reviewed, and what evidence is missing before external use.
```

## Agentic RAG Workflow Pattern

Create one internal workflow note that tells the agent how to decide whether it has enough context to answer.

Example:

```markdown
---
type: workflow
object_id: agentic-rag-workflow
status: needs_review
visibility: internal
owner: knowledge
source:
  - internal
last_reviewed:
---

# Agentic RAG Workflow

## Standard Pipeline

### 1. Classify The Request

Classify the user request into one or more workflows, such as inquiry classification, recommendation, quote draft, service case, spare parts, compliance review, or knowledge verification.

### 2. Route To Corpora

Use `openclaw/Corpus-Descriptions.md` to choose the smallest sufficient set of corpora.

### 3. Retrieve Evidence

For each selected note, prefer:

1. frontmatter: `type`, `object_id`, `status`, `visibility`, `required_inputs`, `approval_required`, `source`, `last_reviewed`,
2. body sections that directly answer the question,
3. `## Relationships` links,
4. source-material or evidence gap notes when confidence is low.

### 4. Run Sufficient-Context Check

| Check | Pass condition | If fail |
|---|---|---|
| Scope coverage | Every major user sub-question has evidence | Continue retrieval or list missing fields |
| Source quality | Evidence has usable `status` and `visibility` for the audience | Add review warning or withhold external claim |
| Required inputs | Workflow required fields are present | Ask shortest follow-up questions |
| Approval gates | No restricted promise is finalized | Mark human approval required |
| Conflict check | No conflicting sources are merged | Create verification gap / ask human |
| Traceability | Answer can cite object names or paths | Retrieve source note before answering |

### 5. Iterate If Context Is Insufficient

If context is insufficient, do not force an answer. State what was found, state exactly what is missing, then retrieve again from another corpus or ask the user for the missing input.

### 6. Answer Conservatively

Separate confirmed facts, draft recommendations, missing fields, approval requirements, and next actions.
```

## Sufficient-Context Feedback Log

When context is insufficient, capture a short feedback log. This makes the next retrieval step explicit.

```text
Found: relevant product family and application scenario.
Missing: destination market, quantity, compliance requirement, and verified availability.
Next retrieval: products/, sales/rfq questions, source-materials/missing evidence.
Decision: do not create a final quote; ask missing RFQ questions and mark human approval required.
```

## Tool Contract Extensions

For vaults with explicit tool contracts, add two contracts:

```markdown
## route_corpus

Input: user request, workflow guess, optional audience/role.

Output: selected corpora, reason for each corpus, required source files to read first, and retrieval gaps.

Rule: use `openclaw/Corpus-Descriptions.md`; always include governance for customer-facing, commercial, service, spare-parts, certification, compliance, destructive, or privacy-sensitive work.

## sufficient_context_check

Input: user request, workflow, retrieved objects, intended audience.

Output: `sufficient: true|false`, found facts, missing facts, unsafe/unverified facts, approval gates, next retrieval targets or follow-up questions.

Rule: do not answer as confirmed when required inputs, source quality, visibility, approval gates, conflict status, or traceability are insufficient. If insufficient, either retrieve again or ask the shortest necessary follow-up questions.
```

## Default Workflow-To-Corpus Routing

| Workflow | Required corpora |
|---|---|
| Product or capability recommendation | `openclaw/`, `products/`, relevant scenario/sales corpora |
| Quote or proposal draft | `openclaw/`, `products/`, `sales/`, relevant scenario/evidence corpora |
| Service case | `openclaw/`, `service/`, `products/`, evidence/source gaps if needed |
| Spare parts | `openclaw/`, `parts/` or `service/`, `products/`, source evidence |
| Certification or compliance | `openclaw/`, `certifications/` or `evidence/`, relevant product objects |
| Knowledge gap review | `openclaw/`, `source-materials/`, target object directory |

## Answer Format After Retrieval

For internal users, prefer:

1. **Confirmed / usable facts** — cite object names or paths.
2. **Draft recommendation or draft reply** — label drafts clearly.
3. **Missing fields / risks** — list only decision-critical gaps.
4. **Approval required** — commercial, legal, compliance, support, privacy, destructive, or final-send gates.
5. **Next action** — one or two concrete steps.

For external drafts, hide internal-only reasoning and expose only approved facts plus review placeholders.
