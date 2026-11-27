[![License: CC BY 4.0](https://img.shields.io/badge/License-CC_BY_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/)
[![Site](https://img.shields.io/badge/Static%20site-HUGO-%23FF00FF)](https://gohugo.io/)

# FodyDev website

This repo houses the assets used to build the website for [FodyDev](https://fodydev.org/) at https://fodydev.org.

## 📝 Adding Resources

FodyDev operates through different working groups and initiatives, each of them with their unique [contribution guidelines and communication channels](https://fodydev.org/community).

We encourage people to [join the community](https://fodydev.org/community) and get started with contributions to the different FodyDev initiatives.

## 🧩 Editing the site

This site is built using the [Hugo](https://gohugo.io) static site generator. The site uses the [Dot-Org Theme for Hugo](https://github.com/cncf/dot-org-hugo-theme) as a base and then has its own customisations.

 In order to build or locally develop the website, you only need [node.js](https://nodejs.org/en) **v22 or newer** (and git). Everything else comes from npm and is pinned in `package.json`:

- [Hugo](https://gohugo.io) **v0.170.1** (npm package `hugo-extended`; since Hugo v0.170 there is no separate "extended" edition)
- Dart Sass (`sass-embedded`), PostCSS/Autoprefixer, [Pagefind](https://pagefind.app) (search) and `serve` (static server for `npm start`)

Then follow these instructions:

1. Clone this repo to a local directory on your computer.

2. Navigate to the newly created directory, and pull in the theme:

```bash
git submodule update --init --recursive
```

3. Install dependencies:

```bash
npm install
```

4. Start the local server with live reload (drafts and future posts included):

```bash
npm run dev
```

## npm commands

The project uses the standard npm script names, so hosts with auto-deploy (Railpack, Railway, Nixpacks, …) work without extra configuration: `npm install` → `npm run build` → `npm start`.

| Command              | What it does                                                                                     |
| -------------------- | ------------------------------------------------------------------------------------------------ |
| `npm run dev`        | Local dev server with live reload on http://localhost:1313 (no search index)                     |
| `npm run dev:search` | Builds the Pagefind search index first, then starts the dev server (search works locally)       |
| `npm run build`      | Production build (minified) into `public/` + Pagefind search index                               |
| `npm run build:dev`  | Development build (drafts and future posts included) into `public/` + search index              |
| `npm start`          | Serves the built `public/` folder on `0.0.0.0:$PORT` (default `3000`)                            |

The production build uses `baseURL: https://fodydev.org` (`config/production/hugo.yaml`). To deploy on another domain, set the `HUGO_BASEURL` environment variable at build time.

> On npm ≥ 11 with install scripts restricted, the `hugo-extended` postinstall may be skipped: Hugo is then downloaded automatically on its first run.

### Deploying with Railpack

No configuration is needed: Railpack detects Node.js (version from `engines.node`), runs `npm ci`, `npm run build`, then `npm start`, which listens on the `PORT` it provides.

### To run in docker

As mentioned above, fork and clone this repository, run `git submodule update --init --recursive`, then run following:

```bash
./run-hugo-in-docker.sh
```

It runs `npm install`, `npm run build:dev` and `npm run dev` in a `node:22` container (its `node_modules` is kept separate from yours). Then open http://localhost:1313 in your browser.

If modifying the theme files, you should never edit the theme that is imported via Git Submodule, as otherwise the changes will be overwritten or lost the next time the theme is updated. Changes should be made in override files inside the root directory as this will override the theme directory. [Read docs](https://gohugo.io/getting-started/directory-structure/).

The project follows the Hugo v0.146+ template layout: partials live in `layouts/_partials/`, shortcodes in `layouts/_shortcodes/`, the home page template is `layouts/home.html` and single pages use `page.html`. A few theme templates are overridden in `layouts/` only to replace APIs deprecated in recent Hugo releases (`.Site.Languages`, `.Site.Data`, `.Site.LanguageCode`, `.Language.LanguageName`); they can be removed once the upstream theme is updated.

## Updating the theme

From the site root:

```
git submodule update --init --recursive
```
