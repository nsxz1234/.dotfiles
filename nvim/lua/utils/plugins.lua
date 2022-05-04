local M = {}

local fmt = string.format
-- local fn = vim.fn
M.is_work = vim.env.WORK ~= nil
M.is_home = not M.is_work

---Require a plugin config
---@param name string
---@return any
function M.conf(name)
  return require(fmt('plugins.%s', name))
end

return M
