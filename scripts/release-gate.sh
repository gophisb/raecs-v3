#!/usr/bin/env bash
# RAECS v3.1 release gate — invoke every locally enforceable mandatory control.
set -euo pipefail
ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"
echo "RAECS v3.1 RELEASE GATE"
echo "1/17 requirements traceability"
bash scripts/requirements-check.sh
echo "2/17 policy validation"
bash scripts/validate-policy.sh
echo "3/17 health"
bash scripts/health-check.sh
echo "4/17 intent validation"
bash scripts/intent-check.sh
echo "5/17 permissions validation"
bash scripts/permissions-check.sh
echo "6/17 sandbox preflight"
bash scripts/sandbox-preflight.sh
echo "7/17 artifact integrity"
bash scripts/artifact-integrity.sh
echo "8/17 repository security scan"
bash scripts/security-scan.sh
echo "9/17 deep secret audit"
bash scripts/secrets-audit.sh
echo "10/17 dependency audit"
bash scripts/dependency-audit.sh
echo "11/17 static analysis"
bash scripts/static-analysis.sh
echo "12/17 Git integrity"
bash scripts/git-integrity.sh
echo "13/17 invariants"
bash scripts/verify-invariants.sh --report
echo "14/17 objective evidence generation"
bash scripts/objective-evidence.sh
echo "15/17 objective evidence verification"
bash scripts/verify-objective-evidence.sh
echo "16/17 status report"
bash scripts/status-report.sh
echo "17/17 governance consistency"
python3 - <<'PY'
from pathlib import Path
required = ["AGENTS.md","INVARIANTS.md","RAECS_POLICY.yaml","RAECS_INTENT.yaml","RAECS_ROLES.yaml","RAECS_EXECUTABLES_ALLOWLIST.txt","PROJECT_STATE.md","TASK_LEDGER.md","ARCHITECTURE.md","RUNBOOK.md","CHANGELOG.md"]
missing = [p for p in required if not Path(p).is_file()]
if missing:
    raise SystemExit(f"Missing release files: {missing}")
policy = Path("RAECS_POLICY.yaml").read_text()
for marker in ('version: "3.1.0"', "status: final", "stop_the_line: true"):
    if marker not in policy:
        raise SystemExit(f"Policy marker missing: {marker}")
print("  ✓ final governance markers present")
PY
echo "RAECS v3.1 RELEASE GATE: PASS"
