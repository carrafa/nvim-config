-- Bootstrap lazy.nvim with error handling
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local clone_success = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_err_writeln("Failed to clone lazy.nvim: " .. clone_success)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Plugin setup
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
  -- Comment
  { "numToStr/Comment.nvim", opts = {} },

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
        vim.keymap.set("n", "]h", gs.next_hunk, { buffer = bufnr, desc = "Next Hunk" })
        vim.keymap.set("n", "[h", gs.prev_hunk, { buffer = bufnr, desc = "Prev Hunk" })
        vim.keymap.set({ "n", "v" }, "<leader>hs", gs.stage_hunk, { buffer = bufnr, desc = "Stage hunk" })
        vim.keymap.set({ "n", "v" }, "<leader>hr", gs.reset_hunk, { buffer = bufnr, desc = "Reset hunk" })
        vim.keymap.set("n", "<leader>hS", gs.stage_buffer, { buffer = bufnr, desc = "Stage buffer" })
        vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk, { buffer = bufnr, desc = "Undo stage hunk" })
        vim.keymap.set("n", "<leader>hR", gs.reset_buffer, { buffer = bufnr, desc = "Reset buffer" })
        vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { buffer = bufnr, desc = "Preview hunk" })
        vim.keymap.set("n", "<leader>hb", function() gs.blame_line({ full = true }) end, { buffer = bufnr, desc = "Blame line" })
        vim.keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { buffer = bufnr })
      end,
    }
  },
  -- Git commands wrapper
  {
    "tpope/vim-fugitive",
    cmd = { "G", "Git" },
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
          use_system_clipboard = false,
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

require("core.options")
require("core.keymaps")
require("core.autocmds")

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
require("lualine").setup({
  options = { theme = "gruvbox" },
  extensions = { "nvim-tree" }
})

-- Treesitter
require("nvim-treesitter.configs").setup({
  ensure_installed = { "lua", "vim", "javascript", "elixir", "html" },
  highlight = { enable = true },
})

-- Comment Toggle
require("Comment").setup({
  toggler = {
    line = "<Leader>/",
    block = "<Leader>?",
  },
  opleader = {
    line = "<Leader>/",
    block = "<Leader>?",
  },
})
