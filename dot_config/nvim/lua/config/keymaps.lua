local keymap = vim.keymap.set

keymap("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
keymap("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
keymap("n", "<leader>nh", "<cmd>nohlsearch<cr>", { desc = "Clear highlight" })

keymap("n", "<leader>sv", "<cmd>vsplit<cr>", { desc = "Split vertical" })
keymap("n", "<leader>sh", "<cmd>split<cr>", { desc = "Split horizontal" })

keymap("n", "<C-h>", "<C-w>h", { desc = "Window left" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Window down" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Window up" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Window right" })
