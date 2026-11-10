---
name: check-review
description: Review a trento check in the trento-project checks repository. Use when asked to review a a check .yaml file in this repo.
---

# Check Review

Review a check yaml file in this repo the way a (SAP Solutions Engineering) member would.

## Inputs

- A file path under `checks/`; review the file.

## Procedure

1. **Read** `https://github.com/trento-project/wanda/blob/main/guides/specification.adoc`. This document defines what a compliant trento check should look like. Skim `README.md` for process context if needed.
2. **Compliance check.** Against the docs above, verify:
   - Verify the **filename** convention.
   - Verify the the trento-check **structure** as specified in the document.
   - Verify the trento-check **id**.
   - Verify the the trento-check **name**.
   - Verify **group** as specified.
   - Should have a proper **description** as specified that makes it clear what the trento-check purpose is.
   - Must have a **remediation** as specified that should make sense with the **description** itself.
   - Verify trento-check has a **severity** as specified.
   - **Metadata** is correct: consult with the specification.
   - **Facts**: Ensure the correct gatherer or gatherers are used for the trento-check.
   - **Values**: Use the expression language format (https://github.com/trento-project/wanda/blob/main/guides/expression-language.adoc) for verification.
   - **Expectations**: Use the expression language format (https://github.com/trento-project/wanda/blob/main/guides/expression-language.adoc) for verification, also make sure the correct values and facts are used. Do not check only the syntax but make sure it is semantically correct.
3. **Report findings** (format below). Answer in precise, objective, technically correct terms; informal tone; no marketing speak.

## Findings format

Group by severity, most severe first. Each finding: location, the issue, why it matters, and a concrete suggestion.

- **Blocker** — correctness flaw that should stop approval until resolved.
- **Major** — significant gap, risk; must be addressed before testing.
- **Minor** — clarity, completeness, or compliance nit.
- **Question** — something the description leaves ambiguous; ask the author.

Summarize with an overall verdict: whether the trento-check is ready for test.

## Conduct

- Calibrate every claim: mark assumptions explicitly, say "I don't know" when you don't, and verify before asserting.
- Point out flaws and pitfalls candidly. Serve correctness, not the author's comfort.
- Ask clarifying questions instead of guessing intent.
- Do not propose next steps unless explicitly asked.
