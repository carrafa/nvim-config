-- Autocmds
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
      vim.cmd("normal! g`\"")
    end
  end,
})

-- Magenta file search (custom)
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'magenta*',
  callback = function()
    require('cmp').setup.buffer({
      mapping = {
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
      }
    })
  end
})

-- Syntax and filetype
vim.cmd("syntax enable")
vim.cmd("filetype plugin indent on")
