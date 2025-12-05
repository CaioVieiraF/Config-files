require 'kickstart.default'

-- Terminal configuration
-- This makes the terminal appear without line numbers
vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})
-- Some keymaps for the terminal
local job_id = 0
vim.keymap.set('n', '<space>tt', function()
  -- Opens the terminal
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd 'J'
  vim.api.nvim_win_set_height(0, 5)

  job_id = vim.bo.channel
end, { desc = '[T]oggle [T]erminal' })

vim.keymap.set('n', '<space>cr', function()
  -- Send the command 'cargo run'
  vim.fn.chansend(job_id, { 'cargo run\r\n' })
end, { desc = '[C]argo [R]un' })

-- Telescope
vim.keymap.set('n', '<space>df', require('telescope.builtin').find_files, { desc = 'Find project files' })

-- Fold scopes
-- local vim = vim
-- local opt = vim.opt
--
-- opt.foldmethod = 'expr'
-- opt.foldexpr = 'nvim_treesitter#foldexpr()'
--
-- -- Folding defaults to fold everything when you
-- -- open a new file, so we need to unfold it
-- local api = vim.api
-- local M = {}
--
-- -- function to create a list of commands and convert them to autocommands
-- -------- This function is taken from https://github.com/norcalli/nvim_utils
-- function M.nvim_create_augroups(definitions)
--   for group_name, definition in pairs(definitions) do
--     api.nvim_command('augroup ' .. group_name)
--     api.nvim_command 'autocmd!'
--     for _, def in ipairs(definition) do
--       local command = table.concat(vim.tbl_flatten { 'autocmd', def }, ' ')
--       api.nvim_command(command)
--     end
--     api.nvim_command 'augroup END'
--   end
-- end
--
-- local autoCommands = {
--   -- other autocommands
--   open_folds = {
--     { 'BufReadPost,FileReadPost', '*', 'normal zR' },
--   },
-- }
--
-- M.nvim_create_augroups(autoCommands)
