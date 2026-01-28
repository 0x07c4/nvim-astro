-- if true then return end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- remove comment mapping
pcall(vim.keymap.del, "n", "<leader>/")

-- bind grep
vim.keymap.set("n", "<leader>/", function() require("snacks").picker.grep() end, { desc = "Grep" })
