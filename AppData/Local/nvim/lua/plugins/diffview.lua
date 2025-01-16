-- Add diffview.nvim plugin
return {
    "sindrets/diffview.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
        require("diffview").setup()
    end,
    lazy = true,
    event = "BufRead", -- Or any other event you want to load the plugin with
}
