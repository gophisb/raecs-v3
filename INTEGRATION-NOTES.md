# Integration Notes

This is a release-candidate bundle, not a replacement for the authoritative RAECS repository.

The scripts were hardened without inventing the missing constitutional documents. Before upload/merge, compare these scripts against the canonical RAECS v3.0 policy and invariants, especially:

- whether policy files are mutable or protected by repository permissions;
- whether checkpoint automation is allowed to commit automatically;
- the exact meaning of DEFCON 1–5;
- required SLO fields in PROJECT_STATE.md;
- the canonical OPLOG format;
- the project's actual build/test commands.

If any canonical rule conflicts with a script, the canonical policy wins and the script must be changed before release.
