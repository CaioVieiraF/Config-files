local state = {
  floating = {
    buf = -1,
    win = -1,
  },
}

local function create_floating_window(opts)
  opts = opts or {}

  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)

  -- Calculate centered position
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  -- Create a new buffer (hidden and scratch)
  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true)
  end

  -- Define window options
  local opts = {
    style = 'minimal',
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    border = 'rounded',
  }

  -- Open the floating window
  local win = vim.api.nvim_open_win(buf, true, opts)

  return { buf = buf, win = win }
end

-- Function to toggle the window
local function float_terminal(cmd)
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = create_floating_window { buf = state.floating.buf }

    if vim.bo[state.floating.buf].buftype ~= 'terminal' then
      if cmd ~= nil then
        vim.cmd.term(cmd)
      else
        vim.cmd.term()
      end
    end
  else
    vim.api.nvim_win_hide(state.floating.win)
  end
end

return {
  vim.api.nvim_create_user_command('Floaterm', float_terminal(cmd), { cmd }),
  vim.keymap.set({ 'n', 't' }, '<space>tf', float_terminal, { desc = '[T]oggle [F]loating Terminal' }),
}
