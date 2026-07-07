require("sidekick").setup({
    nes = {
        enabled = false,
    }
})

vim.keymap.set("n", "<leader>si", function()
    require("sidekick.cli").toggle()
end, { desc = "Toggle Sidekick CLI" })
