local fn = vim.fn
local api = vim.api
local fmt = string.format
local l = vim.log.levels

--------------------------------------------------------------------------------
-- Utils
--------------------------------------------------------------------------------

--- Convert a list or map of items into a value by iterating all it's fields and transforming
--- them with a callback
---@generic T : table
---@param callback fun(T, T, key: string | number): T
---@param list T[]
---@param accum T?
---@return T
function as.fold(callback, list, accum)
  accum = accum or {}
  for k, v in pairs(list) do
    accum = callback(accum, v, k)
    assert(accum ~= nil, 'The accumulator must be returned on each iteration')
  end
  return accum
end

---@generic T : table
---@param callback fun(T, key: string | number)
---@param list T[]
function as.foreach(callback, list)
  for k, v in pairs(list) do
    callback(v, k)
  end
end

---@generic T : table
---@param callback fun(item: T, key: string | number, list: T[]): T
---@param list T[]
---@return T[]
function as.map(callback, list)
  return as.fold(function(accum, v, k)
    accum[#accum + 1] = callback(v, k, accum)
    return accum
  end, list, {})
end

---Find an item in a list
---@generic T
---@param matcher fun(arg: T):boolean
---@param haystack T[]
---@return T
function as.find(matcher, haystack)
  local found
  for _, needle in ipairs(haystack) do
    if matcher(needle) then
      found = needle
      break
    end
  end
  return found
end

function as.installed_plugins()
  local ok, lazy = pcall(require, 'lazy')
  if not ok then return 0 end
  return lazy.stats().count
end

---Check whether or not the location or quickfix list is open
---@return boolean
function as.is_vim_list_open()
  for _, win in ipairs(api.nvim_list_wins()) do
    local buf = api.nvim_win_get_buf(win)
    local location_list = fn.getloclist(0, { filewinid = 0 })
    local is_loc_list = location_list.filewinid > 0
    if vim.bo[buf].filetype == 'qf' or is_loc_list then return true end
  end
  return false
end

---Determine if a value of any type is empty
---@param item any
---@return boolean
function as.empty(item)
  if not item then return true end
  local item_type = type(item)
  if item_type == 'string' then return item == '' end
  if item_type == 'number' then return item <= 0 end
  if item_type == 'table' then return vim.tbl_isempty(item) end
  return item ~= nil
end

---Determine if a value of any type is empty
---@param item any
---@return boolean?
function as.falsy(item)
  if not item then return true end
  local item_type = type(item)
  if item_type == 'boolean' then return not item end
  if item_type == 'string' then return item == '' end
  if item_type == 'number' then return item <= 0 end
  if item_type == 'table' then return vim.tbl_isempty(item) end
  return item ~= nil
end

--- Call the given function and use `vim.notify` to notify of any errors
--- this function is a wrapper around `xpcall` which allows having a single
--- error handler for all errors
---@param msg string
---@param func function
---@param ... any
---@return boolean, any
---@overload fun(func: function, ...): boolean, any
function as.pcall(msg, func, ...)
  local args = { ... }
  if type(msg) == 'function' then
    local arg = func --[[@as any]]
    args, func, msg = { arg, unpack(args) }, msg, nil
  end
  return xpcall(func, function(err)
    msg = debug.traceback(msg and fmt('%s:\n%s', msg, err) or err)
    vim.schedule(function() vim.notify(msg, l.ERROR, { title = 'ERROR' }) end)
  end, unpack(args))
end

--- A convenience wrapper that calls the ftplugin config for a plugin if it exists
--- and warns me if the plugin is not installed
---@param configs table<string, fun(module: table)>
function as.ftplugin_conf(configs)
  if type(configs) ~= 'table' then return end
  for name, callback in pairs(configs) do
    local ok, plugin = as.pcall(require, name)
    if ok then callback(plugin) end
  end
end

----------------------------------------------------------------------------------------------------
-- API Wrappers
----------------------------------------------------------------------------------------------------
-- Thin wrappers over API functions to make their usage easier/terser

--- Validate the keys passed to as.augroup are valid
---@param name string
---@param cmd Autocommand
local function validate_autocmd(name, cmd)
  local keys = { 'event', 'buffer', 'pattern', 'desc', 'command', 'group', 'once', 'nested' }
  local incorrect = as.fold(function(accum, _, key)
    if not vim.tbl_contains(keys, key) then table.insert(accum, key) end
    return accum
  end, cmd, {})
  if #incorrect == 0 then return end
  vim.schedule(
    function()
      vim.notify('Incorrect keys: ' .. table.concat(incorrect, ', '), 'error', {
        title = fmt('Autocmd: %s', name),
      })
    end
  )
end

---@class AutocmdArgs
---@field id number
---@field event string
---@field group string?
---@field buf number
---@field file string
---@field match string | number
---@field data any

---@class Autocommand
---@field desc string
---@field event  string | string[] list of autocommand events
---@field pattern string | string[] list of autocommand patterns
---@field command string | fun(args: AutocmdArgs): boolean?
---@field nested  boolean
---@field once    boolean
---@field buffer  number

---Create an autocommand
---returns the group ID so that it can be cleared or manipulated.
---@param name string The name of the autocommand group
---@param ... Autocommand A list of autocommands to create
---@return number
function as.augroup(name, ...)
  local commands = { ... }
  assert(name ~= 'User', 'The name of an augroup CANNOT be User')
  assert(#commands > 0, fmt('You must specify at least one autocommand for %s', name))
  local id = api.nvim_create_augroup(name, { clear = true })
  for _, autocmd in ipairs(commands) do
    validate_autocmd(name, autocmd)
    local is_callback = type(autocmd.command) == 'function'
    api.nvim_create_autocmd(autocmd.event, {
      group = name,
      pattern = autocmd.pattern,
      desc = autocmd.desc,
      callback = is_callback and autocmd.command or nil,
      command = not is_callback and autocmd.command or nil,
      once = autocmd.once,
      nested = autocmd.nested,
      buffer = autocmd.buffer,
    })
  end
  return id
end

--- @class CommandArgs
--- @field args string
--- @field fargs table
--- @field bang boolean,

---Create an nvim command
---@param name any
---@param rhs string|fun(args: CommandArgs)
---@param opts table?
function as.command(name, rhs, opts)
  opts = opts or {}
  api.nvim_create_user_command(name, rhs, opts)
end

---A terser proxy for `nvim_replace_termcodes`
---@param str string
---@return string
function as.replace_termcodes(str) return api.nvim_replace_termcodes(str, true, true, true) end

---check if a certain feature/version/commit exists in nvim
---@param feature string
---@return boolean
function as.has(feature) return vim.fn.has(feature) > 0 end
