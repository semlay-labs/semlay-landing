# semlay-landing

Marketing site for [Semlay](https://semlay.ai) — Phase 0 GTM landing page.

## Stack

- [Astro](https://astro.build/) + Tailwind CSS v4
- Static export (no backend)
- Design tokens: `design-system/semlay/MASTER.md`

## Local dev

```bash
cd ~/Documents/semantic-layer-plans/semlay-landing
npm install
npm run dev
```

Open http://localhost:4321

## Build

```bash
npm run build
npm run preview
```

## Content decisions

Glossary and positioning: `../semlay-plans/CONTEXT.md` and `../semlay-plans/strategy.md`.

## Remote (when ready)

```bash
gh repo create semlay-labs/semlay-landing --public --source=. --remote=origin
git push -u origin main
```

Rename default branch if needed: `git branch -M main`.
