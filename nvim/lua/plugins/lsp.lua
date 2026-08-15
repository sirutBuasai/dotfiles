return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "saghen/blink.cmp",
  },
  config = function()
    local icons = require("config.icons")

    -- -- mason --------------------------------------------------------------
    require("mason").setup({
      ui = {
        icons = {
          server_installed = icons.ui.BoldCheck,
          server_pending = icons.ui.Gear,
          server_uninstalled = icons.ui.BoldClose,
        },
      },
    })

    -- -- mason-lspconfig- ----------------------------------------------------
    require("mason-lspconfig").setup({
      ensure_installed = {
        "bashls",
        "clangd",
        "dockerls",
        "gh_actions_ls",
        "gopls",
        "jdtls",
        "jsonls",
        "lua_ls",
        "marksman",
        "ruff",
        "pyright",
        "ts_ls",
      },
      automatic_enable = true,
    })

    -- -- mason-tool-installer -----------------------------------------------
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

    -- -- default capabilities -----------------------------------------------
    vim.lsp.config("*", {
      capabilities = require("blink.cmp").get_lsp_capabilities(),
    })

    -- -- diagnostics UI -----------------------------------------------------
    vim.diagnostic.config({
      virtual_text = false,
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

    -- -- auto-open diagnostic float on CursorHold ---------------------------
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

    -- -- keymaps ------------------------------------------------------------
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

        -- inlay hints toggle
        bmap("n", "<leader>hi", function()
          local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = buf })
          vim.lsp.inlay_hint.enable(not enabled, { bufnr = buf })
        end, "Toggle inlay hints")
      end,
    })
  end,
}
