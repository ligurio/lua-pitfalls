# Lua Pitfalls

Pitfalls and anti-patterns when programming in Lua.

This is a Jekyll site hosted on GitHub Pages. Each file in
[`_pitfalls/`](_pitfalls/) is a single Markdown page describing
one pitfall: a short description, a code demo with syntax
highlighting, and two tag categories - the Lua runtime(s) affected
and the static analyzers that can catch the problem.

## Project layout

```
_config.yml          # Site config: collections, kramdown + Rouge, defaults.
_data/runtimes.yml   # Canonical list of Lua runtimes (tag metadata).
_data/analyzers.yml  # Canonical list of static analyzers (tag metadata).
_layouts/            # Page templates (default, home, pitfall).
_includes/           # Reusable snippets (tags).
_pitfalls/           # One Markdown file per pitfall, rendered as a page.
assets/css/          # Styles (including Rouge syntax colors).
index.md             # Home page listing all pitfalls.
```

## Adding a pitfall

Create `_pitfalls/<name>.md` with this front matter:

```markdown
---
layout: pitfall
title: "Short, descriptive title"
description: >-
  One or two sentences explaining the problem.
runtime:
  - Lua 5.1
  - Lua 5.4
analyzers:
  - luacheck
  - selene
---
```

- `runtime` — one or more entries. Pick from `_data/runtimes.yml`
  (e.g. `Lua 5.1`, `Lua 5.2`, `Lua 5.3`, `Lua 5.4`, `LuaJIT`).
- `analyzers` — one or more entries from `_data/analyzers.yml`
  (e.g. `luacheck`, `lua-language-server`, `selene`, `luavela`).
- Keep names exactly as in the `_data/*.yml` files so the tags resolve to
  links and the home-page grouping works.

## Running locally

Prerequisites: Ruby (>= 2.5) and Bundler. On Ubuntu/Debian:

```sh
sudo apt-get install ruby-full build-essential
sudo gem install bundler
```

Install dependencies and serve:

```sh
bundle install
bundle exec jekyll serve --livereload
```

The site is then available at <http://localhost:4000>. To do a one-off build
into `_site/`:

```sh
bundle exec jekyll build
```

The `Gemfile` uses the [`github-pages`](https://github.com/github/pages-gem)
gem, which pins Jekyll and all plugins to exactly the versions GitHub Pages
uses in production, so the local build is identical to the deployed one.
