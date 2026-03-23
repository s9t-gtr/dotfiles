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

## Plugin Documentation

`nvim/README.md` にプラグイン一覧を管理している。プラグインの追加・削除・設定変更を行った場合は、必ず `nvim/README.md` のテーブルも同じ形式で更新すること。

テーブルの列: `Plugin`（リンク付き）, `File`, `Description`, `Key Bindings`
