#!/usr/bin/env bash
set -euo pipefail
ROOT_DIR="$(git rev-parse --show-toplevel)"
cd "$ROOT_DIR"
ANCHOR="TRUST_ANCHOR.md"
[[ -f "$ANCHOR" ]] || { echo "✗ trust anchor missing"; exit 1; }
fail=0
while read -r expected path; do
  [[ -z "${expected:-}" ]] && continue
  [[ "$expected" == #* ]] && continue
  actual="$(git rev-parse "HEAD:$path" 2>/dev/null || true)"
  if [[ -z "$actual" || "$actual" != "$expected" ]]; then
    echo "✗ trust anchor mismatch: $path"
    fail=1
  else
    echo "✓ anchored: $path"
  fi
done < <(sed -n '/^## Anchors$/,$p' "$ANCHOR" | tail -n +2)
if ((fail)); then
  echo "RAECS TRUST ANCHOR: FAIL"
  exit 1
fi
echo "RAECS TRUST ANCHOR: PASS"
