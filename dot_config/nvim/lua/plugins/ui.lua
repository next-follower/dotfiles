return {
  { "nvim-tree/nvim-web-devicons", lazy = true },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        globalstatus = true,
        theme = "auto",
      },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      delay = 300,
      spec = {
        { "<leader>f", group = "find/format" },
        { "<leader>g", group = "git" },
        { "<leader>s", group = "split" },
      },
    },
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    opts = {
      cmdline = {
        enabled = true,
        view = "cmdline",
        format = {
          cmdline = { pattern = "^:", icon = ":", lang = "vim" },
          search_down = { kind = "search", pattern = "^/", icon = "/", lang = "regex" },
          search_up = { kind = "search", pattern = "^%?", icon = "?", lang = "regex" },
          filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
          lua = { pattern = "^:%s*lua%s+", icon = "lua", lang = "lua" },
          help = { pattern = "^:%s*he?l?p?%s+", icon = "?", lang = "vim" },
        },
      },
      messages = {
        enabled = true,
      },
      popupmenu = {
        enabled = true,
      },
      presets = {
        command_palette = false,
        long_message_to_split = true,
      },
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },
}
