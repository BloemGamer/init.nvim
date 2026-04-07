return {
    {
        "nvimtools/none-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local null_ls = require("null-ls")
            local formatting = null_ls.builtins.formatting
            local Path = require("plenary.path")

            -- C/C++ formatter (auto-format on save)
            null_ls.setup({
                sources = {
                    formatting.clang_format, -- C/C++ formatting
                },
                on_attach = function(client, bufnr)
                    if client.supports_method("textDocument/formatting") then
                        -- Auto-format C/C++ safely on save
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            buffer = bufnr,
                            callback = function()
                                vim.lsp.buf.format({ bufnr = bufnr })
                            end,
                        })
                    end
                end,
            })

            -- User command to format Haskell manually with Fourmolu
            vim.api.nvim_create_user_command("FormatHaskell", function()
                local buf = vim.api.nvim_get_current_buf()
                local file = vim.api.nvim_buf_get_name(buf)
                local cwd = vim.fn.getcwd()
                local config = Path:new(cwd, "fourmolu.yaml")
                local cmd = { "fourmolu", "--mode", "inplace", "-q" }

                if config:exists() then
                    table.insert(cmd, "--config")
                    table.insert(cmd, config:absolute())
                end

                table.insert(cmd, file)

                -- Run Fourmolu on the file
                vim.fn.system(cmd)
                vim.cmd("edit") -- reload buffer safely
                print("Haskell formatted with Fourmolu")
            end, {})

            -- Optional info command
            vim.api.nvim_create_user_command("EnableProjectAutoFormat", function()
                print("Auto-format enabled (C/C++ on save, Haskell via :FormatHaskell)")
            end, {})
        end,
    },
}
