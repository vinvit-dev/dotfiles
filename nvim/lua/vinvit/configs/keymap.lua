-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- vim.keymap.set('i', 'jk', '<Esc>', { desc = 'Enter normal mode' })

-- Alt j and k to move between buffers.
vim.keymap.set('n', '<M-j>', '<cmd>bprevious<cr>', { desc = 'Previous buffer' })
vim.keymap.set('n', '<M-k>', '<cmd>bnext<cr>', { desc = 'Next buffer' })
