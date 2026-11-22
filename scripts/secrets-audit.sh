#!/usr/bin/env bash
# RAECS deep secret audit. At least one independent scanner is mandatory.
set -euo pipefail
ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"
scanners=0
findings=0

if command -v gitleaks >/dev/null 2>&1; then
  scanners=$((scanners+1))
  if gitleaks detect --no-banner --redact --source .; then
    echo '  ✓ gitleaks passed'
  else
    echo '  ✗ gitleaks detected a secret or could not complete'; findings=$((findings+1))
  fi
fi

if command -v trufflehog >/dev/null 2>&1; then
  scanners=$((scanners+1))
  if trufflehog filesystem --directory . --no-update --fail; then
    echo '  ✓ trufflehog passed'
  else
    echo '  ✗ trufflehog detected a secret or could not complete'; findings=$((findings+1))
  fi
fi

if ((scanners == 0)); then
  echo '  ✗ no deep secret scanner is installed; refusing to report PASS' >&2
  exit 1
fi
if ((findings)); then exit 1; fi
printf '  ✓ deep secret audit passed (%s scanner(s) executed)\n' "$scanners"
