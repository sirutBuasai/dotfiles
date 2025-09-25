local icons = require("config.icons")

local mason = require("mason")

local mason_tool_installer = require("mason-tool-installer")

local mason_lspconfig = require("mason-lspconfig")

local servers = {
  "bashls",
  "clangd",
  "dockerls",
  "gopls",
  "jdtls",
  "jsonls",
  "lua_ls",
  "marksman",
  "pyright",
  "ts_ls",
}

local formatters = {
  "black",
  "goimports",
  "google-java-format",
  "isort",
  "jq",
  "mdformat",
  "prettier",
  "prettierd",
  "shfmt",
  "stylua",
}

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(event)
    -- We create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local map = function(keys, func, desc, mode)
      mode = mode or "n"
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end

    -- Jump to the definition of the word under your cursor.
    -- To jump back, press <C-t>.
    map("gd", function()
      Snacks.picker.lsp_definitions()
    end, "[G]oto [D]efinition")
    map("gr", function()
      Snacks.picker.lsp_references()
    end, "[G]oto [R]eferences")
    map("gi", function()
      Snacks.picker.lsp_implementations()
    end, "[G]oto [I]mplementation")
    map("<leader>D", function()
      Snacks.picker.lsp_type_definitions()
    end, "Type [D]efinition")
    map("<leader>ds", function()
      Snacks.picker.lsp_symbols()
    end, "[D]ocument [S]ymbols")
    map("<leader>ws", function()
      Snacks.picker.lsp_workspace_symbols()
    end, "[W]orkspace [S]ymbols")
    map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

    -- Custom float diagnostic behavior
    -- By default hovering over keyword will show float window for diagnostics
    -- This function toggle_diagnostic_float is used to toggle this behavior on/off
    vim.api.nvim_create_augroup("AutoFloat", { clear = false })
    vim.api.nvim_clear_autocmds({ buffer = event.buf, group = "AutoFloat" })
    vim.api.nvim_create_autocmd({ "CursorHold" }, {
      group = "AutoFloat",
      buffer = event.buf,
      callback = function()
        vim.diagnostic.open_float(nil, {
          focus = false,
          close_events = {
            "CursorMoved",
            "CursorMovedI",
            "BufHidden",
            "InsertCharPre",
          },
        })
      end,
    })
    vim.g.toggle_diagnostic_float_enabled = true
    local function toggle_diagnostic_hover()
      if vim.g.toggle_diagnostic_float_enabled then
        -- Remove the autocommand
        vim.api.nvim_clear_autocmds({ buffer = event.buf, group = "AutoFloat" })
        vim.g.toggle_diagnostic_float_enabled = false
      else
        -- Create the autocommand
        vim.api.nvim_create_autocmd({ "CursorHold" }, {
          group = "AutoFloat",
          buffer = event.buf,
          callback = function()
            vim.diagnostic.open_float(nil, {
              focus = false,
              close_events = {
                "CursorMoved",
                "CursorMovedI",
                "BufHidden",
                "InsertCharPre",
              },
            })
          end,
        })
        vim.g.toggle_diagnostic_float_enabled = true
      end
    end
    -- To get into float window type "gl"
    -- To disable float window when hovering to reduce clutter, "type gtl"
    map("gl", function()
      vim.diagnostic.open_float()
    end, "[G]oto F[l]oat")
    map("gL", function()
      toggle_diagnostic_hover()
    end, "Toggle Diagnostic Hover Float")

    -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
    local function client_supports_method(client, method, bufnr)
      -- Used to nvim-0.11
      return client:supports_method(method, bufnr)
      -- Used to nvim-0.10
      -- return client.supports_method(method, { bufnr = bufnr })
    end

    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if
      client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
    then
      local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
        end,
      })
    end

    -- The following code creates a keymap to toggle inlay hints in your
    -- code, if the language server you are using supports them
    if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
      map("<leader>hi", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
      end, "[T]oggle Inlay [H]ints")
    end
  end,
})

vim.diagnostic.config({
  -- disable virtual text
  virtual_text = false,
  -- show signs
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error .. " ",
      [vim.diagnostic.severity.WARN] = icons.diagnostics.Warning .. " ",
      [vim.diagnostic.severity.INFO] = icons.diagnostics.Info .. " ",
      [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint .. " ",
    },
  },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    border = "rounded",
    source = true,
  },
})

mason.setup({
  ui = {
    icons = {
      server_installed = icons.ui.BoldCheck,
      server_pending = icons.ui.Gear,
      server_uninstalled = icons.ui.BoldClose,
    },
  },
})

local ensure_installed = vim.deepcopy(servers)
vim.list_extend(ensure_installed, formatters)
mason_tool_installer.setup({ ensure_installed = ensure_installed })

mason_lspconfig.setup({
  ensure_installed = {}, -- explicitly set to an empty table (Installs via mason-tool-installer instead)
  automatic_installation = false,
})

vim.lsp.enable(servers)
