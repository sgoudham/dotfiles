local M = {}

M.default_config = {
  on_attach = function(client, bufnr)
    require("lsp_signature").on_attach({}, bufnr)

    -- add lsp-only keybinds
    local map = function(sequence, cmd, desc)
      vim.keymap.set("n", sequence, cmd, { buffer = bufnr, desc = desc })
    end

    map("K", vim.lsp.buf.hover, "Hover")
    map("]d", vim.diagnostic.goto_next, "Next diagnostic")
    map("[d", vim.diagnostic.goto_prev, "Previous diagnostic")

    map("gs", vim.lsp.buf.signature_help, "LSP Signature Help")
    map("gD", vim.lsp.buf.declaration, "LSP Declarations")
    map("gd", function()
      require("telescope.builtin").lsp_definitions()
    end, "LSP Definitions")
    map("gT", function()
      require("telescope.builtin").lsp_type_definitions()
    end, "LSP Type Definitions")
    map("gr", function()
      require("telescope.builtin").lsp_references()
    end, "LSP References")
    map("gI", function()
      require("telescope.builtin").lsp_implementations()
    end, "LSP Implementations")
    map("gl", function()
      vim.diagnostic.open_float(0, {
        scope = "line",
      })
    end)

    map("<leader>la", vim.lsp.buf.code_action, "Code Action")
    map("<leader>lr", vim.lsp.buf.rename, "Rename")
    map("<leader>lf", vim.lsp.buf.format, "Format")
    map("<leader>ld", function()
      require("telescope.builtin").diagnostics()
    end, "LSP Workplace Diagnostics")
    map("<leader>lD", function()
      require("telescope.builtin").diagnostics({ bufnr = 0 })
    end, "LSP Buffer Diagnostics")
    map("<leader>ls", function()
      require("telescope.builtin").lsp_document_symbols()
    end, "LSP Document Symbols")
    map("<leader>lS", function()
      require("telescope.builtin").lsp_workspace_symbols()
    end, "LSP Workplace Symbols")
  end,
}

return M
