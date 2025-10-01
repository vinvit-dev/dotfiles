return {
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        build = 'make',

        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        -- pickers = {}
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      vim.keymap.set('n', '<leader>sg', function()
        builtin.live_grep {
          grep_open_files = false,
          prompt_title = 'Live Grep',
        }
      end, { desc = '[S]earch by [G]rep' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })

      -- PHPCS coding standard selector
      vim.keymap.set('n', '<leader>sp', function()
        local pickers = require 'telescope.pickers'
        local finders = require 'telescope.finders'
        local conf = require('telescope.config').values
        local actions = require 'telescope.actions'
        local action_state = require 'telescope.actions.state'

        -- Get available standards from phpcs -i
        local standards = {}
        local ok, handle = pcall(io.popen, '/Users/vinvit/.composer/vendor/bin/phpcs -i')
        if ok and handle then
          local result = handle:read '*a'
          handle:close()

          -- Parse the output to extract standards
          local standards_str = result:match 'The installed coding standards are (.+)'
          if standards_str then
            -- Remove trailing whitespace/newlines
            standards_str = standards_str:gsub('%s*\n.*', ''):gsub('^%s+', ''):gsub('%s+$', '')
            -- Replace 'and' with comma for consistent parsing
            standards_str = standards_str:gsub('%s+and%s+', ', ')
            -- Split by comma
            for standard in standards_str:gmatch '[^,]+' do
              standard = standard:gsub('^%s+', ''):gsub('%s+$', '') -- trim whitespace
              if standard ~= '' then
                table.insert(standards, standard)
              end
            end
          end
        end

        -- Fallback to default standards if phpcs failed or returned no standards
        if #standards == 0 then
          standards = { 'PSR12', 'PSR2', 'PSR1', 'Drupal', 'Squiz', 'PEAR', 'Zend' }
        end

        pickers
          .new({}, {
            prompt_title = 'Select PHPCS Coding Standard',
            finder = finders.new_table {
              results = standards,
              entry_maker = function(entry)
                return {
                  value = entry,
                  display = entry,
                  ordinal = entry,
                }
              end,
            },
            sorter = conf.generic_sorter {},
            attach_mappings = function(prompt_bufnr)
              actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                if selection then
                  vim.g.phpcs_standard = selection.value
                  print('PHPCS standard set to: ' .. vim.g.phpcs_standard)

                  -- Trigger linting with new standard
                  require('lint').try_lint()
                end
              end)
              return true
            end,
          })
          :find()
      end, { desc = '[S]elect [P]HPCS standard' })
    end,
  },
}
