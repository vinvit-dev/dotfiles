-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Set filetype for Drupal files
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  desc = 'Set filetype for Drupal files',
  group = vim.api.nvim_create_augroup('drupal-filetype', { clear = true }),
  pattern = { '*.module', '*.theme', '*.inc', '*.install', '*.profile' },
  callback = function()
    vim.bo.filetype = 'php'
  end,
})
