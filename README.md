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

## Deploy

**Cloudflare Workers Builds** is connected to this repo and is the **standalone** way to ship `semlay.com`. Push to `main` → Workers Builds runs `npm run build` then `npm run deploy` → production updates. No separate CI workflow or local wrangler step in the normal path.

```bash
git push origin main   # that's it
```

Monitor: Cloudflare dashboard → **Workers & Pages** → `semlay-landing`.

**Static site only** — no `@astrojs/cloudflare` adapter, no Workers app logic, no KV.

**Build:** `npm run build` → `dist/`  
**Node:** ≥ 22.12 (`.nvmrc` / `.node-version`)

### Workers Builds settings (dashboard)

| Setting | Value |
|---------|-------|
| Production branch | `main` |
| Build command | `npm run build` |
| Deploy command | `npm run deploy` |
| Non-production branch deploy command | `npm run deploy` |
| Root directory | `/` |

`wrangler.jsonc` at repo root points at `./dist` (static assets only).

Do **not** use branch `cloudflare/workers-autoconfig` — it adds `@astrojs/cloudflare` and a SESSION KV binding that breaks deploy.

If deploy fails with `namespace ... already exists [code: 10014]`, confirm production branch is `main` and change **Non-production branch deploy command** away from `npx wrangler versions upload`.

Also remove any redirect rule sending `semlay.com` → a parking page (e.g. `*.l.ink`).

### Not used for deploy

- `.github/workflows/deploy.yml` — legacy manual workflow; Workers Builds replaced it. Do not add `CLOUDFLARE_API_TOKEN` to GitHub for landing deploys.
- Local `npm run deploy` — only for debugging when Workers Builds logs are insufficient.
