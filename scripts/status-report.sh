#!/usr/bin/env bash
# RAECS local operational status report.
set -euo pipefail
ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"
printf '%s\n' 'RAECS OPERATIONAL STATUS' '========================'
printf 'version: '; sed -n 's/^version: //p' RAECS_POLICY.yaml | head -n1
printf 'branch: '; git branch --show-current
printf 'commit: '; git rev-parse --short HEAD
printf 'worktree: '; [[ -z "$(git status --porcelain)" ]] && echo clean || echo changes-present
printf 'intent: '; bash scripts/intent-check.sh >/dev/null && echo valid
printf 'roles: '; bash scripts/permissions-check.sh >/dev/null && echo valid
if [[ -f EVALS/OBJECTIVE_EVIDENCE.txt && -f EVALS/VERIFICATION_LOG.txt ]]; then
  printf 'objective-evidence: '
  bash scripts/verify-objective-evidence.sh >/dev/null && echo valid
else
  printf '%s\n' 'objective-evidence: not-generated'
fi
printf 'last-oplog: '; find OPLOG -maxdepth 1 -type f -name '*.log' -printf '%T@ %p\n' | sort -nr | head -n1 | cut -d' ' -f2- || echo none
