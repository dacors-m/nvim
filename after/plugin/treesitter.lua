require("nvim-treesitter.config").setup {
    -- lista de parsers a instalar
    ensure_installed = { "go", "lua", "python" },

    -- instala parsers sincrónicamente (solo para ensure_installed)
    sync_install = false,

    -- instala automáticamente parsers faltantes al abrir buffer
    auto_install = true,

    -- opcional: directorio de instalación de parsers
    -- parser_install_dir = "/ruta/a/parsers",
    -- recuerda agregar al runtimepath: vim.opt.runtimepath:append("/ruta/a/parsers")

    highlight = {
        enable = true, -- habilita resaltado de sintaxis
        additional_vim_regex_highlighting = false,
    },

    indent = { enable = true }, -- habilita indentación basada en treesitter

    -- campos requeridos en la nueva versión
    modules = {},        -- puede estar vacío si no usas módulos extra
    ignore_install = {}, -- lista de parsers a ignorar

    install_config = {
        compiler = "zig",
    },
}

-- Forzar el resaltado por defecto
vim.api.nvim_create_autocmd("FileType", {
    pattern = "go",
    callback = function()
        vim.treesitter.start()
    end,
})
