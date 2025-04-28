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
  "gi",
  function()
    vim.lsp.buf.implementation()
  end,
  { desc = "LSP implementation"})
map("n",
  "gr",
  function ()
    vim.lsp.buf.references()
  end,
  { desc = "LSP references"})
map("n",
  "<leader>/",
  function()
    require("Comment.api").toggle.linewise.current()
  end,
  { desc = "Toggle comment" }
)
-- Movement mapping
map("n",
  "<C-u>",
  "<C-u>zz")

map("n",
  "<C-d>",
  "<C-d>zz")

map("v",
  "J",
  ":m '>+1<CR>gv=gv",
  { desc = "Move selected line / block of text in visual mode down"}
)
map("v",
  "K",
  ":m '<-2<CR>gv=gv",
  { desc = "Move selected line / block of text in visual mode up"}
)

map("n",
  "<C-a>",
  function ()
    vim.lsp.buf.code_action()
  end)

--Obsidian
map("v",
  "<leader>ol",
  ":ObsidanLink",
  { desc = "Obsidian linking to existing file."})
