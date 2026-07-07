vim.keymap.set("n", "<leader>gg", vim.cmd.Git)
vim.keymap.set("n", "<leader>gb", function()
    vim.cmd("Git blame")
end)
