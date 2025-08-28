-- Keymappings
vim.keymap.set("n", "<Leader>bg", function() vim.opt.background = (vim.opt.background:get() == "dark" and "light" or "dark") end, { desc = "Toggle background" })
vim.keymap.set("n", "<leader>mg", ":colorscheme gruvbox<CR>", { desc = "Set gruvbox" })
vim.keymap.set("n", "<leader>mm", ":colorscheme molokai<CR>", { desc = "Set molokai" })
vim.keymap.set("n", "<leader>mb", ":colorscheme catppuccin<CR>", { desc = "Set catppuccin" })
vim.keymap.set("n", "<leader>mn", ":colorscheme tokyonight<CR>", { desc = "Set tokyonight" })
vim.keymap.set("n", "<leader>q", ":qa!<CR>", { desc = "Quit Neovim" })  -- New: Added quit mapping

-- Telescope mappings
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- Other mappings
vim.keymap.set("n", "<leader>w", ":w!<CR>", { desc = "Force write" })

-- Nvim-tree keybindings
vim.keymap.set('n', '<C-t>', ':NvimTreeToggle<CR>', { noremap = true, silent = true, desc = "Toggle NvimTree" })
vim.keymap.set('n', '<leader>t', ':NvimTreeFocus<CR>', { noremap = true, silent = true, desc = "Focus NvimTree" })
vim.keymap.set('n', '<C-w>', '<C-w>w', { noremap = true, silent = true, desc = "Cycle windows" })

-- Coc
vim.api.nvim_set_keymap("i", "<Tab>", "pumvisible() ? '<C-n>' : '<Tab>'", { expr = true, noremap = true })
vim.api.nvim_set_keymap("i", "<S-Tab>", "pumvisible() ? '<C-p>' : '<S-Tab>'", { expr = true, noremap = true })
vim.api.nvim_set_keymap("n", "gd", "<Plug>(coc-definition)", { silent = true })
vim.api.nvim_set_keymap("n", "gr", "<Plug>(coc-references)", { silent = true })
vim.api.nvim_set_keymap("n", "K", ":call CocAction('doHover')<CR>", { silent = true })

-- File operations
vim.keymap.set("n", "<Leader>cp", ":let @+ = expand('%:p')<CR>", { noremap = true, silent = true, desc = "Copy full path" })
vim.keymap.set("n", "<Leader>cr", ":let @+ = expand('%')<CR>", { noremap = true, silent = true, desc = "Copy relative path" })
vim.keymap.set("n", "<Leader>cf", ":let @+ = expand('%:t')<CR>", { noremap = true, silent = true, desc = "Copy filename" })
