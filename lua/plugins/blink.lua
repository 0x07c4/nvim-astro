return {
  "Saghen/blink.cmp",
  opts = {
    completion = {
      list = {
        selection = {
          preselect = true, -- 关键：自动选中第一个候选
          auto_insert = false,
        },
      },
    },
    keymap = {
      ["<Tab>"] = { "accept", "fallback" }, -- Tab 直接确认
      ["<CR>"] = { "fallback" }, -- Enter 只换行
    },
  },
}
