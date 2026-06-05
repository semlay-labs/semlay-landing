# Tally intake form — operator checklist

Form ID: `vGKp60` · Public URL: `https://tally.so/r/vGKp60` (`intakeFormUrl` in `site.ts`)

**Not embedded** on `semlay.com` — hero, nav, and bottom CTAs link directly to the full-page form (better file upload UX). `/check` is SQL prep only.

## File upload block

In Tally form editor, open the **Schema Export** file upload block (`::` settings):

| Setting | Value |
|---------|-------|
| Allow multiple files | **On** (max 2) — or keep single file and tell prospects to upload a **.zip** |
| Allowed types | `.csv`, `.zip` (add `.sql` if you accept dumps) |
| Max file size | 10 MB (default is fine) |
| Required | Yes |

Update the block description to match `SchemaUploadHelp.astro` on `/check`:

- Export via pgAdmin/DBeaver (not `/tmp`)
- Zip both CSVs if only one upload slot

## Test fixtures

```bash
cd ~/Documents/semantic-layer-plans/semlay-plans/fixtures/readiness-check
zip -j ready-schema.zip semlay_schema_columns.csv semlay_schema_keys.csv
```
