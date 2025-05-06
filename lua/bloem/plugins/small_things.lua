return
{
    {
        "echasnovski/mini.pairs",
        config = function ()
            require("mini.pairs").setup()
        end
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function ()
            require("ibl").setup({
                    scope = {
                        enabled = false
                    }
                })
        end
    }
}
