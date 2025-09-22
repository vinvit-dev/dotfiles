return {
  {
    'xiyaowong/transparent.nvim',
    lazy = false,
    config = function()
      require('transparent').setup()
    end,

    keys = {
      { '<Space>t', ':TransparentToggle<CR>', desc = 'Toggle transparent', silent = true },
    },
  },
}
