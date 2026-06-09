# Tally intake form — operator checklist

Form ID: `vGKp60` · Public URL: `https://tally.so/r/vGKp60` (`intakeFormUrl` in `site.ts`)

**Not embedded** on `semlay.com` — hero, nav, and bottom CTAs link directly to the full-page form (better file upload UX). `/check` is SQL prep only.

**Automation live** — submit → webhook → GHA → prospect PDF + internal email (2–5 min). Pipeline: `../../semlay-plans/readiness-pipeline.md` · Worker: `../../semlay-cli/workers/tally-bridge/`.

## Webhook (live)

| Item | Value |
|------|-------|
| Endpoint | `https://semlay-tally-bridge.alexsimonrod.workers.dev/webhooks/tally` |
| Event | `FORM_RESPONSE` (Tally default) |
| Worker secrets | `TALLY_WEBHOOK_SECRET`, `GITHUB_DISPATCH_TOKEN`, `GITHUB_REPO` |
| GHA workflow | `semlay-cli` → **Readiness Check** (`readiness-run.yml`) |

**Verify after submit:** Tally webhook log → 2xx · `gh run list --repo semlay-labs/semlay-cli --workflow=readiness-run.yml` → green run · two Resend emails.

**Manual retry** (operator):

```bash
gh workflow run readiness-run.yml \
  --repo semlay-labs/semlay-cli \
  -f submission_id=<tally-submission-id>
```

## Notifications

**Tally account email** still pings on each submit (personal inbox; `hello@` forwards there). Automated delivery does **not** need Tally Pro — prospect + `hello@` get Resend emails from the pipeline.

## Troubleshooting

| Tally log | Likely fix |
|-----------|------------|
| **401** | Re-copy signing secret → `wrangler secret put TALLY_WEBHOOK_SECRET` |
| **502** `GitHub dispatch failed: 401` | Classic PAT (`repo` scope) → `wrangler secret put GITHUB_DISPATCH_TOKEN` |
| **502** `GitHub dispatch failed: 404` | `GITHUB_REPO` must be `semlay-labs/semlay-cli` (no URL) |
| No GHA run | Workflow missing on `main`, or PAT lacks `repo` |
| GHA red | Check run logs; `TALLY_API_KEY` / `RESEND_API_KEY` in repo secrets |

Confirm PAT locally before updating Worker:

```bash
curl -sS -o /dev/null -w "%{http_code}\n" \
  -X POST https://api.github.com/repos/semlay-labs/semlay-cli/dispatches \
  -H "Authorization: Bearer ghp_YOUR_TOKEN" \
  -H "Accept: application/vnd.github+json" \
  -d '{"event_type":"readiness-run","client_payload":{"submission_id":"smoke-test"}}'
```

Expect **204**.

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
