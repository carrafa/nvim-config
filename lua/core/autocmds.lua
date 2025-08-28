-- Autocmds
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
      vim.cmd("normal! g`\"")
    end
  end,
})

-- Magenta file search (custom) - Adjusted to remove cmp reference; using Coc for completion if needed
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'magenta*',
  callback = function()
    -- Completion handled by Coc; no additional setup needed
  end
})

-- Syntax and filetype
vim.cmd("syntax enable")
vim.cmd("filetype plugin indent on")
