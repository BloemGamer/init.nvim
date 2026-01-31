return {
    {
        "nvimtools/none-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local null_ls = require("null-ls")
            vim.api.nvim_create_user_command('EnableProjectAutoFormat', function()
				null_ls.setup({
					sources = {
						null_ls.builtins.formatting.clang_format,
					},
					on_attach = function(client, bufnr)
						if client.supports_method("textDocument/formatting") then
							-- auto-format on save
							vim.api.nvim_create_autocmd("BufWritePre", {
								buffer = bufnr,
								callback = function()
									vim.lsp.buf.format({ bufnr = bufnr })
								end,
							})
						end
					end,
				})
			end, {})

            -- Command to format the whole project
            vim.api.nvim_create_user_command('FormatProject', function()
                -- Format open C/C++ buffers
                for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                    if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_option(buf, "filetype"):match("c") then
                        if vim.api.nvim_buf_get_option(buf, "modifiable") and vim.api.nvim_buf_get_option(buf, "buftype") == "" then
                            vim.lsp.buf.format({ bufnr = buf, async = false })
                            vim.api.nvim_buf_call(buf, function() vim.cmd("write") end)
                        end
                    end
                end

                -- Format remaining files on disk
                local handle = io.popen('find . -type f \\( -name "*.[ch]" -o -name "*.[ch]pp" \\)')
                if handle then
                    for file in handle:lines() do
                        if not vim.fn.bufloaded(file) then
                            vim.fn.system("clang-format -i " .. file)
                        end
                    end
                    handle:close()
                end

                print("Project formatted!")
            end, {})
        end,
    }
}
