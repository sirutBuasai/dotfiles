-- plugins/lsp.lua — native LSP setup for Neovim 0.11+/0.12.
--
-- ARCHITECTURE: uses first-class vim.lsp.config / vim.lsp.enable (0.11+), NOT
-- the legacy require('lspconfig').<server>.setup{}. nvim-lspconfig is a dep only
-- for its per-server default DATA (cmd/filetypes/root markers) consumed by
-- vim.lsp.enable; our overrides live in ~/.config/nvim/lsp/<server>.lua. mason
-- installs binaries; mason-lspconfig bridges names and auto-enables installed
-- servers. Reference highlighting is handled by snacks.words (not lsp doc-hl).

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "saghen/blink.cmp", -- for get_lsp_capabilities()
  },
  config = function()
    local icons = require("config.icons")

    -- ── mason (custom UI icons restored) ──────────────────────────────────
    require("mason").setup({
      ui = {
        icons = {
          server_installed = icons.ui.BoldCheck,
          server_pending = icons.ui.Gear,
          server_uninstalled = icons.ui.BoldClose,
        },
      },
    })

    -- ── mason-lspconfig: install listed servers + auto-enable (v2) ─────────
    require("mason-lspconfig").setup({
      ensure_installed = {
        "bashls",
        "clangd",
        "dockerls",
        "gh_actions_ls",
        "gopls",
        "jdtls",
        "jsonls",
        "lua_ls", -- overrides in lsp/lua_ls.lua
        "marksman",
        "ruff",
        "pyright",
        "ts_ls",
      },
      automatic_enable = true,
    })

    -- ── mason-tool-installer: non-LSP tools used by conform.nvim ──────────
    require("mason-tool-installer").setup({
      ensure_installed = {
        "goimports",
        "google-java-format",
        "jq",
        "mdformat",
        "prettier",
        "prettierd",
        "shfmt",
        "stylua",
      },
    })

    -- ── default capabilities for all servers (advertise blink's) ──────────
    vim.lsp.config("*", {
      capabilities = require("blink.cmp").get_lsp_capabilities(),
    })

    -- ── diagnostics UI (custom gutter glyphs + underline restored) ────────
    vim.diagnostic.config({
      virtual_text = false, -- no inline noise; float on demand / auto-float
      update_in_insert = true,
      underline = true,
      severity_sort = true,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error .. " ",
          [vim.diagnostic.severity.WARN] = icons.diagnostics.Warning .. " ",
          [vim.diagnostic.severity.INFO] = icons.diagnostics.Info .. " ",
          [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint .. " ",
        },
      },
      float = { border = "rounded", source = true },
    })

    -- ── auto-open diagnostic float on CursorHold (toggle with gL) ─────────
    local float_group = vim.api.nvim_create_augroup("AutoFloat", { clear = false })
    local function enable_auto_float(bufnr)
      vim.api.nvim_create_autocmd("CursorHold", {
        group = float_group,
        buffer = bufnr,
        callback = function()
          vim.diagnostic.open_float(nil, {
            focus = false,
            close_events = { "CursorMoved", "CursorMovedI", "BufHidden", "InsertCharPre" },
          })
        end,
      })
    end

    -- ── buffer-local keymaps on attach (nav via snacks.picker) ────────────
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
      callback = function(event)
        local buf = event.buf
        local function bmap(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = "LSP: " .. desc })
        end

        -- navigation
        bmap("n", "gd", function() Snacks.picker.lsp_definitions() end, "Go to definition")
        bmap("n", "gr", function() Snacks.picker.lsp_references() end, "References")
        bmap("n", "gi", function() Snacks.picker.lsp_implementations() end, "Implementations")
        bmap("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
        bmap("n", "<leader>D", function() Snacks.picker.lsp_type_definitions() end, "Type definition")
        bmap("n", "<leader>ds", function() Snacks.picker.lsp_symbols() end, "Document symbols")
        bmap("n", "<leader>ws", function() Snacks.picker.lsp_workspace_symbols() end, "Workspace symbols")

        -- refactor / actions
        bmap("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
        bmap({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")

        -- diagnostics: gl = open float now; gL = toggle auto-float-on-hover
        bmap("n", "gl", vim.diagnostic.open_float, "Line diagnostics (float)")
        vim.api.nvim_clear_autocmds({ buffer = buf, group = float_group })
        enable_auto_float(buf)
        vim.b[buf].auto_float_enabled = true
        bmap("n", "gL", function()
          if vim.b[buf].auto_float_enabled then
            vim.api.nvim_clear_autocmds({ buffer = buf, group = float_group })
            vim.b[buf].auto_float_enabled = false
          else
            enable_auto_float(buf)
            vim.b[buf].auto_float_enabled = true
          end
        end, "Toggle diagnostic auto-float")

        -- inlay hints toggle (no-ops if the server lacks support)
        bmap("n", "<leader>hi", function()
          local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = buf })
          vim.lsp.inlay_hint.enable(not enabled, { bufnr = buf })
        end, "Toggle inlay hints")
      end,
    })
  end,
}
