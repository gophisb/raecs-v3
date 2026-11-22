#!/usr/bin/env bash
# Smoke tests for the read-only change-impact inventory.
set -euo pipefail
ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT
git -C "$tmp" init -q
git -C "$tmp" config user.email test@example.invalid
git -C "$tmp" config user.name "RAECS Test"
printf 'base\n' > "$tmp/app.js"
git -C "$tmp" add app.js
git -C "$tmp" commit -qm baseline
base="$(git -C "$tmp" rev-parse HEAD)"
printf 'changed\n' > "$tmp/app.js"
printf 'test\n' > "$tmp/app.test.js"
out="$(cd "$tmp" && bash "$ROOT/scripts/change-impact.sh" "$base")"
grep -q 'app.js' <<<"$out"
grep -q 'app.test.js' <<<"$out"
grep -q 'test_or_spec_files_changed: yes' <<<"$out"
grep -q 'INVENTORY ONLY' <<<"$out"
if (cd "$tmp" && bash "$ROOT/scripts/change-impact.sh" missing-ref >/dev/null 2>&1); then
  echo "FAIL: invalid base ref was accepted" >&2; exit 1
fi
echo "change-impact smoke tests: PASS"
