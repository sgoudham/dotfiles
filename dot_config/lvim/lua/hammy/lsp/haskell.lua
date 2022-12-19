local opts = {
  cmd = { "haskell-language-server-9.2.4", "--lsp" },
}

require("lvim.lsp.manager").setup("hls", opts)
