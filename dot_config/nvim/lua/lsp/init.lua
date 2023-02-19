local M = {}

local map = function(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, { buffer = opts[1], desc = opts[2] })
end
M.map = map

M.default_config = {
  on_attach = function(client, bufnr)
    if client.server_capabilities.documentSymbolProvider then
      require("nvim-navic").attach(client, bufnr)
    end

    map("n", "K", vim.lsp.buf.hover, { bufnr, "Hover Information" })
    map("n", "]d", vim.diagnostic.goto_next, { bufnr, "Next Diagnostic" })
    map("n", "[d", vim.diagnostic.goto_prev, { bufnr, "Previous Diagnostic" })

    map("n", "gs", vim.lsp.buf.signature_help, { bufnr, "Signature Help" })
    map("n", "gD", vim.lsp.buf.declaration, { bufnr, "Declarations" })
    map("n", "gd", "<cmd>Telescope lsp_definitions<CR>", { bufnr, "Definitions" })
    map("n", "gT", "<cmd>Telescope lsp_type_definitions<CR>", { bufnr, "Type Definitions" })
    map("n", "gr", "<cmd>Telescope lsp_references<CR>", { bufnr, "References" })
    map("n", "gI", "<cmd>Telescope lsp_implementations<CR>", { bufnr, "Implementations" })
    map("n", "gl", function()
      vim.diagnostic.open_float(0, { scope = "line" })
    end, { bufnr, "LSP Line Diagnostics" })

    map("n", "<leader>la", vim.lsp.buf.code_action, { bufnr, "Code Action" })
    map("n", "<leader>lr", vim.lsp.buf.rename, { bufnr, "Rename" })
    map("n", "<leader>lf", vim.lsp.buf.format, { bufnr, "Format" })
    map("n", "<leader>ld", "<cmd>Telescope diagnostics<CR>", { bufnr, "Workspace Diagnostics" })
    map("n", "<leader>lD", "<cmd>Telescope diagnostics bufnr=0<CR>", { bufnr, "Buffer Diagnostics" })
    map("n", "<leader>ls", "<cmd>Telescope lsp_document_symbols<CR>", { bufnr, "Document Symbols" })
    map("n", "<leader>lS", "<cmd>Telescope lsp_workspace_symbols<CR>", { bufnr, "Workspace Symbols" })
    map("n", "<leader>lwa", vim.lsp.buf.add_workspace_folder, { bufnr, "Add Workspace Folder" })
    map("n", "<leader>lwr", vim.lsp.buf.remove_workspace_folder, { bufnr, "Remove Workspace Folder" })
    map("n", "<leader>lwl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, { bufnr, "List Workspace Folders" })
  end,
}

return M
