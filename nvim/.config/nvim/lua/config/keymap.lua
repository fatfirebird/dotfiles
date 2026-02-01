local harpoon = require("harpoon")
local fzf = require("fzf-lua")

-- FZF
vim.keymap.set("n", "<leader>p", fzf.files, { desc = "FZF find files" })
vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "FZF find files (2)" })
vim.keymap.set("n", "<leader>fg", fzf.live_grep, { desc = "FZF live grep" })
vim.keymap.set("n", "<leader>fb", fzf.buffers, { desc = "FZF buffers" })
vim.keymap.set("n", "<leader>fc", fzf.commands, { desc = "FZF find command" })
vim.keymap.set("n", "<leader>fs", fzf.blines, { desc = "Fuzzy find in current buffer" })
vim.keymap.set("n", "<leader>fy", fzf.registers, { desc = "Fuzzy find registers" })

-- Neotree file
vim.keymap.set("n", "<leader>b", ":Neotree filesystem reveal toggle left<CR>", { desc = "Neotree open left" })

-- Navigate between windows
vim.keymap.set("n", "<leader-h>", "<C-w>h", { desc = "Move to left split" })
vim.keymap.set("n", "<leader-j>", "<C-w>j", { desc = "Move to split below" })
vim.keymap.set("n", "<leader-k>", "<C-w>k", { desc = "Move to split above" })
vim.keymap.set("n", "<leader-l>", "<C-w>l", { desc = "Move to right split" })

-- Create windows
vim.keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split vertically" })
vim.keymap.set("n", "<leader>wh", "<C-w>s", { desc = "Split horizontally" })
vim.keymap.set("n", "<leader>ws", "<C-w>v", { desc = "Split horizontally" })
vim.keymap.set("n", "<leader>we", "<C-w>=", { desc = "Make splits equal size" })
vim.keymap.set("n", "<leader>wx", ":close<CR>", { desc = "Close current split" })
vim.keymap.set("n", "<leader>wr", "<C-w>r", { desc = "Rotate splits" })


-- Create tabs
vim.keymap.set("n", "<leader>tn", ":tabnew<CR>", { desc = "New tab" })
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>", { desc = "Close current tab" })
vim.keymap.set("n", "<leader>tx", ":tabclose<CR>", { desc = "Close current tab" })
vim.keymap.set("n", "<leader>tl", ":tabnext<CR>", { desc = "Next tab" })
vim.keymap.set("n", "<leader>th", ":tabprevious<CR>", { desc = "Previous tab" })
vim.keymap.set("n", "<leader>t1", "1gt", { desc = "Go to tab 1" })
vim.keymap.set("n", "<leader>t2", "2gt", { desc = "Go to tab 2" })
vim.keymap.set("n", "<leader>t3", "3gt", { desc = "Go to tab 3" })
vim.keymap.set("n", "<leader>t4", "4gt", { desc = "Go to tab 4" })
vim.keymap.set("n", "<leader>t5", "5gt", { desc = "Go to tab 5" })

-- Move lines like in vscode
vim.keymap.set("n", "<A-j>", ":move .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":move .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":move '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":move '<-2<CR>gv=gv", { desc = "Move selection up" })

vim.keymap.set("n", "<C-s>", ":w<CR>", { desc = "Save file" })

-- Harpoon
vim.keymap.set("n", "<leader>hm", function()
  harpoon:list():add()
end, { desc = "Harpoon file" })
vim.keymap.set("n", "<leader>hf", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon menu" })
vim.keymap.set("n", "<leader>1", function()
  harpoon:list():select(1)
end, { desc = "Harpoon file 1" })
vim.keymap.set("n", "<leader>2", function()
  harpoon:list():select(2)
end, { desc = "Harpoon file 2" })
vim.keymap.set("n", "<leader>3", function()
  harpoon:list():select(3)
end, { desc = "Harpoon file 3" })
vim.keymap.set("n", "<leader>4", function()
  harpoon:list():select(4)
end, { desc = "Harpoon file 4" })
vim.keymap.set("n", "<leader>5", function()
  harpoon:list():select(5)
end, { desc = "Harpoon file 5" })
vim.keymap.set("n", "<leader>hp", function()
  harpoon:list():prev()
end, { desc = "Previous harpoon file" })
vim.keymap.set("n", "<leader>hn", function()
  harpoon:list():next()
end, { desc = "Next harpoon file" })

-- tmux navigator
vim.keymap.set("n", "<c-h>", ":TmuxNavigateLeft<cr>", { desc = "tmux navigator left" })
vim.keymap.set("n", "<c-j>", ":TmuxNavigateDown<cr>", { desc = "tmux navigator down" })
vim.keymap.set("n", "<c-k>", ":TmuxNavigateUp<cr>", { desc = "tmux navigator up" })
vim.keymap.set("n", "<c-l>", ":TmuxNavigateRight<cr>", { desc = "tmux navigator right" })
vim.keymap.set("n", "<c-\\>", ":TmuxNavigatePrevious<cr>", { desc = "tmux navigator previous" })

-- Terminal
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- oil
vim.keymap.set("n", "-", ":Oil --float<CR>", { desc = "Oil" })

-- Use LspAttach autocommand to only map the following keys
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }

    -- Lsp go to X
    vim.keymap.set("n", "gi", fzf.lsp_implementations, opts)
    vim.keymap.set("n", "gd", fzf.lsp_definitions, opts)
    vim.keymap.set("n", "gi", fzf.lsp_incoming_calls, opts)
    vim.keymap.set("n", "go", fzf.lsp_outgoing_calls, opts)
    vim.keymap.set("n", "gr", fzf.lsp_references, opts)
    vim.keymap.set("n", "<leader>fr", fzf.lsp_references, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)

    -- Diagnostics
    vim.keymap.set("n", "<leader>d", "<cmd>FzfLua diagnostics_document<CR>", opts)
    vim.keymap.set("n", "D", vim.diagnostic.open_float, opts) -- show diagnostics for line

    -- Workspaces
    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)

    -- Other
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<leader>.", vim.lsp.buf.code_action, opts)

    -- format
    vim.keymap.set("n", "<leader>f", function()
      require("conform").format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
      })
    end, opts)
  end,
})

-- Flash
vim.keymap.set({ "n", "x", "o" }, "s", function()
  require("flash").jump()
end, { desc = "Flash" })
vim.keymap.set({ "n", "x", "o" }, "S", function()
  require("flash").treesitter()
end, { desc = "Flash Treesitter" })
vim.keymap.set("o", "r", function()
  require("flash").remote()
end, { desc = "Remote Flash" })
vim.keymap.set({ "o", "x" }, "R", function()
  require("flash").treesitter_search()
end, { desc = "Treesitter Search" })
vim.keymap.set("c", "<c-s>", function()
  require("flash").toggle()
end, { desc = "Toggle Flash Search" })
