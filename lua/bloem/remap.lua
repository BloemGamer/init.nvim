vim.keymap.set('n', '<space>', '<nop>')
vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)


vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz') 
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", {silent = true})
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", {silent = true})

vim.keymap.set('x', '<leader>p', '\"_dP')

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set('n', '<Up>',    '<C-w>k', { noremap = true, silent = true })
vim.keymap.set('n', '<Down>',  '<C-w>j', { noremap = true, silent = true })
vim.keymap.set('n', '<Left>',  '<C-w>h', { noremap = true, silent = true })
vim.keymap.set('n', '<Right>', '<C-w>l', { noremap = true, silent = true })
