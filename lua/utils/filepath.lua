local M = {}

local labels = {
  relative = "Relative Path",
  absolute = "Absolute Path",
  home = "Home Path",
  filename = "Filename",
}

local function buffer_path(bufnr)
  local path = vim.api.nvim_buf_get_name(bufnr or 0)
  if path == "" then return nil end
  return vim.fs.normalize(path)
end

local function clipboard_set(value)
  vim.fn.setreg("+", value)
  vim.fn.setreg('"', value)
end

function M.values(bufnr)
  local path = buffer_path(bufnr)
  if not path then return nil end

  return {
    relative = vim.fn.fnamemodify(path, ":."),
    absolute = path,
    home = vim.fn.fnamemodify(path, ":~"),
    filename = vim.fn.fnamemodify(path, ":t"),
  }
end

function M.copy(kind, bufnr)
  local values = M.values(bufnr)
  if not values then
    vim.notify("Current buffer has no file path", vim.log.levels.WARN)
    return
  end

  local value = values[kind]
  if not value or value == "" then
    vim.notify("No path available to copy", vim.log.levels.WARN)
    return
  end

  clipboard_set(value)
  vim.notify(("Copied %s: %s"):format(labels[kind] or "value", value))
  return value
end

function M.select(bufnr, kinds)
  local values = M.values(bufnr)
  if not values then
    vim.notify("Current buffer has no file path", vim.log.levels.WARN)
    return
  end

  local items = {}
  for _, kind in ipairs(kinds or { "relative", "absolute", "home", "filename" }) do
    if values[kind] and values[kind] ~= "" then table.insert(items, kind) end
  end

  vim.ui.select(items, {
    prompt = "Copy path to clipboard:",
    format_item = function(item) return ("%s: %s"):format(labels[item], values[item]) end,
  }, function(choice)
    if choice then M.copy(choice, bufnr) end
  end)
end

return M
