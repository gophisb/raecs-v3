# ADR: Release-gate and policy alignment

- Date: 2026-11-22
- Status: Accepted — explicit human approval recorded
- Scope: RAECS release-gate implementation and the corresponding machine policy
- Approval record: EVALS/GOVERNANCE-APPROVAL.md

## Context

The machine policy listed triple consensus and an evidence chain as mandatory release checks, but no authoritative executable implementation for either control exists. Earlier repository history removed non-authoritative consensus/evidence-chain gates. The release gate also omitted existing security-scan, static-analysis, and Git-integrity scripts even though the policy requires those checks.

A control must not be represented as enforced merely because its name appears in policy or an allowlist.

## Decision

1. Remove the unsupported "triple consensus" release requirement. RAECS will not simulate independent agreement with a local script or claim consensus without independently authenticated reviewers/agents and a defined protocol.
2. Replace the ambiguous "evidence chain" entry with "objective evidence verification", implemented by the existing evidence generation and verification scripts. This is a bounded evidence check, not a claim of a complete tamper-proof chain.
3. Invoke the existing security scan, static analysis, and Git integrity checks from the release gate.
4. Make static analysis fail when a relevant source domain exists but its required analyzer is unavailable; an unavailable analyzer must not silently produce a successful gate.
5. Bump the policy version to 3.1.0 and keep its validator, release marker, and repository documentation aligned.
6. Require at least one deep secret-scanning engine in the release environment; absence of all configured engines is a blocking condition.

## Consequences and limitations

- No three-party consensus is claimed or enforced by this repository.
- Objective evidence currently covers REQ-003 and REQ-004 only. It does not prove all eight requirements.
- Static analysis remains bounded by the languages and tools actually detected and run.
- External branch protection, independent human review, credential management, and production controls remain outside this local release script and must be configured separately.
- The release gate can pass only for the checks it actually invokes; this ADR does not certify RAECS or establish formal assurance.

## Verification

The updated release gate and CI workflow must be run on the resulting commit. Any missing analyzer, missing deep secret scanner, failed scan, or inconsistent policy marker blocks acceptance.
