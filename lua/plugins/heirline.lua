return {
  {
    "rebelot/heirline.nvim",
    opts = function(_, opts)
      local status = require "astroui.status"

      opts.winbar = {
        init = function(self) self.bufnr = vim.api.nvim_get_current_buf() end,
        status.component.separated_path {
          max_depth = 0,
          path_func = function(self)
            local path = vim.api.nvim_buf_get_name(self.bufnr)
            if path == "" then return "" end
            return vim.fn.fnamemodify(vim.fs.normalize(path), ":~:.:h")
          end,
        },
        status.component.file_info {
          file_icon = {
            hl = function(self) return status.hl.file_icon("winbar")(self) end,
            padding = { left = 0 },
          },
          filename = {},
          filetype = false,
          file_read_only = false,
          surround = false,
          hl = function() return status.hl.get_attributes("winbar", true) end,
          update = { "BufEnter", "BufFilePost" },
        },
        status.component.fill(),
        status.component.breadcrumbs {
          hl = function() return status.hl.get_attributes("winbar", true) end,
        },
      }

      return opts
    end,
  },
}
