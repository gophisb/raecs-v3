# ADR-001 — RAFEEQ ENGINEERING CONSTITUTION V3

## Status
Accepted for implementation by the human project owner on an isolated branch.

## Context
The RAECS v3 baseline already contains machine policy and invariants, but the intended V3 operating model also requires a durable constitutional layer, explicit task contracts, persistent state, evidence-backed status semantics, bounded retries, recovery, and executable enforcement.

## Decision
Implement V3 as a layered governance system:

1. `RAFEEQ_CONSTITUTION.md` — human-readable normative rules.
2. `RAECS_POLICY.yaml` — machine-readable limits and approval boundaries.
3. `PROJECT_STATE.md` — persistent current state.
4. `TASK_LEDGER.md` — bounded task contracts.
5. `INVARIANTS.md` — stop-the-line properties.
6. `scripts/validate-constitution.sh` — deterministic baseline validator.
7. `DECISIONS/` and `OPLOG/` — audit trail.

The implementation is isolated on `feat/constitution-v3` and is not treated as released until validation and independent review pass.

## Consequences
Positive:
- Agents can resume from durable state instead of conversation memory.
- Governance rules become referenceable and partially machine-checkable.
- Completion claims can be tied to evidence.
- Governance changes have an explicit approval trail.

Trade-offs:
- Governance adds process and files.
- Some project-specific checks require additional validators.
- V3 is not considered PROVEN merely because this branch exists.

## Release evidence required
- Constitution validator PASS.
- Policy/invariant validation PASS.
- Diff and scope review PASS.
- Independent governance review PASS.
- Updated state/checkpoint evidence.

## Rollback
Revert the V3 implementation commits or abandon the isolated branch.
