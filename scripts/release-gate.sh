#!/usr/bin/env bash
# RAECS v3.0 release gate — all final-baseline checks
set -euo pipefail
ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"
echo "RAECS v3.0 RELEASE GATE"
echo "1/13 policy validation"
bash scripts/validate-policy.sh
echo "2/13 health"
bash scripts/health-check.sh
echo "3/13 intent validation"
bash scripts/intent-check.sh
echo "4/13 permissions validation"
bash scripts/permissions-check.sh
echo "5/13 sandbox preflight"
bash scripts/sandbox-preflight.sh
echo "6/13 artifact integrity"
bash scripts/artifact-integrity.sh
echo "7/13 deep secret audit"
bash scripts/secrets-audit.sh
echo "8/13 dependency audit"
bash scripts/dependency-audit.sh
echo "9/13 triple consensus"
bash scripts/consensus-gate.sh
echo "10/13 invariants"
bash scripts/verify-invariants.sh --report
echo "11/13 evidence chain"
bash scripts/evidence-chain.sh verify
echo "12/13 status report"
bash scripts/status-report.sh
echo "13/13 governance consistency"
python3 - <<'PY'
from pathlib import Path
required = ["AGENTS.md","INVARIANTS.md","RAECS_POLICY.yaml","RAECS_INTENT.yaml","RAECS_ROLES.yaml","RAECS_EXECUTABLES_ALLOWLIST.txt","PROJECT_STATE.md","TASK_LEDGER.md","ARCHITECTURE.md","RUNBOOK.md","CHANGELOG.md"]
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
