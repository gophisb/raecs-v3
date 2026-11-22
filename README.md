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
bash scripts/permissions-check.sh
bash scripts/dependency-audit.sh
bash scripts/static-analysis.sh
bash scripts/git-integrity.sh
bash scripts/verify-invariants.sh --report
bash scripts/release-gate.sh
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
- `scripts/change-impact.sh <base-ref>` — read-only changed-path inventory and heuristic verification hints; not a substitute for the required pre-edit impact map.
- `SKILLS/engineering-change/SKILL.md` — mandatory reconnaissance, impact analysis, regression selection, evidence, and review lifecycle.
- `scripts/verify-objective-evidence.sh` — validates the recorded objective evidence and its commit/hash linkage.
- `scripts/sandbox-exec.sh` — fail-closed Linux namespace wrapper with network disabled by default.
- `scripts/artifact-sign.sh` — creates SHA-256 manifests and optionally GPG-signs artifacts.
- `RAECS_ROLES.yaml` and `scripts/permissions-check.sh` — centralized roles and separation-of-duties rules.
- `scripts/status-report.sh` — prints a local operational status report.
- `scripts/evidence-export.sh` — creates a portable, hashed evidence bundle without application secrets by default.

The controls are deliberately honest about their boundary. The current mainline policy and documentation still refer to consensus and evidence-chain controls that are not present as executable scripts, and the release gate does not yet enforce every item listed under policy. Treat release readiness as BLOCKED until that policy-to-implementation gap is reconciled and the full gate is executed on the target commit. The change-impact inventory is heuristic; it cannot discover every runtime dependency or prove test sufficiency. Production use additionally requires protected branches, external key management, network controls, incident response, redundancy, and any applicable formal assurance.

## Safety model

Governance changes, permission expansion, destructive actions, security-boundary changes, and production releases require human approval. A failed mandatory gate blocks checkpoint/release.

## License
Add the project's chosen open-source license before public distribution.
