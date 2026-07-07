# Vault Structure

Recommended enterprise vault layout:

```text
Enterprise-Vault/
├── hot.md
├── Home.md
├── 00-Dashboard/
│   ├── Agent-Actions.md
│   └── Review-Queue.md
├── actions/
├── company/
├── evidence/
├── openclaw/
│   ├── README.md
│   ├── manifest.json
│   ├── Corpus-Descriptions.md
│   └── Agentic-RAG-Workflow.md
├── products/
├── sales/
├── service/
└── source-materials/
```

Use folders by business object type. Keep raw intake files under `source-materials/` and distilled, cited evidence notes under `evidence/`.

`openclaw/Corpus-Descriptions.md` should describe each searchable corpus and when to route there. `openclaw/Agentic-RAG-Workflow.md` should define the sufficient-context check before an agent answers.

`Home.md` is the durable navigation hub. `hot.md` is the short fresh-session cache. Dashboards are operational views, not source-of-truth pages.

