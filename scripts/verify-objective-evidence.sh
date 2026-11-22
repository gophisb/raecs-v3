#!/usr/bin/env bash
set -euo pipefail
ROOT_DIR="$(git rev-parse --show-toplevel)"
cd "$ROOT_DIR"
EVIDENCE="EVALS/OBJECTIVE_EVIDENCE.txt"
RUNLOG="EVALS/VERIFICATION_LOG.txt"
[[ -f "$EVIDENCE" ]] || { echo "✗ objective evidence missing"; exit 1; }
[[ -f "$RUNLOG" ]] || { echo "✗ verification log missing"; exit 1; }
grep -q '^RAECS OBJECTIVE EVIDENCE$' "$EVIDENCE"
awk -F= '$1 == "baseline_commit" && length($2) == 40 && $2 ~ /^[0-9a-f]+$/ { ok=1 } END { exit !ok }' "$EVIDENCE"
awk -F= '$1 == "verification_log_sha256" && length($2) == 64 && $2 ~ /^[0-9a-f]+$/ { ok=1 } END { exit !ok }' "$EVIDENCE"
grep -q '^checks=REQ-003,REQ-004$' "$EVIDENCE"
grep -q '^result=PASS$' "$EVIDENCE"
grep -q '^RESULT REQ-003 PASS$' "$RUNLOG"
grep -q '^RESULT REQ-004 PASS$' "$RUNLOG"
EXPECTED_SHA="$(sed -n 's/^verification_log_sha256=//p' "$EVIDENCE")"
ACTUAL_SHA="$(sha256sum "$RUNLOG" | awk '{print $1}')"
[[ "$EXPECTED_SHA" == "$ACTUAL_SHA" ]] || { echo "✗ verification log hash does not match evidence"; exit 1; }
BASELINE="$(sed -n 's/^baseline_commit=//p' "$EVIDENCE")"
[[ "$BASELINE" == "$(git rev-parse HEAD)" ]] || { echo "✗ evidence baseline does not match current commit"; exit 1; }
echo "RAECS OBJECTIVE EVIDENCE VERIFICATION: PASS"
