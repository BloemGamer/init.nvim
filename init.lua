--if vim.g.vscode then
--    -- VSCode extension
    vim.keymap.set('n', '<C-u>', '<C-u>zz')
    vim.keymap.set('n', '<C-d>', '<C-d>zz') 
--else
--    -- ordinary Neovim
    vim.keymap.set('n', '<C-u>', '<C-u>zz')
    vim.keymap.set('n', '<C-d>', '<C-d>zz') 
--end

--vim.keymap.set('n', '<C-u>', '<C-u>zz')
--vim.keymap.set('n', '<C-d>', '<C-d>zz') 
