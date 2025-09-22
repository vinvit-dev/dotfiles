-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  vim.keymap.set('i', 'jk', '<Esc>'),

  require 'custom.plugins.nvim-tmux-nabigation',
  require 'custom.plugins.transparent',
  require 'custom.plugins.catppuccin',
}
