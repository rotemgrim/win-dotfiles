return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha",
    },
  },

  {
    "mg979/vim-visual-multi",
    branch = "master",
    config = function()
      vim.g.VM_default_mappings = true
    end,
  },

  { import = "lazyvim.plugins.extras.formatting.prettier" },

  {
    "nvim-telescope/telescope.nvim",
    -- change some options
    opts = {
      defaults = {
        sorting_strategy = "ascending",
        layout_strategy = "flex",
        layout_config = {
          width = 0.7,
          horizontal = {
            preview_width = 0.5,
          },
          prompt_position = "top",
          flex = {
            width = 0.9,
            flip_columns = 150,
          },
        },
        mappings = {
          i = {
            ["<Esc>"] = require("telescope.actions").close,
          },
        },
      },
    },
  },
}
