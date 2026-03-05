return {
  {
    "nvim-pack/nvim-spectre",
    opts = {
      open_cmd = "noswapfile vnew",
      live_update = false,
      is_insert_mode = false,
    },
    keys = {
      {
        "<leader>sw",
        function() require("spectre").open_visual { select_word = true } end,
        mode = "n",
        desc = "Spectre (current word)",
      },
    },
  },
}
