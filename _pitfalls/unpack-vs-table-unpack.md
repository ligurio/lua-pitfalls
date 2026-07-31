---
layout: pitfall
title: "Global `unpack` was removed in Lua 5.2"
description: >-
  In Lua 5.1 the function `unpack` was a global. Since Lua 5.2 it lives in the
  `table` library, so code that calls the global `unpack` fails at runtime on
  any non-5.1 interpreter. Static analyzers catch the undefined global.
runtime:
  - Lua 5.2
  - Lua 5.3
  - Lua 5.4
  - Lua 5.5
analyzers:
  - luacheck
  - selene
---

```lua
local values = {10, 20, 30}

-- Lua 5.1 and LuaJIT: works fine.
local a, b, c = unpack(values)

-- Lua 5.2+: attempts to call the global 'unpack', which is nil.
-- Runtime error: attempt to call global 'unpack' (a nil value)
```

Use the portable form instead:

```lua
local values = {10, 20, 30}

-- Works on Lua 5.1 (via the compatibility shim) and Lua 5.2+.
local a, b, c = table.unpack(values)

-- Or the fully portable idiom:
local unpack = table.unpack or unpack
local a, b, c = unpack(values)
```

`luacheck` and `selene` both flag the undefined global.
