vim.g.mapleader = " "
vim.keymap.set("n", "<leader>fd", vim.cmd.Ex)

vim.keymap.set("n", "<C-s>", vim.cmd.w)

-- jumping between windows
vim.api.nvim_set_keymap("t", "<A-h>", "<C-\\><C-N><C-w>h", { noremap = true })
vim.api.nvim_set_keymap("t", "<A-j>", "<C-\\><C-N><C-w>j", { noremap = true })
vim.api.nvim_set_keymap("t", "<A-k>", "<C-\\><C-N><C-w>k", { noremap = true })
vim.api.nvim_set_keymap("t", "<A-l>", "<C-\\><C-N><C-w>l", { noremap = true })

vim.api.nvim_set_keymap("i", "<A-h>", "<C-\\><C-N><C-w>h", { noremap = true })
vim.api.nvim_set_keymap("i", "<A-j>", "<C-\\><C-N><C-w>j", { noremap = true })
vim.api.nvim_set_keymap("i", "<A-k>", "<C-\\><C-N><C-w>k", { noremap = true })
vim.api.nvim_set_keymap("i", "<A-l>", "<C-\\><C-N><C-w>l", { noremap = true })

vim.api.nvim_set_keymap("n", "<A-h>", "<C-w>h", { noremap = true })
vim.api.nvim_set_keymap("n", "<A-j>", "<C-w>j", { noremap = true })
vim.api.nvim_set_keymap("n", "<A-k>", "<C-w>k", { noremap = true })
vim.api.nvim_set_keymap("n", "<A-l>", "<C-w>l", { noremap = true })
--

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

--vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
