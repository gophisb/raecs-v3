# RAECS v3.1 Requirements Baseline

## Purpose

This document introduces a minimal requirements layer to RAECS, inspired by established systems-engineering practice.

It does not replace the existing policy, invariants, or gates. It makes their intended behavior explicit and traceable.

## Requirement IDs

| ID | Requirement | Verification | Evidence | Gate |
|---|---|---|---|---|
| REQ-001 | RAECS governance boundaries shall be defined before governed execution. | Inspection | `RAECS_POLICY.yaml`, `RAECS_INTENT.yaml` | BLOCK |
| REQ-002 | Every governed task shall have an explicit scope and acceptance criteria before mutation. | Inspection | Task/intent record | BLOCK |
| REQ-003 | Mandatory invariants shall be checked before checkpoint/release acceptance. | Test | Gate output | BLOCK |
| REQ-004 | A PASS shall not be claimed for a verification activity that was not actually performed. | Inspection + test | Gate output/log | BLOCK |
| REQ-005 | Release acceptance shall require objective evidence produced by the verification activity, not a manually asserted status alone. | Test | Verification output | BLOCK |
| REQ-006 | A release baseline shall identify the exact repository state being accepted. | Inspection | Git commit/reference | BLOCK |
| REQ-007 | A change that fails a mandatory requirement shall stop the affected gate and remain unreleased until corrected or explicitly governed by an approved policy change. | Test | Failed gate output + decision record when material | BLOCK |
| REQ-008 | Requirement changes shall remain traceable to the governing policy/invariants and to their verification method. | Inspection | This file + referenced artifacts | BLOCK |

## Verification vocabulary

- **Verification**: evidence that the implemented system satisfies the stated requirement.
- **Validation**: evidence that the requirement itself serves the intended RAECS mission/purpose.
- **Objective evidence**: an artifact produced by an actual verification activity and tied to the evaluated repository state.
- **Baseline**: an explicitly identified repository state accepted as the reference for a governed decision.

## Traceability rule

A requirement is not considered complete merely because its text exists.

For a requirement to be **implemented**, RAECS must be able to identify:

1. the requirement;
2. the governing rule/invariant, where applicable;
3. the verification method;
4. the evidence produced;
5. the repository state to which that evidence applies;
6. the gate that consumes the result.

## Initial scope

This first requirements layer is intentionally small.

It does not attempt to reproduce NASA processes, standards, organizational independence, safety assurance, or mission certification. It adapts only the engineering principles that are directly useful to RAECS governance.
