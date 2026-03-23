# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Neovim configuration using lazy.nvim as the plugin manager.

## Architecture

```
~/.config/nvim
├── init.lua              # Entry point, loads config/lazy.lua
├── lua/
│   ├── config/
│   │   └── lazy.lua      # lazy.nvim bootstrap and setup
│   └── plugins/          # Plugin specs (auto-imported by lazy.nvim)
```

- **Leader key**: Space
- **Local leader**: Backslash

## Adding Plugins

Create a new `.lua` file in `lua/plugins/` returning a plugin spec table. Files in this directory are automatically imported by lazy.nvim.

Example plugin spec:
```lua
return {
  "author/plugin-name",
  opts = {},
}
```
