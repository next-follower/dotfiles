# Repository Guidelines

This repository stores personal dotfiles managed by chezmoi. Treat files in this
repository as the source of truth, and avoid editing generated target files in
`$HOME` unless the user explicitly asks to apply or debug the live state.

## Structure

- `dot_config/nvim/` maps to `~/.config/nvim/`.
- `dot_config/ghostty/` maps to `~/.config/ghostty/`.
- `dot_config/zed/` maps to `~/.config/zed/`.
- `README.md` should stay short and describe the repository at a high level.

## Chezmoi Workflow

- Edit source files in this repository first.
- Use `chezmoi apply <target>` when a change must be written to the live home
  directory. Applying to `$HOME` paths may require approval because it writes
  outside the workspace.
- If a source file is deleted, check whether a stale live file remains under the
  target path; chezmoi may not remove unmanaged leftovers automatically.
- Prefer targeted apply commands, for example:

```sh
chezmoi apply ~/.config/nvim
```

## Neovim Configuration

- Keep `dot_config/nvim/init.lua` as a small entry point.
- Put base Neovim behavior in `dot_config/nvim/lua/config/`.
- Put lazy.nvim plugin specs in `dot_config/nvim/lua/plugins/`.
- Do not add `nvim-treesitter`; the upstream repository is archived. Prefer
  Neovim's built-in `vim.treesitter.start()` when parser support is available.
- Avoid requiring plugin modules at plugin-spec import time. Use lazy.nvim
  `opts = function()` or `config = function()` when a plugin module must be
  required.
- Keep plugin behavior close to the relevant plugin spec. Avoid adding custom
  glue for common editor behavior when a plugin-native option or command exists.
- UI conventions currently use `catppuccin/nvim` as the active theme,
  `akinsho/bufferline.nvim` for top buffers, `nvim-neo-tree/neo-tree.nvim` for
  the file explorer, `folke/noice.nvim` for the centered command line,
  `akinsho/toggleterm.nvim` for the bottom terminal, and
  `DaikyXendo/nvim-material-icon` for file icons.
- LSP configuration lives in `dot_config/nvim/lua/plugins/lsp.lua`. Mason-managed
  servers should be listed in `mason-lspconfig.nvim` `ensure_installed`.
  Dart/Flutter uses `dartls` from the local Dart or Flutter SDK and should be
  enabled explicitly with `vim.lsp.enable("dartls")`.
- Formatter configuration lives in `dot_config/nvim/lua/plugins/format.lua` and
  uses `stevearc/conform.nvim`. Prefer formatter names supported by Conform
  instead of shelling out manually.
- Current language support includes Go (`gopls`, `goimports`, `gofmt`), Rust
  (`rust_analyzer`, `rustfmt`), Kotlin (`kotlin_language_server`, `ktlint`), and
  Dart/Flutter (`dartls`, `dart_format`).
- LSP navigation keymaps are buffer-local and configured on `LspAttach`; keep
  definition/reference/implementation mappings there rather than in global
  keymaps.

Useful validation commands:

```sh
env XDG_STATE_HOME=/private/tmp/nvim-state XDG_CACHE_HOME=/private/tmp/nvim-cache nvim --headless -i NONE '+qa'
env XDG_STATE_HOME=/private/tmp/nvim-state XDG_CACHE_HOME=/private/tmp/nvim-cache nvim --headless -i NONE /private/tmp/nvim-config-check.lua '+qa'
```

When validating the source tree before applying it, point Neovim at the chezmoi
source config:

```sh
env XDG_CONFIG_HOME=/Users/fengchen/.local/share/chezmoi/dot_config XDG_STATE_HOME=/private/tmp/nvim-state XDG_CACHE_HOME=/private/tmp/nvim-cache XDG_DATA_HOME=/Users/fengchen/.local/share nvim --headless -i NONE '+qa'
```

## Editing Rules

- Keep changes narrow and preserve unrelated user edits.
- Use structured config APIs over ad hoc shell or string rewrites.
- Do not commit, stage, or push unless the user asks.
- Before reporting success, run the relevant validation command and report any
  command that could not be run.
