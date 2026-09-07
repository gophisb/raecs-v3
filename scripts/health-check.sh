#!/usr/bin/env bash
# RAECS health gate
set -euo pipefail
ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"
QUIET=0
for arg in "$@"; do case "$arg" in --quiet) QUIET=1;; *) echo "Unknown option: $arg" >&2; exit 2;; esac; done
fail=0
say(){ ((QUIET)) || echo "$*"; }
check_file(){ if [[ -f "$1" ]]; then say "  ✓ $1"; else echo "  ✗ missing: $1"; fail=1; fi; }
say "RAECS health check"
for f in AGENTS.md INVARIANTS.md RAECS_POLICY.yaml PROJECT_STATE.md TASK_LEDGER.md ARCHITECTURE.md RUNBOOK.md CHANGELOG.md; do check_file "$f"; done
for f in scripts/verify-invariants.sh scripts/validate-policy.sh scripts/checkpoint.sh scripts/aar.sh; do
  if [[ -x "$f" ]]; then say "  ✓ executable: $f"; else echo "  ✗ not executable: $f"; fail=1; fi
done
for d in OPLOG EVALS DECISIONS SKILLS; do [[ -d "$d" ]] && say "  ✓ directory: $d" || { echo "  ✗ missing directory: $d"; fail=1; }; done
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then say "  ✓ git repository"; else echo "  ✗ not a git repository"; fail=1; fi
if (( fail )); then echo "RAECS health: FAIL"; exit 1; fi
say "RAECS health: PASS"
