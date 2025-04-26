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
