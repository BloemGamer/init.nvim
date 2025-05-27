return
{
    'mbbill/undotree',
    config = function()
        vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
        if vim.fn.executable("diff") == 0 then
            vim.g.undotree_DiffAutoOpen = 0
        end
    end
}
