# OpenClaw Agent Sync

An OpenClaw-ready vault should include `openclaw/manifest.json`.

Minimal manifest:

```json
{
  "name": "enterprise-knowledge-base",
  "entrypoint": "Home.md",
  "hot_cache": "hot.md",
  "startup_order": [
    "openclaw/manifest.json",
    "openclaw/Corpus-Descriptions.md",
    "openclaw/Agentic-RAG-Workflow.md",
    "hot.md",
    "Home.md"
  ],
  "safe_paths": [
    "Home.md",
    "hot.md",
    "00-Dashboard/",
    "actions/",
    "company/",
    "evidence/",
    "products/",
    "sales/",
    "service/"
  ],
  "retrieval": {
    "corpus_descriptions": "openclaw/Corpus-Descriptions.md",
    "sufficient_context_workflow": "openclaw/Agentic-RAG-Workflow.md",
    "prefer_sections": ["frontmatter", "body", "Relationships"]
  },
  "governance": {
    "respect_status": true,
    "respect_visibility": true,
    "human_approval_required_for": [
      "price",
      "delivery_date",
      "warranty",
      "contract_terms",
      "customer_data_export",
      "public_publishing",
      "compliance_claims",
      "delete_knowledge"
    ]
  }
}
```

Agent startup behavior:

1. Read `openclaw/manifest.json`.
2. Read `openclaw/Corpus-Descriptions.md` for cross-corpus routing.
3. Read `openclaw/Agentic-RAG-Workflow.md` for sufficient-context checks.
4. Read `hot.md` for current navigation context.
5. Read `Home.md` for durable knowledge map.
6. Follow object links and action pages as needed.
7. Refuse or escalate when governance rules require approval.

