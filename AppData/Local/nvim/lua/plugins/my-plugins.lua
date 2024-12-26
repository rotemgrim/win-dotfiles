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
}
