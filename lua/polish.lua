-- if true then return end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

local function patch_treesitter_query(lang, query_name, unsupported_tokens)
  local ok, info = pcall(vim.treesitter.language.inspect, lang)
  if not ok or not info then return end

  local symbols = info.symbols or {}
  local missing = {}
  for _, token in ipairs(unsupported_tokens) do
    if not symbols[("%q"):format(token)] then table.insert(missing, token) end
  end
  if vim.tbl_isempty(missing) then return end

  local query_files = vim.api.nvim_get_runtime_file(("queries/%s/%s.scm"):format(lang, query_name), true)
  local query_file = query_files[1]
  if not query_file then return end

  local lines = vim.fn.readfile(query_file)
  local filtered = {}
  local changed = false

  for _, line in ipairs(lines) do
    local skip = false
    for _, token in ipairs(missing) do
      if line:find(("%q"):format(token), 1, true) then
        skip = true
        changed = true
        break
      end
    end
    if not skip then table.insert(filtered, line) end
  end

  if changed then vim.treesitter.query.set(lang, query_name, table.concat(filtered, "\n")) end
end

patch_treesitter_query("python", "highlights", { "except*" })

-- remove comment mapping
pcall(vim.keymap.del, "n", "<leader>/")

-- bind grep
vim.keymap.set("n", "<leader>/", function() require("snacks").picker.grep() end, { desc = "Grep" })
