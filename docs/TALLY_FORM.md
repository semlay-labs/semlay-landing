# Tally intake form — operator checklist

Form ID: `vGKp60` · Embed: `https://tally.so/embed/vGKp60` · Public: `https://tally.so/r/vGKp60`

## File upload block (fix multi-file + zip)

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
- Click to browse; drag-drop unreliable in embeds

## Embed settings (Share → Standard embed)

| Setting | Value |
|---------|-------|
| Dynamic height | **Off** on our site — we use fixed 4200px iframe to avoid submit clipping after upload |
| Hide title | On |
| Transparent background | On |
| Align left | On |

Site uses `/embed/vGKp60`, not `/r/vGKp60`, in `TallyEmbed.astro`.

## Known embed limitations

- **Drag-and-drop** from desktop into iframe: often blocked by browser; full-page form works.
- **Submit below fold** after file preview: fixed height + scroll hint on `/check`; "Open in new tab" fallback.

## Test fixtures

Zip uploads for manual testing:

```bash
cd ~/Documents/semantic-layer-plans/semlay-plans/fixtures/readiness-check
zip -j ready-schema.zip semlay_schema_columns.csv semlay_schema_keys.csv
zip -j needs-prep-schema.zip needs-prep/semlay_schema_columns.csv needs-prep/semlay_schema_keys.csv
```
