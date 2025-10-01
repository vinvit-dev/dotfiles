return {
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {},
    config = function()
      require('conform').setup {

        notify_on_error = false,
        format_on_save = function(bufnr)
          -- Disable "format_on_save lsp_fallback" for languages that don't
          -- have a well standardized coding style. You can add additional
          -- languages here or re-enable it for the disabled ones.
          local disable_filetypes = { c = true, cpp = true }
          if disable_filetypes[vim.bo[bufnr].filetype] then
            return nil
          else
            return {
              timeout_ms = 2000,
              lsp_format = 'fallback',
            }
          end
        end,
        formatters = {
          phpcbf = {
            command = '/Users/vinvit/.composer/vendor/bin/phpcbf',
            args = function()
              return { '--standard=' .. (vim.g.phpcs_standard or 'Drupal'), '$FILENAME' }
            end,
          },
        },
        formatters_by_ft = {
          lua = { 'stylua' },
          -- You can use 'stop_after_first' to run the first available formatter from the list
          javascript = { 'eslint_d', 'prettier' },
          typescript = { 'eslint_d', 'prettier' },
          typescriptreact = { 'eslint_d', 'prettier' },
          php = { 'phpcbf' },
        },
      }
    end,
  },
}
