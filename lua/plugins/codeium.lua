return {
    "Exafunction/codeium.nvim",
    event = "Bufenter",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
    },
    config = function() require("codeium").setup {} end,
}
