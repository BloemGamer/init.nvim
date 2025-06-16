require("bloem")

if vim.g.neovide then
    -- GUI font with no ligatures
    vim.o.guifont = "Cascadia Mono:h14"

    -- Disable all cursor animations
    vim.g.neovide_cursor_animation_length = 0
    vim.g.neovide_cursor_trail_length = 0
    vim.g.neovide_cursor_vfx_mode = ""

    -- Start in fullscreen mode
    vim.g.neovide_fullscreen = true
end
