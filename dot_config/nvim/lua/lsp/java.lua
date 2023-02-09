local M = {}

local HOME = os.getenv("HOME")
local SDKMAN_DIR = os.getenv("SDKMAN_DIR")
local lsp = require("lsp")
local jdtls = require("jdtls")

local bundles = {}
local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
vim.list_extend(bundles, vim.split(vim.fn.glob(mason_path .. "packages/java-test/extension/server/*.jar"), "\n"))
vim.list_extend(
  bundles,
  vim.split(
    vim.fn.glob(mason_path .. "packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"),
    "\n"
  )
)

local function nnoremap(rhs, lhs, bufopts, desc)
  bufopts.desc = desc
  vim.keymap.set("n", rhs, lhs, bufopts)
end

local on_attach = function(client, bufnr)
  require("jdtls").setup_dap({ hotcodereplace = "auto" })
  require("jdtls.dap").setup_dap_main_class_configs()
  require("jdtls.setup").add_commands()
  lsp.default_config.on_attach(client, bufnr)

  -- Regular Neovim LSP client keymappings
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  nnoremap("<leader>lwa", vim.lsp.buf.add_workspace_folder, bufopts, "Add workspace folder")
  nnoremap("<leader>lwr", vim.lsp.buf.remove_workspace_folder, bufopts, "Remove workspace folder")
  nnoremap("<leader>lwl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts, "List workspace folders")

  -- Java extensions provided by jdtls
  nnoremap("<leader>lo", jdtls.organize_imports, bufopts, "Organize imports")
  nnoremap("<leader>le", jdtls.extract_variable, bufopts, "Extract variable")
  nnoremap("<leader>lc", jdtls.extract_constant, bufopts, "Extract constant")
  vim.keymap.set(
    "v",
    "<leader>lm",
    [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]],
    { noremap = true, silent = true, buffer = bufnr, desc = "Extract method" }
  )
  nnoremap("<leader>tc", jdtls.test_class, bufopts, "Test class (DAP)")
  nnoremap("<leader>tm", jdtls.test_nearest_method, bufopts, "Test method (DAP)")
end

function M.make_jdtls_config(root_dir, workspace_folder)
  return {
    flags = {
      debounce_text_changes = 80,
      allow_incremental_sync = true,
    },
    on_attach = on_attach,
    root_dir = root_dir,
    init_options = {
      bundles = bundles,
    },

    -- https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    settings = {
      java = {
        format = {
          settings = {
            -- https://github.com/google/styleguide/blob/gh-pages/eclipse-java-google-style.xml
            url = "/.local/share/eclipse/eclipse-java-google-style.xml",
            profile = "GoogleStyle",
          },
        },
        contentProvider = { preferred = "fernflower" }, -- Use fernflower to decompile library code
        -- Specify any completion options
        completion = {
          maxResults = 30,
          postfix = { enabled = true },
          favoriteStaticMembers = {
            "org.hamcrest.MatcherAssert.assertThat",
            "org.hamcrest.Matchers.*",
            "org.hamcrest.CoreMatchers.*",
            "org.junit.jupiter.api.Assertions.*",
            "java.util.Objects.requireNonNull",
            "java.util.Objects.requireNonNullElse",
            "org.mockito.Mockito.*",
          },
          filteredTypes = {
            "com.sun.*",
            "io.micrometer.shaded.*",
            "java.awt.*",
            "jdk.*",
            "sun.*",
          },
        },
        -- LSP Related
        implementationsCodeLens = { enabled = true },
        referenceCodeLens = { enabled = true },
        signatureHelp = { enabled = true },
        inlayHints = {
          parameterNames = { enabled = true },
        },
        -- Specify any options for organizing imports
        sources = {
          organizeImports = {
            starThreshold = 9999,
            staticStarThreshold = 9999,
          },
        },
        maven = {
          downloadSources = true,
          updateSnapshots = true,
        },
        -- On Save Cleanup
        cleanup = {
          actionsOnSave = {
            "addOverride",
          },
        },
        -- How code generation should act
        codeGeneration = {
          toString = {
            template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
          },
          hashCodeEquals = {
            useJava7Objects = true,
          },
          useBlocks = true,
        },
        -- https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
        -- `interface RuntimeOption`
        configuration = {
          maven = {
            userSettings = HOME .. "/.m2/settings.xml",
          },
          runtimes = {
            {
              name = "JavaSE-17",
              path = SDKMAN_DIR .. "/candidates/java/17.0.5-amzn",
            },
            {
              name = "JavaSE-11",
              path = SDKMAN_DIR .. "/candidates/java/11.0.18-amzn",
            },
            {
              name = "JavaSE-1.8",
              path = SDKMAN_DIR .. "/candidates/java/8.0.362-amzn",
            },
          },
        },
      },
    },
    -- Note that eclipse.jdt.ls must be started with a Java version of 17 or higher
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    cmd = {
      SDKMAN_DIR .. "/candidates/java/17.0.5-amzn/bin/java",
      "-Declipse.application=org.eclipse.jdt.ls.core.id1",
      "-Dosgi.bundles.defaultStartLevel=4",
      "-Declipse.product=org.eclipse.jdt.ls.core.product",
      "-Dlog.protocol=true",
      "-Dlog.level=ALL",
      "-Xmx4g",
      "--add-modules=ALL-SYSTEM",
      "--add-opens",
      "java.base/java.util=ALL-UNNAMED",
      "--add-opens",
      "java.base/java.lang=ALL-UNNAMED",
      -- If you use lombok, download the lombok jar and place it in ~/.local/share/eclipse
      -- "-javaagent:"
      --   .. HOME
      --   .. "/.local/share/eclipse/lombok.jar",

      "-jar",
      vim.fn.glob(HOME .. "/.local/share/eclipse.jdt.ls/plugins/org.eclipse.equinox.launcher_*.jar"),

      "-configuration",
      HOME .. "/.local/share/eclipse.jdt.ls/config_linux",

      "-data",
      workspace_folder,
    },
  }
end

return M
