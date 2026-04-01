return {
  {
    "brenton-leighton/multiple-cursors.nvim",
    cmd = {
      "MultipleCursorsAddDown",
      "MultipleCursorsAddUp",
      "MultipleCursorsMouseAddDelete",
      "MultipleCursorsAddMatches",
      "MultipleCursorsAddMatchesV",
      "MultipleCursorsAddJumpNextMatch",
      "MultipleCursorsJumpNextMatch",
      "MultipleCursorsLock",
    },
    keys = {
      {
        "<C-d>",
        "<Cmd>MultipleCursorsAddJumpNextMatch<CR>",
        mode = { "n", "x" },
        desc = "Add cursor at next match",
      },
      {
        "<Leader>m",
        mode = { "n", "x" },
        desc = "Multi-cursor",
      },
      {
        "<Leader>ma",
        "<Cmd>MultipleCursorsAddMatches<CR>",
        mode = "n",
        desc = "Add cursors to all matches",
      },
      {
        "<Leader>ma",
        "<Cmd>MultipleCursorsAddMatchesV<CR>",
        mode = "x",
        desc = "Add cursors to all matches in selection",
      },
      {
        "<Leader>mj",
        "<Cmd>MultipleCursorsAddDown<CR>",
        mode = { "n", "i" },
        desc = "Add cursor down",
      },
      {
        "<Leader>mk",
        "<Cmd>MultipleCursorsAddUp<CR>",
        mode = { "n", "i" },
        desc = "Add cursor up",
      },
      {
        "<Leader>ml",
        "<Cmd>MultipleCursorsLock<CR>",
        mode = { "n", "x" },
        desc = "Lock virtual cursors",
      },
    },
    opts = {},
  },
}
