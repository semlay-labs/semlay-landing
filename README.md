# semlay-landing

Marketing site for [Semlay](https://semlay.com) — Phase 0 GTM landing page.

## Stack

- [Astro](https://astro.build/) + Tailwind CSS v4
- Static export (no backend)
- Design tokens: `design-system/semlay/MASTER.md`

## Local dev

**Requires Node.js ≥ 22.12** (Astro 6). Your system may default to 18; use nvm or the project helper:

```bash
cd ~/Documents/semantic-layer-plans/semlay-landing
npm install

# Option A: nvm (install once: nvm install 22)
nvm use    # reads .nvmrc

# Option B: helper script (downloads Node 22 to ~/.local if needed)
./scripts/dev.sh
```

Open http://localhost:4321

## Build

```bash
npm run build
npm run preview
```

## Content decisions

Glossary and positioning: `../semlay-plans/CONTEXT.md` and `../semlay-plans/strategy.md`.

## Deploy (Cloudflare Pages)

**Static site only** — no `@astrojs/cloudflare` adapter, no Workers, no KV.

**Build:** `npm run build` → `dist/`  
**Node:** ≥ 22.12 (`.nvmrc` / `.node-version`)

### Cloudflare Pages settings

| Setting | Value |
|---------|-------|
| Production branch | `main` |
| Build command | `npm run build` |
| Build output directory | `dist` |
| Deploy command | **leave empty** |

Do **not** use branch `cloudflare/workers-autoconfig` or deploy command `npx wrangler versions upload`. Cloudflare auto-detected Astro as Workers and added KV session bindings; this site is pure HTML/CSS/JS and does not need them.

If deploy fails with `namespace ... already exists [code: 10014]`, you are on Workers mode. Switch to the settings above and redeploy from `main`.

Also remove any redirect rule sending `semlay.com` → a parking page (e.g. `*.l.ink`).

### GitHub Actions (optional)

Add repo secrets `CLOUDFLARE_API_TOKEN` (Pages Edit) and `CLOUDFLARE_ACCOUNT_ID`, then run `.github/workflows/deploy.yml` manually.
