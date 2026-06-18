local active_theme = "catppuccin"
local theme_command_is_setup = false

local themes = {
  kanagawa = function()
    vim.cmd.colorscheme("kanagawa")
  end,
  catppuccin = function()
    vim.cmd.colorscheme("catppuccin-mocha")
  end,
  tokyonight = function()
    vim.cmd.colorscheme("tokyonight")
  end,
}

local function apply_theme(name)
  local theme = themes[name]
  if not theme then
    vim.notify("Unknown theme: " .. name, vim.log.levels.WARN)
    return
  end
  theme()
end

local function setup_theme_command()
  if theme_command_is_setup then
    return
  end

  vim.api.nvim_create_user_command("Theme", function(opts)
    apply_theme(opts.args)
  end, {
    nargs = 1,
    complete = function()
      return vim.tbl_keys(themes)
    end,
  })
  theme_command_is_setup = true
end

local function apply_active_theme(name)
  if active_theme ~= name then
    return
  end

  apply_theme(name)
end

setup_theme_command()

return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      flavour = "mocha",
      transparent_background = true,
      term_colors = true,
      integrations = {
        blink_cmp = true,
        gitsigns = true,
        mason = true,
        native_lsp = {
          enabled = true,
        },
        neotree = true,
        noice = true,
        telescope = {
          enabled = true,
        },
        which_key = true,
      },
      custom_highlights = function(colors)
        return {
          NormalFloat = { bg = "none" },
          FloatBorder = { bg = "none", fg = colors.surface2 },
          FloatTitle = { bg = "none", fg = colors.mauve },
          NeoTreeNormal = { bg = "none" },
          NeoTreeNormalNC = { bg = "none" },
          NeoTreeEndOfBuffer = { bg = "none", fg = colors.base },
          NeoTreeWinSeparator = { bg = "none", fg = colors.surface0 },
          SignColumn = { bg = "none" },
          LineNr = { bg = "none" },
          CursorLineNr = { bg = "none", fg = colors.lavender },
        }
      end,
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      apply_active_theme("catppuccin")
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      compile = false,
      transparent = true,
      terminalColors = true,
      theme = "dragon",
      background = {
        dark = "dragon",
        light = "lotus",
      },
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none",
            },
          },
        },
      },
      overrides = function(colors)
        local theme = colors.theme
        return {
          NormalFloat = { bg = "none" },
          FloatBorder = { bg = "none", fg = theme.ui.float.fg_border },
          FloatTitle = { bg = "none", fg = theme.ui.special },
          NeoTreeNormal = { bg = "none" },
          NeoTreeNormalNC = { bg = "none" },
          NeoTreeEndOfBuffer = { bg = "none", fg = theme.ui.bg },
          NeoTreeWinSeparator = { bg = "none", fg = theme.ui.bg_p1 },
          SignColumn = { bg = "none" },
          LineNr = { bg = "none" },
          CursorLineNr = { bg = "none", fg = theme.syn.identifier },
        }
      end,
    },
    config = function(_, opts)
      require("kanagawa").setup(opts)
      apply_active_theme("kanagawa")
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      transparent = true,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        sidebars = "transparent",
        floats = "transparent",
      },
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      apply_active_theme("tokyonight")
    end,
  },
}
