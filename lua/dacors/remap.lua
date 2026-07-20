vim.g.mapleader = " "

local keymap = vim.keymap.set

-- General
keymap("n", "<leader>e", function()
    vim.cmd("write")
    vim.cmd("Ex")
end, { desc = "Save and open netrw" })

keymap("n", "<leader>w", "<cmd>w!<CR>", { desc = "Save file" })
keymap("n", "<leader>q", "<cmd>q!<CR>", { desc = "Quit without saving" })

keymap("n", "<leader>po", function()
    for name, _ in pairs(package.loaded) do
        if name:match("^dacors") then
            package.loaded[name] = nil
        end
    end

    dofile(vim.fn.stdpath("config") .. "/init.lua")
    vim.notify("Nvim config reloaded")
end, { desc = "Reload Nvim config" })

-- Diagnostics
keymap("n", "<leader>;", vim.diagnostic.open_float, { desc = "Open diagnostic float" })

-- Clipboard sync
vim.opt.clipboard = "unnamedplus"

-- Visual mode move
keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Tmux navigation
keymap("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", { desc = "Navigate left" })
keymap("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", { desc = "Navigate down" })
keymap("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", { desc = "Navigate up" })
keymap("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", { desc = "Navigate right" })

-- LSP
local dacors_group = vim.api.nvim_create_augroup("DacorsGroup", {})

vim.api.nvim_create_autocmd("LspAttach", {
    group = dacors_group,
    callback = function(e)
        local opts = { buffer = e.buf }
        local lsp_keymaps = {
            { "<leader>rv", vim.lsp.buf.rename,         "Rename symbol" },
            { "<leader>ff", vim.lsp.buf.format,         "Format buffer" },
            { "gd",         vim.lsp.buf.definition,     "Go to definition" },
            { "gr",         vim.lsp.buf.references,     "Go to references" },
            { "gi",         vim.lsp.buf.implementation, "Go to implementation" },
            { "gc",         vim.lsp.buf.outgoing_calls, "Show outgoing calls" },
        }

        for _, map in ipairs(lsp_keymaps) do
            keymap("n", map[1], map[2], vim.tbl_extend("force", opts, { desc = map[3] }))
        end
    end,
})
