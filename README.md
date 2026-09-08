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
bash scripts/intent-check.sh
bash scripts/dependency-audit.sh
bash scripts/consensus-gate.sh
bash scripts/evidence-chain.sh verify
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
- `RAECS_INTENT.yaml` — records approved purpose, paths, forbidden actions, and human-approval boundaries.
- `RAECS_EXECUTABLES_ALLOWLIST.txt` — explicit allowlist for executable files.
- `scripts/dependency-audit.sh` — audits supported application dependencies when manifests exist.
- `scripts/static-analysis.sh` — runs ShellCheck, Bandit, or Semgrep when applicable and available.
- `scripts/git-integrity.sh` — checks hooks, protected governance changes, and diff integrity.
- `scripts/consensus-gate.sh` — requires independent security, Git, and static-analysis controls to agree.
- `scripts/evidence-chain.sh` — maintains a tamper-evident local hash chain for evidence records.

The advanced controls are deliberately honest about their boundary. Intent manifests validate declared scope but cannot read an agent's mind; local evidence chains detect later tampering but are not a distributed notarization service; consensus combines independent local gates but is not three independent security experts; and static analysis cannot prove the absence of every zero-day. Production or military use additionally requires isolated execution, signed artifacts, protected branches, external key management, network controls, incident response, redundancy, and formal certification.

## Safety model

Governance changes, permission expansion, destructive actions, security-boundary changes, and production releases require human approval. A failed mandatory gate blocks checkpoint/release.

## License
Add the project's chosen open-source license before public distribution.
