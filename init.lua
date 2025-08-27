-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require("lazy").setup({
  dev = {
    path = "/Users/carrafa/dev"
  },
  -- Base
  "tpope/vim-sensible",
  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup {}
    end,
  },
  -- Completion/LSP
  { "neoclide/coc.nvim", branch = "release", build = "coc#util#install()" },
  { "amiralies/coc-elixir", build = "yarn install && yarn prepack" },
  { "neovim/nvim-lspconfig" },
  -- Comment
  { "numToStr/Comment.nvim", opts = {} },

  -- Autocomplete
  { "hrsh7th/nvim-cmp", config = function()
    local cmp = require("cmp")
    cmp.setup({
      snippet = {
        expand = function(args)
          vim.fn["vsnip#anonymous"](args.body)
        end,
      },
      mapping = {
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      },
      sources = {
        { name = "nvim_lsp" },
        { name = "vsnip" },
        { name = "buffer" },
        { name = "path" },
      },
    })
  end },
  { "hrsh7th/cmp-nvim-lsp" },
  -- Snippets
  { "hrsh7th/cmp-vsnip" },
  { "hrsh7th/vim-vsnip" },
  -- TypeScript-specific enhancements
  { "pmizio/typescript-tools.nvim", dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" }, config = function()
    require("typescript-tools").setup({})
  end },

  -- AI
  require("plugins.aider"),

  -- Git signs and hunk operations
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        -- Navigation
        vim.keymap.set("n", "]h", gs.next_hunk, { buffer = bufnr, desc = "Next Hunk" })
        vim.keymap.set("n", "[h", gs.prev_hunk, { buffer = bufnr, desc = "Prev Hunk" })

        -- Actions
        vim.keymap.set({ "n", "v" }, "<leader>hs", gs.stage_hunk, { buffer = bufnr, desc = "Stage hunk" })
        vim.keymap.set({ "n", "v" }, "<leader>hr", gs.reset_hunk, { buffer = bufnr, desc = "Reset hunk" })
        vim.keymap.set("n", "<leader>hS", gs.stage_buffer, { buffer = bufnr, desc = "Stage buffer" })
        vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk, { buffer = bufnr, desc = "Undo stage hunk" })
        vim.keymap.set("n", "<leader>hR", gs.reset_buffer, { buffer = bufnr, desc = "Reset buffer" })
        vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { buffer = bufnr, desc = "Preview hunk" })
        vim.keymap.set("n", "<leader>hb", function() gs.blame_line({ full = true }) end, { buffer = bufnr, desc = "Blame line" })

        -- Text object
        vim.keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { buffer = bufnr })
      end,
    }
  },
  -- Git commands wrapper
  {
    "tpope/vim-fugitive",
    cmd = { "G", "Git" }, -- Lazy-load on commands
    keys = {
      { "<leader>gs", "<cmd>Git<CR>", desc = "Git status" },
      { "<leader>gc", "<cmd>Git commit<CR>", desc = "Git commit" },
      { "<leader>gp", "<cmd>Git push<CR>", desc = "Git push" },
      { "<leader>gl", "<cmd>Git pull<CR>", desc = "Git pull" },
      { "<leader>gd", "<cmd>Gdiffsplit<CR>", desc = "Git diff" },
      { "<leader>gb", "<cmd>Git blame<CR>", desc = "Git blame" },
    },
  },
  -- Linting
  "dense-analysis/ale",
  -- Statusline
  { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = { width = 30, side = "left" },
        actions = {
          change_dir = { enable = true },
          use_system_clipboard = false, -- Disable system clipboard for y/p
        },
      })
    end,
  },
  -- Undo
  "mbbill/undotree",
  keys = {
    { "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "Toggle Undotree" },
  },
  -- Colorschemes
  "morhetz/gruvbox",
  "tomasr/molokai",
  "sjl/badwolf",
  "altercation/vim-colors-solarized",
  { "catppuccin/nvim", name = "catppuccin" },
  { "folke/tokyonight.nvim", name = "tokyonight", lazy = false, priority = 1000, opts = {} },
  -- Extras: Treesitter for better highlighting
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
})

-- General settings
vim.opt.hidden = true
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.textwidth = 500
vim.opt.ignorecase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ttyfast = true
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.showmatch = true
vim.opt.laststatus = 3

-- UI and colors
vim.opt.background = "dark"
vim.cmd.colorscheme("gruvbox")
vim.g.gruvbox_contrast_light = "hard"
vim.g.solarized_termcolors = 256
vim.g.rehash256 = 1

-- Mappings for toggle and changers
vim.keymap.set("n", "<Leader>bg", function() vim.opt.background = (vim.opt.background:get() == "dark" and "light" or "dark") end)
vim.keymap.set("n", "<leader>mg", ":colorscheme gruvbox<CR>")
vim.keymap.set("n", "<leader>mm", ":colorscheme molokai<CR>")
vim.keymap.set("n", "<leader>mb", ":colorscheme badwolf<CR>")

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- Other mappings
vim.keymap.set("n", "<leader>w", ":w!<CR>")

-- Autocmds
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
      vim.cmd("normal! g`\"")
    end
  end,
})

-- Plugin configs
-- ALE
vim.g.ale_fixers = { elixir = { "mix_format" } }
vim.g.ale_linters = {
  javascript = { "eslint" },
  typescript = { "eslint" },
  html = { "tidy" },
}
vim.g.ale_html_tidy_options = "-q --show-warnings no"
vim.g.ale_sign_error = "✘"
vim.g.ale_sign_warning = "⚠"
vim.g.ale_fix_on_save = 1

-- Lualine setup
require("lualine").setup({ extensions = { "nvim-tree" } })

-- Nvim-tree keybindings
vim.keymap.set('n', '<C-t>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>t', ':NvimTreeFocus<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-w>', '<C-w>w', { noremap = true, silent = true })

-- Treesitter
require("nvim-treesitter.configs").setup({
  ensure_installed = { "lua", "vim", "javascript", "elixir", "html" },
  highlight = { enable = true },
})

-- Coc

-- Use <Tab> and <S-Tab> for autocomplete navigation
vim.api.nvim_set_keymap("i", "<Tab>", "pumvisible() ? '<C-n>' : '<Tab>'", { expr = true, noremap = true })
vim.api.nvim_set_keymap("i", "<S-Tab>", "pumvisible() ? '<C-p>' : '<S-Tab>'", { expr = true, noremap = true })

-- Go to definition
vim.api.nvim_set_keymap("n", "gd", "<Plug>(coc-definition)", { silent = true })
vim.api.nvim_set_keymap("n", "gr", "<Plug>(coc-references)", { silent = true })
vim.api.nvim_set_keymap("n", "K", ":call CocAction('doHover')<CR>", { silent = true })

-- files
-- Copy full path to clipboard
vim.keymap.set("n", "<Leader>cp", ":let @+ = expand('%:p')<CR>", { noremap = true, silent = true })
-- Copy relative path to clipboard
vim.keymap.set("n", "<Leader>cr", ":let @+ = expand('%')<CR>", { noremap = true, silent = true })
-- Copy file name to clipboard
vim.keymap.set("n", "<Leader>cf", ":let @+ = expand('%:t')<CR>", { noremap = true, silent = true })

-- magenta file search
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'magenta*',  -- Adjust pattern if needed (check with :echo &ft in the buffer)
  callback = function()
    require('cmp').setup.buffer({
      mapping = {
        -- Put your Tab mappings here for buffer-local
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
      }
    })
  end
})

-- Comment Toggle
require("Comment").setup({
  toggler = {
    line = "<Leader>/", -- Line-comment toggle
    block = "<Leader>?", -- Block-comment toggle
  },
  opleader = {
    line = "<Leader>/", -- Line-comment in visual mode
    block = "<Leader>?", -- Block-comment in visual mode
  },
})

-- Syntax/filetype
vim.cmd("syntax enable")
vim.cmd("filetype plugin indent on")
