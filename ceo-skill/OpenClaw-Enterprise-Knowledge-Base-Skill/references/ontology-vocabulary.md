# Ontology Vocabulary

This vocabulary gives OpenClaw agents a stable enterprise wiki language. Keep it generic enough to reuse across companies, but specific enough that agents can reason over objects, relationships, permissions, and actions.

## Object Types

Use these as `type` values unless a project has a documented extension.

### Core Business Objects

- `company`: Company profile, legal names, brand names, entity relationships.
- `contact_policy`: Rules for handling customer, dealer, or supplier contact data.
- `product`: Sellable or supportable product model.
- `product_family`: Group of related products or model series.
- `part`: Spare part, accessory, attachment, consumable, or major component.
- `certification`: Certificate, compliance document, test report, or regulatory approval.
- `capability`: A verified ability such as lifting capacity, terrain suitability, power type, software feature, or service coverage.
- `constraint`: A limitation, exclusion, unresolved conflict, or condition that must be checked before answering.

### Sales Objects

- `sales_scenario`: Customer situation, use case, country requirement, or application context.
- `rfq_question`: Question the agent should ask before making a recommendation or quote draft.
- `quote_template`: Quote structure, commercial terms placeholder, or document skeleton.
- `competitor_comparison`: Approved comparison logic and claims.
- `country_requirement`: Market, import, emissions, certification, language, or customs requirement.
- `price_rule`: Internal rule for price handling. Keep visibility internal or management unless explicitly approved.

### Service Objects

- `service_rule`: Troubleshooting, inspection, warranty, maintenance, or escalation rule.
- `maintenance_schedule`: Routine inspection and maintenance cadence.
- `fault_case`: Known symptom, likely cause, evidence needed, and escalation path.
- `warranty_policy`: Warranty scope and approval rule.
- `spare_parts_policy`: Parts identification, quoting, shipping, and replacement policy.

### Agent And Governance Objects

- `action`: Approved agent behavior or workflow verb.
- `tool_contract`: Tool input/output contract, side effects, and approval boundary.
- `retrieval_config`: Corpus routing map, retrieval policy, or cross-corpus search description.
- `workflow`: Reusable multi-step agent procedure such as sufficient-context checking.
- `evidence`: Source note distilled from files, pages, messages, calls, PDFs, screenshots, or datasets.
- `dashboard`: Review queue, action index, coverage map, or QA dashboard.
- `qa_test`: Question, expected behavior, actual answer, verdict, and fix path.
- `correction_rule`: Rule created after a wrong answer, conflict, or unsafe behavior.
- `hot_cache`: Root startup context in `hot.md`.

## Status Vocabulary

- `verified`: Human-reviewed and safe to use according to visibility.
- `needs_review`: Not ready for external answers.
- `conflicting`: Multiple sources disagree. The agent must explain uncertainty or escalate.
- `deprecated`: Retained for history. The agent must not use it as active truth.

## Visibility Vocabulary

- `public`: May appear in customer-facing answers when `status: verified`.
- `dealer`: May be used with authorized dealers or partners.
- `internal`: Staff-facing only.
- `management`: Restricted management context.

## Relationship Predicates

Use lowercase snake_case. Prefer this vocabulary before inventing new predicates.

### Source And Evidence

- `derived_from:: [[Evidence-Page]]`: Object was created from a source note.
- `supported_by:: [[Evidence-Page]]`: Claim is backed by evidence.
- `conflicts_with:: [[Object-Page]]`: Facts disagree or cannot both be true.
- `supersedes:: [[Object-Page]]`: Newer object replaces older one.
- `deprecated_by:: [[Object-Page]]`: Older object should redirect to newer one.

### Product And Capability

- `belongs_to_family:: [[Product-Family]]`
- `has_part:: [[Part]]`
- `uses_part:: [[Part]]`
- `has_certification:: [[Certification]]`
- `has_capability:: [[Capability]]`
- `limited_by:: [[Constraint]]`
- `suitable_for:: [[Sales-Scenario]]`
- `not_suitable_for:: [[Sales-Scenario]]`
- `requires_check:: [[Constraint]]`

### Sales

- `requires_question:: [[RFQ-Question]]`
- `quoted_by:: [[Quote-Template]]`
- `recommended_for:: [[Sales-Scenario]]`
- `requires_country_requirement:: [[Country-Requirement]]`
- `compared_with:: [[Competitor-Comparison]]`
- `uses_price_rule:: [[Price-Rule]]`

### Service

- `diagnosed_by:: [[Service-Rule]]`
- `has_fault_case:: [[Fault-Case]]`
- `requires_maintenance:: [[Maintenance-Schedule]]`
- `covered_by_warranty:: [[Warranty-Policy]]`
- `requires_part:: [[Part]]`
- `escalates_to:: [[Action-Page]]`

### Governance And Actions

- `performed_by:: [[Action-Page]]`
- `requires_approval_from:: [[Role-Or-Policy]]`
- `reads_from:: [[Folder-Or-Object]]`
- `writes_to:: [[Folder-Or-Object]]`
- `creates:: [[Object-Type-Or-Page]]`
- `updates:: [[Object-Type-Or-Page]]`
- `tested_by:: [[QA-Test]]`
- `fixed_by:: [[Correction-Rule]]`
- `routes_to:: [[Corpus-Or-Folder]]`
- `requires_context_check:: [[Workflow-Or-Policy]]`

## Action Families

Action pages should be verbs. Use stable action IDs.

### Sales Actions

- `classify-inquiry`: Identify buyer intent, product family, market, and missing facts.
- `recommend-product`: Suggest candidate products with assumptions and required checks.
- `create-quote-draft`: Draft a quote structure for human approval.
- `prepare-rfq-questions`: Generate the missing-question list before recommendation.
- `compare-competitor`: Produce an approved comparison with no unsupported claims.

### Service Actions

- `create-service-case`: Collect symptoms, serial/model data, photos/videos, urgency, and safety risk.
- `triage-fault`: Map symptoms to known fault cases and escalation paths.
- `suggest-maintenance-check`: Provide low-risk inspection checklist from verified service rules.
- `request-spare-parts-info`: Ask for part identifiers, model, serial number, and evidence.
- `escalate-service-risk`: Stop unsafe troubleshooting and route to a human technician.

### Knowledge Actions

- `ingest-source-material`: Convert raw material into evidence and object pages.
- `validate-vault`: Check frontmatter, duplicate IDs, public verification, and hot cache.
- `log-wrong-answer`: Capture bad answer, expected answer, root cause, and fix path.
- `create-correction-rule`: Turn a wrong answer into a reusable rule.
- `refresh-hot-cache`: Update `hot.md` with current focus, related pages, and next step.
- `route-corpus`: Select the smallest sufficient set of corpora for a request.
- `sufficient-context-check`: Decide whether retrieved evidence is complete, traceable, and export-safe before answering.

## Approval Gates

Default rule: the agent may draft, classify, summarize, and ask clarifying questions. A human must approve commitments and high-risk outputs.

Require human approval for:

- Price, discount, tax, currency, payment terms, or final quote.
- Delivery date, lead time, availability, inventory, or shipment promise.
- Warranty approval, free replacement, refund, or liability statement.
- Contract terms, legal interpretation, compliance certification, or customs claim.
- Public publishing, customer email sending, social posting, or dealer-facing broadcast.
- Customer data export, private document sharing, deletion, or irreversible edits.
- Dangerous repair instructions or safety-critical diagnosis.

## Wrong-Answer Correction Loop

When an agent gives a bad answer, do not only patch the prompt. Add durable knowledge.

Create or update:

1. `qa_test`: the user question, expected answer, actual answer, verdict, and source pages.
2. `correction_rule`: the rule that would prevent the same error.
3. A related object page if the missing fact belongs in the ontology.
4. `hot.md` only if the correction is part of the current active workstream.

Relationships:

```markdown
## Relationships

- tested_by:: [[QA-Test-Example]]
- fixed_by:: [[Correction-Rule-Example]]
- supported_by:: [[Evidence-Example]]
```

## Extension Rule

Projects may add industry-specific object types and relationships. Document extensions in a project-local `ontology-extension.md` and keep the global vocabulary stable.
