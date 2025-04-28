return
{
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    requires = {{'nvim-lua/plenary.nvim'}},

    config = function()
        local telescope = require('telescope')
        local builtin = require('telescope.builtin')

        telescope.setup(
        {
            defaults =
            {
                -- Ignore .git directories when searching for files
                file_ignore_patterns =
                {
                    "%.exe",
                    "%.git/*",
                    "%.vscode/*",
                    "%.idea/*",
                    "%.venv/*",
                    "__pycache__/*",
                    "%/build*",
                },
            },
        })

        vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Telescope find files' })
        vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Telescope find files git' })
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") });
        end)
    end
}
