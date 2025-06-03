local autocmd = vim.api.nvim_create_autocmd

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
                autocmd('BufEnter', {
                    callback = function ()

                        if vim.bo.filetype == "lua" then
                            require("ibl").setup({
                                scope = {
                                    enabled = true
                                }
                            })
                        elseif vim.bo.filetype == "python" then
                            require("ibl").setup({
                                scope = {
                                    enabled = true
                                }
                            })
                        else
                            require("ibl").setup({
                                scope = {
                                    enabled = false
                                }
                            })
                        end
                    end
                })
        end
    }
}
