require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("v", "<", "<gv", { desc = "Indent Line" })
map("v", ">", ">gv", { desc = "Indent Line" })
map("n",
  "gD",
  function ()
    vim.lsp.buf.declaration()
  end,
  { desc = "LSP declaration" }
)
map("n",
  "gd",
  function ()
    vim.lsp.buf.definition()
  end,
  { desc = "LSP definition" }
)
map("n",
  "<leader>/",
  function()
    require("Comment.api").toggle.linewise.current()
  end,
  { desc = "Toggle comment" }
)
