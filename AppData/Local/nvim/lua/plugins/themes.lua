return {
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "catppuccin-mocha",
            -- colorscheme = "onedark_dark",
            -- colorscheme = "tokyonight",
            -- colorscheme = "tokyodark",
        },
    },
    {
        "olimorris/onedarkpro.nvim",
        priority = 1000, -- Ensure it loads first
    },
    {
        "tiagovla/tokyodark.nvim",
        opts = {
            -- custom options here
        },
        config = function(_, opts)
            require("tokyodark").setup(opts) -- calling setup is optional
        end,
    },
}
