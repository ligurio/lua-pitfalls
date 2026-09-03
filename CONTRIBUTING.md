# Contributing

This is a Jekyll site hosted on GitHub Pages. Each file in
`_pitfalls/`, `_openresty/` or `_tarantool/` is a single Markdown
page describing one pitfall: a short description, a code demo
with syntax highlighting, and tag categories - the Lua runtime(s)
affected, the static analyzers that can catch the problem, and
(for platforms) the application with its own Lua API. Every tag
links to its own page (see [`runtimes/`](runtimes/) and
[`analyzers/`](analyzers/)) listing all pitfalls with that tag
plus information about the runtime or analyzer.

## Project layout

```
_config.yml          # Site config: collections, kramdown + Rouge, defaults.
_data/runtimes.yml   # Canonical list of Lua runtimes (tag metadata).
_data/analyzers.yml  # Canonical list of static analyzers (tag metadata).
_data/platforms.yml  # Canonical list of platforms (OpenResty, Tarantool).
_layouts/            # Page templates (default, home, pitfall, tag-page).
_includes/           # Reusable snippets (tags).
_pitfalls/           # One Markdown file per Lua pitfall (IDs: L1001, ...).
_openresty/          # OpenResty pitfalls (IDs: O1001, ...).
_tarantool/          # Tarantool pitfalls (IDs: T1001, ...).
runtimes/            # One Markdown file per Lua runtime tag page.
analyzers/           # One Markdown file per static analyzer tag page.
openresty/           # OpenResty section page (/openresty/).
tarantool/           # Tarantool section page (/tarantool/).
assets/css/          # Styles (including Rouge syntax colors).
index.md             # Home page listing all pitfalls.
```

## Adding a pitfall

Create `_pitfalls/L100N.md` — the file name **is** the pitfall ID (`L1001`,
`L1002`, ...). OpenResty and Tarantool pitfalls use `_openresty/O100N.md` and
`_tarantool/T100N.md` with IDs prefixed `O` and `T`. Set an explicit
`permalink` in the front matter that matches the ID (Jekyll lowercases slugs,
so this is required to keep the exact case):

```markdown
---
layout: pitfall
title: "Short, descriptive title"
permalink: /p/L1001/      # or /o/O1001/, /t/T1001/
description: >-
  One or two sentences explaining the problem.
runtime:
  - Lua 5.1
  - Lua 5.4
analyzers:
  - luacheck
  - selene
platform:                 # only for platform pitfalls
  - OpenResty             # or Tarantool
---
```

Pick the next free number for the ID and use it both in the file name and in
`permalink`. The page is served at `/p/L1001/`, `/o/O1001/` or `/t/T1001/`.

- `runtime` — one or more entries. Pick from `_data/runtimes.yml`
  (e.g. `Lua 5.1`, `Lua 5.2`, `Lua 5.3`, `Lua 5.4`, `Lua 5.5`, `LuaJIT`).
- `analyzers` — one or more entries from `_data/analyzers.yml`
  (e.g. `luacheck`, `selene`, `emmylua-analyzer`).
- `platform` — one or more entries from `_data/platforms.yml`
  (`OpenResty`, `Tarantool`).
- Keep names exactly as in the `_data/*.yml` files so the tags resolve to
  links and the section pages work.

## Tag pages

Every runtime and analyzer from `_data/*.yml` has a page listing the pitfalls
with that tag plus a description and a link to the official site. Each tag page
is a tiny Markdown file:

- `runtimes/lua-5.1.md` → `Lua 5.1`
- `analyzers/luacheck.md` → `luacheck`

Front matter of a tag page:

```markdown
---
layout: tag-page
kind: runtime    # "runtime", "analyzer" or "platform"
tag: Lua 5.2     # key from _data/runtimes.yml or _data/analyzers.yml
title: Lua 5.2
---
```

Platform section pages are the same layout but live at `openresty/index.md`
and `tarantool/index.md`:

```markdown
---
layout: tag-page
kind: platform
tag: OpenResty
collection: openresty   # Jekyll collection to list
title: OpenResty
---
```

When adding a new runtime, analyzer or platform, add an entry to the
corresponding `_data/*.yml` file (with `name`, `slug`, `url`, `description`)
**and** a tag/section page file like the ones above.

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

The site is then available at <http://localhost:4000/lua-pitfalls/>. To do a
one-off build
into `_site/`:

```sh
bundle exec jekyll build
```

The `Gemfile` uses the [`github-pages`](https://github.com/github/pages-gem)
gem, which pins Jekyll and all plugins to exactly the versions GitHub Pages
uses in production, so the local build is identical to the deployed one.
