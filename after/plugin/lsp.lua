local capabilities = require('cmp_nvim_lsp').default_capabilities()


-- Helper para buscar root_dir tipo lspconfig
local function get_root(files)
    return vim.fs.dirname(vim.fs.find(files, { upward = true })[1])
end

-- Python (Ruff LSP moderno)
vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function()
        local bufnr = vim.api.nvim_get_current_buf()

        -- Ruff
        vim.lsp.start({
            name = "ruff",
            cmd = { vim.fn.stdpath("data") .. "/mason/bin/ruff", "server" },
            root_dir = get_root({
                "pyproject.toml",
                "ruff.toml",
                ".ruff.toml",
                "setup.py",
                "setup.cfg",
                "requirements.txt",
                ".git"
            }),
            capabilities = capabilities,
            settings = {
                ruff = {
                    format = { enabled = true },
                },
            },
        })
        -- Pyright SOLO para sugerencias (sin diagnostics)
        local root = get_root({ "pyrightconfig.json", "pyproject.toml", ".git" })
        vim.lsp.start({
            name = "pyright",
            cmd = { vim.fn.stdpath("data") .. "/mason/bin/pyright-langserver", "--stdio" },
            root_dir = root,
            capabilities = capabilities,
            settings = {
                python = {
                    pythonPath = (function()
                        local venv = root .. "/.venv/bin/python"
                        if vim.fn.executable(venv) == 1 then return venv end
                        return vim.fn.exepath("python3")
                    end)(),
                    analysis = {
                        typeCheckingMode = "off", -- sin type checking
                        diagnosticMode = "off",   -- no mostrar errores
                        autoSearchPaths = true,
                        useLibraryCodeForTypes = true,
                    },
                },
            },
        })
    end,
})

--go
vim.api.nvim_create_autocmd("FileType", {
    pattern = "go",
    callback = function()
        local bufnr = vim.api.nvim_get_current_buf()

        -- Formatear al guardar
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ async = false })
            end,
        })

        vim.lsp.start({
            name = "gopls",
            cmd = { "gopls" },
            root_dir = get_root({ "go.mod", ".git" }),
            capabilities = capabilities,
            settings = {
                gopls = {
                    usePlaceholders = true,
                }
            }
        })
    end,
})

-- Lua
vim.api.nvim_create_autocmd("FileType", {
    pattern = "lua",
    callback = function()
        local bufnr = vim.api.nvim_get_current_buf()

        -- Formatear al guardar
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ async = false })
            end,
        })
        vim.lsp.start({
            name = "lua_ls",
            cmd = { "lua-language-server" },
            root_dir = get_root({ ".git", "init.lua" }),
            capabilities = capabilities,
            settings = {
                Lua = {
                    diagnostics = { globals = { "vim" } },
                    workspace = { library = vim.api.nvim_get_runtime_file("", true) },
                }
            }
        })
    end,
})

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = { globals = { "vim" } },
        },
    },
})
vim.lsp.enable("lua_ls")

-- nvim-cmp
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
    }),
    sources = cmp.config.sources({
        { name = "copilot", group_index = 2 },
        { name = "nvim_lsp" },
        { name = "luasnip" },
    }, {
        { name = "buffer" },
    }),
    performance = { max_view_entries = 5 },
})
