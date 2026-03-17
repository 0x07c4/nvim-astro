return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      suggestion = { enabled = true, auto_trigger = true },
      panel = { enabled = false },
    },
  },

  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "zbirenbaum/copilot.lua",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = function(_, opts)
      opts = opts or {}

      -- CodeCompanion 的 Copilot adapter 需要能找到 token
      vim.env.CODECOMPANION_TOKEN_PATH = vim.fn.expand "~/.config"

      -- 统一指定默认交互都走 Copilot
      opts.interactions = vim.tbl_deep_extend("force", opts.interactions or {}, {
        chat = {
          adapter = "copilot",
        },
        inline = {
          adapter = "copilot",
        },
        cmd = {
          adapter = "copilot",
        },
      })

      -- 可选：给 copilot adapter 指定默认模型
      opts.adapters = opts.adapters or {}
      opts.adapters.copilot = function()
        return require("codecompanion.adapters").extend("copilot", {
          schema = {
            model = {
              default = "gpt-5 mini",
            },
          },
        })
      end

      opts.opts = vim.tbl_deep_extend("force", opts.opts or {}, {
        log_level = "DEBUG",
      })

      return opts
    end,
  },
}
