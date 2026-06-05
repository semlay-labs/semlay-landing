# semlay-landing

Marketing site glossary. Full funnel terms: `../semlay-plans/CONTEXT.md`.

## Deploy

**Cloudflare Workers Builds** (connected to `semlay-labs/semlay-landing`) is the **only** production deploy path. Push to `main` → build + deploy to `semlay.com`. No GitHub Actions deploy, no manual `wrangler` from laptops unless debugging.

| Setting | Value |
|---------|-------|
| Production branch | `main` |
| Build command | `npm run build` |
| Deploy command | `npm run deploy` |
| Output | `dist/` via `wrangler.jsonc` |

Details and troubleshooting: `README.md` § Deploy.

## Language

**Landing Page**:
Public site at `semlay.com`. Primary conversion: full-page **Tally intake form** (`intakeFormUrl` in `site.ts`) — one click from hero/nav. `/check` is schema-export prep only (SQL help), not the form.
_Avoid_: $750 audit CTA, Calendly as primary hero action, developer OSS positioning, embedded Tally iframe on `/check`

**Landing Page Primary CTA**:
Button label **Get your free readiness report** — links to Tally full page. Secondary line: schema upload, results in minutes, no sales call. **Schema export help** links to `/check`.
_Avoid_: Book readiness audit, half-day engagement copy
