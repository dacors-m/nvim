vim.opt.nu = true
vim.opt.rnu = true
vim.g.netrw_bufsettings = "nu"

vim.opt.termguicolors = true
vim.opt.backup = false
vim.opt.hidden = true
vim.opt.ignorecase = true
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 8
vim.opt.wrap = false
vim.opt.incsearch = true

vim.opt.colorcolumn = "80"
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

require("tokyonight").setup({
    style = "night",        -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
    transparent = true,     -- Enable this to disable setting the background color
    terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
    styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value for `:help nvim_set_hl`
        comments = { italic = false },
        keywords = { italic = false },
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "dark", -- style for sidebars, see below
        floats = "dark",   -- style for floating windows
    }
})

--theme dragon
require("kanagawa").setup({
    transparent = true,
    undercurl = true,
    terminalColors = true,
})

--carbonfox
require('nightfox').setup({
    options = {
        transparent = false,
        terminal_colors = true,
    }
})

require('rose-pine').setup({
    disable_background = true,
    disable_float_background = true,
})

require("catppuccin").setup({
    flavour = "mocha",
    transparent_background = true, -- disables setting the background color.
    float = {
        transparent = true,        -- enable transparent floating windows
        solid = false,             -- use solid styling for floating windows, see |winborder|
    },
})

vim.cmd("colorscheme catppuccin")
