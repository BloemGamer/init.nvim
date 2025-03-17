vim.keymap.set('n', '<space>', '<nop>')
vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>p', vim.cmd.Ex)

--if vim.g.vscode then
   -- VSCode extension
    -- these ones don't work
    --vim.keymap.set('n', '<C-u>', '<C-u>zz')
    --vim.keymap.set('n', '<C-d>', '<C-d>zz') 
--else
   -- ordinary Neovim
    --vim.keymap.set('n', '<C-u>', '<C-u>zz')
    --vim.keymap.set('n', '<C-d>', '<C-d>zz') 
    --vim.keymap.set('n', 'n', 'nzz')
    --vim.keymap.set('n', 'N', 'Nzz')
--end

vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz') 
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')
