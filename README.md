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

**Build:** `npm run build` → `dist/`  
**Node:** ≥ 22.12 (`.nvmrc` / `.node-version`)

### Option A: Git integration (recommended)

1. Cloudflare dashboard → **Workers & Pages** → **Create** → **Connect to Git**
2. Repo: `semlay-labs/semlay-landing`, branch `main`
3. Build command: `npm run build` · Output directory: `dist` · Node: 22
4. Custom domain: `semlay.com` (+ `www` CNAME to Pages)

### Option B: GitHub Actions

Add repo secrets `CLOUDFLARE_API_TOKEN` (Pages Edit) and `CLOUDFLARE_ACCOUNT_ID`. Push to `main` runs `.github/workflows/deploy.yml`.

### Manual

```bash
npm run build
npx wrangler pages deploy dist --project-name=semlay-landing
```
