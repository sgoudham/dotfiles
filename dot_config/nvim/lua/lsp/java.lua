local M = {}

local HOME = os.getenv("HOME")
local SDKMAN_DIR = os.getenv("SDKMAN_DIR")
local lsp = require("lsp")
local jdtls = require("jdtls")

-- File types that signify a Java project's root directory. This will be
-- used by eclipse to determine what constitutes a workspace
local root_markers = { "gradlew", "mvnw", ".git" }
local root_dir = require("jdtls.setup").find_root(root_markers)

-- eclipse.jdt.ls stores project specific data within a folder. If you are working
-- with multiple different projects, each project must use a dedicated data directory.
-- This variable is used to configure eclipse to use the directory name of the
-- current project found using the root_marker as the folder for project specific data.
local workspace_folder = HOME .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

-- Helper function for creating keymaps
function nnoremap(rhs, lhs, bufopts, desc)
  bufopts.desc = desc
  vim.keymap.set("n", rhs, lhs, bufopts)
end

-- The on_attach function is used to set key maps after the language server
-- attaches to the current buffer
local on_attach = function(client, bufnr)
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
end

local config = {
  flags = {
    debounce_text_changes = 80,
  },
  on_attach = on_attach, -- We pass our on_attach keybindings to the configuration map
  root_dir = root_dir, -- Set the root directory to our found root_marker
  -- Here you can configure eclipse.jdt.ls specific settings
  -- These are defined by the eclipse.jdt.ls project and will be passed to eclipse when starting.
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
      format = {
        settings = {
          -- Use Google Java style guidelines for formatting
          -- To use, make sure to download the file from https://github.com/google/styleguide/blob/gh-pages/eclipse-java-google-style.xml
          -- and place it in the ~/.local/share/eclipse directory
          url = "/.local/share/eclipse/eclipse-java-google-style.xml",
          profile = "GoogleStyle",
        },
      },
      implementationsCodeLens = { enabled = true },
      referenceCodeLens = { enabled = true },
      signatureHelp = { enabled = true },
      contentProvider = { preferred = "fernflower" }, -- Use fernflower to decompile library code
      -- Specify any completion options
      completion = {
        maxResults = 20,
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
      -- Specify any options for organizing imports
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      -- On Save Cleanup
      cleanup = {
        actionsOnSave = {
          "addOverride",
          "qualifyStaticMembers",
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
      -- If you are developing in projects with different Java versions, you need
      -- to tell eclipse.jdt.ls to use the location of the JDK for your Java version
      -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
      -- And search for `interface RuntimeOption`
      -- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
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
  -- cmd is the command that starts the language server. Whatever is placed
  -- here is what is passed to the command line to execute jdtls.
  -- Note that eclipse.jdt.ls must be started with a Java version of 17 or higher
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  -- for the full list of options
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

    -- The jar file is located where jdtls was installed. This will need to be updated
    -- to the location where you installed jdtls
    "-jar",
    -- HOME .. "/.local/share/eclipse.jdt.ls/bin",
    vim.fn.glob(HOME .. "/.local/share/eclipse.jdt.ls/plugins/org.eclipse.equinox.launcher_*.jar"),

    -- The configuration for jdtls is also placed where jdtls was installed. This will
    -- need to be updated depending on your environment
    "-configuration",
    HOME .. "/.local/share/eclipse.jdt.ls/config_linux",

    -- Use the workspace_folder defined above to store data for this project
    "-data",
    workspace_folder,
  },
}

function M.make_jdtls_config()
  return config
end

return M
