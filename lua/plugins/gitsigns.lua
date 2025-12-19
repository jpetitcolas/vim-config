return {
    "lewis6991/gitsigns.nvim",
    config = function()
        require("gitsigns").setup({
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },
            on_attach = function(bufnr)
                local gs = require("gitsigns")

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation between hunks
                map("n", "]c", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "]c", bang = true })
                    else
                        gs.nav_hunk("next")
                    end
                end, { desc = "Next hunk" })

                map("n", "[c", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "[c", bang = true })
                    else
                        gs.nav_hunk("prev")
                    end
                end, { desc = "Previous hunk" })

                -- Stage/unstage hunks
                map("n", "<leader>da", gs.stage_hunk, { desc = "Diff add (stage hunk)" })
                map("v", "<leader>da", function()
                    gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end, { desc = "Diff add (stage selected)" })
                map("n", "<leader>dA", gs.stage_buffer, { desc = "Diff add all (stage buffer)" })
                map("n", "<leader>du", gs.undo_stage_hunk, { desc = "Diff undo (unstage hunk)" })

                -- Reset hunks
                map("n", "<leader>dr", gs.reset_hunk, { desc = "Diff revert (reset hunk)" })
                map("v", "<leader>dr", function()
                    gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end, { desc = "Diff revert (reset selected)" })
                map("n", "<leader>dR", gs.reset_buffer, { desc = "Diff revert all (reset buffer)" })

                -- Preview and blame
                map("n", "<leader>dp", gs.preview_hunk, { desc = "Diff preview" })
                map("n", "<leader>db", function()
                    gs.blame_line({ full = true })
                end, { desc = "Diff blame" })
            end,
        })
    end,
}
