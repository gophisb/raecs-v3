#!/usr/bin/env bash
# Read-only change-impact inventory. It reports likely verification areas;
# it does not claim that any test is sufficient or has passed.
set -euo pipefail
usage() {
  cat <<'USAGE'
Usage: bash scripts/change-impact.sh <base-ref>
Compare the current worktree (including staged and untracked files) with BASE.
No files are modified. BASE must resolve to a commit.
USAGE
}
if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then usage; exit 0; fi
if [[ $# -ne 1 ]]; then usage >&2; exit 2; fi
BASE="$1"
ROOT_DIR="$(git rev-parse --show-toplevel 2>/dev/null)" || { echo "ERROR: not inside a Git worktree" >&2; exit 2; }
cd "$ROOT_DIR"
git rev-parse --verify "${BASE}^{commit}" >/dev/null 2>&1 || { echo "ERROR: base ref does not resolve to a commit: $BASE" >&2; exit 2; }
mapfile -t CHANGED < <({
  git diff --name-only --diff-filter=ACDMRTUXB "$BASE" --
  git diff --cached --name-only --diff-filter=ACDMRTUXB "$BASE" --
  git ls-files --others --exclude-standard
} | sed '/^$/d' | sort -u)
printf 'RAECS CHANGE IMPACT INVENTORY\n'
printf 'base: %s\n' "$(git rev-parse --short "$BASE")"
printf 'head: %s\n' "$(git rev-parse --short HEAD)"
printf 'changed_paths: %s\n' "${#CHANGED[@]}"
if (("${#CHANGED[@]}" == 0)); then
  echo "No changed paths detected relative to base."
  echo "NOTE: this is an inventory only; it is not a pre-change impact prediction."
  exit 0
fi
has_app=0; has_tests=0; has_governance=0; has_security=0
for path in "${CHANGED[@]}"; do
  printf ' - %s\n' "$path"
  case "$path" in *test*|*spec*|tests/*|__tests__/*) has_tests=1 ;; esac
  case "$path" in AGENTS.md|INVARIANTS.md|RAECS_POLICY.yaml|RAECS_INTENT.yaml|RAECS_ROLES.yaml|scripts/*gate*.sh|scripts/verify-*.sh) has_governance=1 ;; esac
  case "$path" in *security*|*auth*|*permission*|*secret*|*sandbox*|*crypto*) has_security=1 ;; esac
  case "$path" in package.json|package-lock.json|pnpm-lock.yaml|yarn.lock|bun.lock*|src/*|app/*|android/*|ios/*|www/*|assets/*) has_app=1 ;; esac
done
echo
echo "IMPACT FLAGS (heuristic; human/agent review remains mandatory)"
printf ' application_or_dependency_area: %s\n' "$([[ $has_app -eq 1 ]] && echo REVIEW || echo not-detected)"
printf ' test_or_spec_files_changed: %s\n' "$([[ $has_tests -eq 1 ]] && echo yes || echo no)"
printf ' governance_or_gate_area: %s\n' "$([[ $has_governance -eq 1 ]] && echo REVIEW-APPROVAL-REQUIRED || echo not-detected)"
printf ' security_boundary_area: %s\n' "$([[ $has_security -eq 1 ]] && echo REVIEW-APPROVAL-REQUIRED || echo not-detected)"
echo
echo "RECOMMENDED VERIFICATION (select tests from the actual dependency/impact map)"
echo " - inspect each changed path and its callers, consumers, data contracts, and invariants"
echo " - run the narrowest relevant tests, then the affected integration/regression tests"
echo " - run: bash scripts/validate-policy.sh"
echo " - run: bash scripts/health-check.sh"
echo " - run: bash scripts/verify-invariants.sh --report"
if [[ $has_app -eq 1 ]]; then echo " - inspect package/build manifests; run the project build and meaningful test suite"; fi
if [[ $has_governance -eq 1 || $has_security -eq 1 ]]; then echo " - STOP: obtain explicit human approval before changing governance/security boundaries"; fi
echo " - capture actual command, exit status, commit, and artifact hashes; never infer PASS"
echo
echo "RESULT: INVENTORY ONLY — NOT A VERIFICATION PASS"
