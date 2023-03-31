-- https://sookocheff.com/post/vim/neovim-java-ide/ :bless:

vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4

local root_markers = { "gradlew", "mvnw", ".git", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)
local workspace_folder = os.getenv("HOME") .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

local config = require("lsp.java").make_jdtls_config(root_dir, workspace_folder)
require("jdtls").start_or_attach(config)
