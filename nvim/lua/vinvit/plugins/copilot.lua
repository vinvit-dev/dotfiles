return {
  {
    'zbirenbaum/copilot.lua',
    dependencies = {
      'copilotlsp-nvim/copilot-lsp', -- (optional) for NES functionality
    },
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {
        suggestion = {
          enabled = true,
          auto_triger = true,
          accept = false,
        },
        nes = {
          enabled = true,
          keymap = {
            accept_and_goto = '<leader>p',
            accept = false,
            dismiss = '<Esc>',
          },
        },
      }
    end,
  },
}
