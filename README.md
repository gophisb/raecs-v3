# RAECS v3.0

**Rafeeq Autonomous Engineering Command System**

RAECS is an engineering-governance baseline for AI agents. Its purpose is not to make agents autonomous without limits; it is to make autonomy **bounded, auditable, reversible, and subordinate to explicit human authority**.

## Core chain

**Policy → Agent Rules → Invariants → Execution → Verification → Logging → Decision Review → Checkpoint/Release**

## Quick start

```bash
bash scripts/validate-policy.sh
bash scripts/health-check.sh
bash scripts/security-scan.sh --report
bash scripts/verify-invariants.sh --report
```

For an application repository, run the same gates from the repository root after integrating the `scripts/` and governance files.

## Repository map

- `AGENTS.md` — agent operating rules.
- `INVARIANTS.md` — non-negotiable system properties.
- `RAECS_POLICY.yaml` — machine-readable policy.
- `ARCHITECTURE.md` — system model.
- `PROJECT_STATE.md` — continuity and current posture.
- `TASK_LEDGER.md` — bounded work tracking.
- `DECISIONS/` — ADR/AAR records and templates.
- `OPLOG/` — operational audit trail.
- `EVALS/` — release evidence.
- `scripts/` — repeatable enforcement gates.
- `scripts/security-scan.sh` — scans for hidden files, unapproved executables, hooks, persistence artifacts, and high-risk commands.

## Safety model

Governance changes, permission expansion, destructive actions, security-boundary changes, and production releases require human approval. A failed mandatory gate blocks checkpoint/release.

## License
Add the project's chosen open-source license before public distribution.
