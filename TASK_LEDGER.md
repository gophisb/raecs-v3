# Task Ledger

RAECS uses explicit task IDs to keep agent work bounded and auditable.

| Task ID | Description | Status | Owner | Evidence |
|---|---|---|---|---|
| RAECS-300 | Establish v3.0 governance baseline | DONE | human/agent | repository baseline |
| RAECS-301 | Harden verification scripts | DONE | agent | `scripts/` |
| RAECS-302 | Run release verification | TESTED | release operator | `EVALS/`; GitHub Actions Run #80 |
| GOV-V3-001 | Establish executable Constitution V3 | PROVEN | human/agent | Run #80 15/15 PASS; independent review; checkpoint `b49bee1ad9fd69a2b4ee7f1728400f0522b62fd9` |

## GOV-V3-001 Contract

- **Objective:** Turn the approved V3 governance design into durable, machine-checkable project governance.
- **Allowed files:** Constitution, machine policy, intent, invariants, project state, task ledger, decisions, and Constitution validator.
- **Forbidden:** unrelated application/project changes.
- **Acceptance:**
  1. Constitution V3 exists with normative operating rules.
  2. Machine policy expresses bounded autonomy, evidence, scope, retry, and self-protection.
  3. Persistent state and task contract exist.
  4. Validator checks the constitutional baseline.
  5. Governance decision is recorded.
- **Verification:** `bash scripts/validate-constitution.sh`; `git diff --check`.
- **Risk:** HIGH.
- **Rollback:** revert the V3 governance commit or abandon the isolated branch.
- **Status semantics:** PLANNED → IMPLEMENTED → TESTED → PROVEN only with evidence. BLOCKED stops progression.

## Rules
- Every material task gets a unique ID.
- Do not silently change task scope.
- A failed task is not marked DONE.
- Closed tasks must point to evidence.
