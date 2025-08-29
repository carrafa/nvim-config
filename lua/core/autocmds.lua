-- Autocmds
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
      vim.cmd("normal! g`\"")
    end
  end,
})

-- Magenta file search (custom) - Completion handled by nvim-cmp
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'magenta*',
  callback = function()
    -- Completion handled by nvim-cmp; no additional setup needed
  end
})

-- Aider terminal navigation mappings
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*',
  callback = function()
    if vim.bo.buftype == 'terminal' and vim.fn.bufname():match('aider') then
      vim.keymap.set('t', '<C-h>', '<C-\\><C-n><C-w>h', { buffer = true, desc = 'Move to left window' })
      vim.keymap.set('t', '<C-j>', '<C-\\><C-n><C-w>j', { buffer = true, desc = 'Move to bottom window' })
      vim.keymap.set('t', '<C-k>', '<C-\\><C-n><C-w>k', { buffer = true, desc = 'Move to top window' })
      vim.keymap.set('t', '<C-l>', '<C-\\><C-n><C-w>l', { buffer = true, desc = 'Move to right window' })
    end
  end
})

-- Syntax and filetype
vim.cmd("syntax enable")
vim.cmd("filetype plugin indent on")
