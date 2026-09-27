#!/usr/bin/env bash
set -euo pipefail
ROOT_DIR="$(git rev-parse --show-toplevel)"
cd "$ROOT_DIR"
EVIDENCE="EVALS/OBJECTIVE_EVIDENCE.txt"
[[ -f "$EVIDENCE" ]] || { echo "✗ objective evidence missing"; exit 1; }
grep -q '^RAECS OBJECTIVE EVIDENCE$' "$EVIDENCE"
grep -q '^baseline_commit=[0-9a-f]\\{40\\}$' "$EVIDENCE"
grep -q '^verification_log_sha256=[0-9a-f]\\{64\\}$' "$EVIDENCE"
grep -q '^checks=REQ-003,REQ-004$' "$EVIDENCE"
grep -q '^result=PASS$' "$EVIDENCE"
BASELINE="$(sed -n 's/^baseline_commit=//p' "$EVIDENCE")"
[[ "$BASELINE" == "$(git rev-parse HEAD)" ]] || { echo "✗ evidence baseline does not match current commit"; exit 1; }
echo "RAECS OBJECTIVE EVIDENCE VERIFICATION: PASS"
