local M = {}

local fmt = string.format
-- local fn = vim.fn
M.is_work = vim.env.WORK ~= nil
M.is_home = not M.is_work

---A thin wrapper around vim.notify to add packer details to the message
---@param msg string
function M.packer_notify(msg, level)
  vim.notify(msg, level, { title = 'Packer' })
end

function M.not_headless()
  return #vim.api.nvim_list_uis() > 0
end

---Require a plugin config
---@param name string
---@return any
function M.conf(name)
  return require(fmt('plugins.%s', name))
end

return M
