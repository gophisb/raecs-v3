#!/usr/bin/env bash
# RAECS v3.0 release gate — all final-baseline checks
set -euo pipefail
ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"
echo "RAECS v3.0 RELEASE GATE"
echo "1/9 policy validation"
bash scripts/validate-policy.sh
echo "2/9 health"
bash scripts/health-check.sh
echo "3/9 intent validation"
bash scripts/intent-check.sh
echo "4/9 deep secret audit"
bash scripts/secrets-audit.sh
echo "5/9 dependency audit"
bash scripts/dependency-audit.sh
echo "6/9 triple consensus"
bash scripts/consensus-gate.sh
echo "7/9 invariants"
bash scripts/verify-invariants.sh --report
echo "8/9 evidence chain"
bash scripts/evidence-chain.sh verify
echo "9/9 governance consistency"
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
