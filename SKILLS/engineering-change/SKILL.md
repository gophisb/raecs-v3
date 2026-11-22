# Governed Engineering Change Skill

Use this skill for every non-trivial change to an application or engineering repository governed by RAECS.

## Authority and stop conditions
- The human owns scope, priorities, and release authority; the agent is an executor.
- Read the repository's policy, invariants, architecture, project state, requirements, and task record before planning.
- Do not modify governance boundaries, permissions, security controls, or protected files without required human approval and a decision record.
- Stop when the baseline is unclear, dependencies cannot be traced, a mandatory check fails, or evidence conflicts with repository state.
- This skill supplements RAECS; it does not replace policy, invariants, existing gates, or the constitution skill.

## Required change lifecycle

### 1. Reconnaissance — before proposing edits
Record:
- repository, branch, exact baseline commit, and worktree state;
- task purpose, explicit in-scope and out-of-scope paths, and acceptance criteria;
- relevant architecture, entry points, callers/consumers, data flows, external interfaces, and dependency manifests;
- existing tests, CI workflows, invariants, requirements, and recent relevant decisions;
- unknowns and assumptions that could alter the plan.

Do not treat filenames or documentation headings as proof that behavior exists. Inspect implementation and current callers. If the task is ambiguous, ask one focused question or stop.

### 2. Change-impact analysis — before editing
Create an impact map with one row per proposed path or behavior:

| Proposed change | Direct consumers/callers | Contracts/data | Invariants/requirements | Regression checks | Risk |
|---|---|---|---|---|---|

Include indirect effects: shared utilities, routing, persistence, permissions, background work, offline behavior, build/release packaging, and compatibility where relevant.

Classify risk as low, medium, high, or critical. Explain the basis; do not assign risk from file names alone. If an affected consumer or invariant cannot be identified, mark it unknown and do not proceed on an assumption.

### 3. Minimal execution
- Change only approved paths and behavior.
- Preserve existing working behavior and public contracts unless the task explicitly authorizes a change.
- Avoid new dependencies and parallel mechanisms unless a documented gap requires them.
- Keep changes reversible and separate unrelated fixes.
- Reassess scope if implementation reveals a new impact; obtain approval before expanding it.

### 4. Regression assurance — after editing
Select checks from the impact map, not from habit:
- unit/component tests for changed logic;
- integration tests for affected boundaries and consumers;
- end-to-end tests for critical user journeys;
- build/type/static/security checks when their domains are touched;
- existing invariant and governance gates.

Run narrow checks first, then the affected integration suite, then mandatory repository gates. A missing test is a coverage gap, not a PASS. Record skipped checks and why they were not applicable. Never weaken a test or invariant to obtain a pass.

The read-only scripts/change-impact.sh <base-ref> command provides a changed-path inventory and heuristic flags. It is a post-edit aid, not a substitute for the pre-edit impact map and not proof that recommended tests are sufficient.

### 5. Evidence and decision
For each acceptance criterion, record:
- exact command or inspection procedure;
- actual result and exit status;
- relevant output/artifact location and hash when appropriate;
- exact commit SHA tested;
- skipped/failed checks and residual risks.

A verification result applies only to the exact repository state tested. If the commit changes after verification, rerun required checks. Distinguish NOT RUN, BLOCKED, FAIL, PASS, and NOT APPLICABLE; never collapse them into a single success label.

### 6. Review and checkpoint
Compare the final diff with approved scope. Confirm no unrelated files, secret material, unapproved dependencies, or invariant weakening were introduced. Update task/evidence records only with observed facts. Commit/checkpoint/release remains subject to existing RAECS approval and gates.
