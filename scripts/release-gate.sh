#!/usr/bin/env bash
# RAECS v3.0 release gate — all final-baseline checks
set -euo pipefail
ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"
echo "RAECS v3.0 RELEASE GATE"
echo "1/4 policy validation"
bash scripts/validate-policy.sh
echo "2/4 health"
bash scripts/health-check.sh
echo "3/5 security scan"
bash scripts/security-scan.sh --report
echo "4/5 invariants"
bash scripts/verify-invariants.sh --report
echo "5/5 governance consistency"
python3 - <<'PY'
from pathlib import Path
required = ["AGENTS.md","INVARIANTS.md","RAECS_POLICY.yaml","PROJECT_STATE.md","TASK_LEDGER.md","ARCHITECTURE.md","RUNBOOK.md","CHANGELOG.md"]
missing = [p for p in required if not Path(p).is_file()]
if missing:
    raise SystemExit(f"Missing release files: {missing}")
policy = Path("RAECS_POLICY.yaml").read_text()
for marker in ("version: \"3.0.0\"", "status: final", "stop_the_line: true"):
    if marker not in policy:
        raise SystemExit(f"Policy marker missing: {marker}")
print("  ✓ final governance markers present")
PY
echo "RAECS v3.0 RELEASE GATE: PASS"
