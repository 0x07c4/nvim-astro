local function with_selected_dir(state, callback)
  local node = state.tree and state.tree:get_node()
  if not node then return end

  local path = node.type == "file" and node:get_parent_id() or node:get_id()
  if path then callback(path) end
end

local function dir_title(prefix, path)
  return ("%s %s"):format(prefix, vim.fn.fnamemodify(path, ":~:."))
end

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      opts = opts or {}
      opts.use_popups_for_input = true
      opts.popup_border_style = "rounded"

      opts.commands = opts.commands or {}
      opts.commands.find_words_in_dir = function(state)
        with_selected_dir(state, function(path)
          require("snacks").picker.grep {
            cwd = path,
            title = dir_title("Search in", path),
          }
        end)
      end
      opts.commands.find_all_words_in_dir = function(state)
        with_selected_dir(state, function(path)
          require("snacks").picker.grep {
            cwd = path,
            hidden = true,
            ignored = true,
            title = dir_title("Search in (all)", path),
          }
        end)
      end

      opts.filesystem = opts.filesystem or {}
      opts.filesystem.window = opts.filesystem.window or {}
      opts.filesystem.window.mappings = opts.filesystem.window.mappings or {}
      opts.filesystem.window.mappings["<leader>/"] = "find_words_in_dir"
      opts.filesystem.window.mappings["<leader>?"] = "find_all_words_in_dir"

      return opts
    end,
  },
}
