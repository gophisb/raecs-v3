# Governance Change Approval

status: approved
approval_date: 2026-11-22
approval_basis: "Explicit human approval in the project conversation."
approved_decision: "ADR-2026-11-22-RELEASE-GATE-ALIGNMENT"
approved_scope:
  - "Remove the unsupported triple-consensus release requirement; do not claim consensus without an authenticated protocol and independent reviewers."
  - "Replace the ambiguous evidence-chain requirement with bounded objective-evidence verification."
  - "Align RAECS_POLICY.yaml to version 3.1.0 and align its validator and documentation."
  - "Wire existing security, static-analysis, Git-integrity, and objective-evidence checks into the release gate."
  - "Make missing required security-analysis tools block the release gate and install the required scanner in CI."
  - "Correct defects discovered in the release-gate implementation and its CI workflow."

limitations:
  - "This approval does not authorize changes to unrelated invariants, agent rules, or governance principles."
  - "This approval does not authorize merging into main."
  - "This record does not replace code review, branch protection, key management, or formal certification."
