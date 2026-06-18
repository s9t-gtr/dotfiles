# プラグイン管理

## インストール済みプラグイン

### blazkowolf/gruber-darker.nvim
**目的**: カラースキーム（Gruber Darker テーマ）
- **関連ファイル**: `lua/plugins/gruber-darker.lua`
- **インストール日**: 2026-01-25

### folke/sidekick.nvim
**目的**: サイドキック（機能未確認）
- **関連ファイル**: `lua/plugins/sidekick.lua`
- **インストール日**: 2026-01-25
- **URL**: https://github.com/folke/sidekick.nvim

### nvim-telescope/telescope.nvim
**目的**: ファジーファインダー（ファイル検索、grep検索など）
- **関連ファイル**: `lua/plugins/telescope.lua`
- **依存関係**: `nvim-lua/plenary.nvim`
- **インストール日**: 2026-01-25
- **URL**: https://github.com/nvim-telescope/telescope.nvim

### MeanderingProgrammer/render-markdown.nvim
**目的**: Markdownファイルをリッチにレンダリング表示
- **関連ファイル**: `lua/plugins/render-markdown.lua`
- **依存関係**: `nvim-treesitter/nvim-treesitter`, `nvim-tree/nvim-web-devicons`
- **インストール日**: 2026-01-25
- **URL**: https://github.com/MeanderingProgrammer/render-markdown.nvim

### kevinhwang91/nvim-ufo
**目的**: 高機能なコード折りたたみ（LSP foldingRange を優先し、treesitter/indent でフォールバック）
- **関連ファイル**: `lua/plugins/ufo.lua`
- **依存関係**: `kevinhwang91/promise-async`
- **補足**: `lua/plugins/lsp.lua` で全LSPクライアントに `foldingRange` capability を付与している
- **インストール日**: 2026-06-18
- **URL**: https://github.com/kevinhwang91/nvim-ufo
