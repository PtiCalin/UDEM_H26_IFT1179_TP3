# Generic School Project Outline

## Goal
A simple and reusable file structure for a school project (report + implementation + references).

## Recommended Structure

```text
school-project/
├── README.md
├── LICENSE
├── .gitignore
├── docs/
│   ├── proposal.md
│   ├── report.md
│   ├── presentation-outline.md
│   └── references.md
├── src/
│   ├── main.py                # or main.js / Main.kt / etc.
│   ├── config/
│   │   └── settings.example
│   ├── modules/
│   └── utils/
├── data/
│   ├── raw/
│   ├── processed/
│   └── samples/
├── tests/
│   ├── unit/
│   └── integration/
├── assets/
│   ├── images/
│   ├── diagrams/
│   └── slides/
├── scripts/
│   ├── setup.sh
│   └── run.sh
└── deliverables/
    ├── final-report.pdf
    └── final-presentation.pdf
```

## Minimal File Checklist

- README.md
- docs/proposal.md
- docs/report.md
- docs/references.md
- src/main.*
- tests/unit/*
- assets/slides/*
- deliverables/*

## Notes

- Keep raw data separate from processed data.
- Keep final deliverables separate from working files.
- Use clear file names with dates when needed (example: report-v1-2026-04-19.md).
