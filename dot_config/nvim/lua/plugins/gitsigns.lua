return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts, desc)
            opts = opts or {}
            opts.buffer = bufnr
            opts.desc = desc
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map("n", "]c", function()
            if vim.wo.diff then
              return "]c"
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return "<Ignore>"
          end, { expr = true }, "Next Hunk")

          map("n", "[c", function()
            if vim.wo.diff then
              return "[c"
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return "<Ignore>"
          end, { expr = true }, "Previous Hunk")

          -- Actions
          map({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>", {}, "Stage Hunk")
          map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>", {}, "Reset Hunk")
          map("n", "<leader>gS", gs.stage_buffer, {}, "Stage Buffer")
          map("n", "<leader>gu", gs.undo_stage_hunk, {}, "Undo Stage Hunk")
          map("n", "<leader>gR", gs.reset_buffer, {}, "Reset Buffer")
          map("n", "<leader>gp", gs.preview_hunk, {}, "Preview Hunk")
          map("n", "<leader>gb", function()
            gs.blame_line({ full = true })
          end, {}, "Show Blame")
          map("n", "<leader>gb", gs.toggle_current_line_blame, {}, "Current Line Blame")
          map("n", "<leader>gd", gs.diffthis, {}, "Diff This")
          map("n", "<leader>gD", function()
            gs.diffthis("~")
          end, {}, "")
          map("n", "<leader>gd", gs.toggle_deleted, {}, "Show Deleted")

          -- Text object
          map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
        end,
      })
    end,
  },
}
