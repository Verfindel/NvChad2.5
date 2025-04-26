require "nvchad.mappings"

local map = vim.keymap.set

-- vim tmux
map("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>", { desc = "Tmux navigate left"})
map("n", "<C-l>", "<cmd> TmuxNavigateRight<CR>", { desc = "Tmux navigate right"})
map("n", "<C-j>", "<cmd> TmuxNavigateDown<CR>", { desc = "Tmux navigate down"})
map("n", "<C-k>", "<cmd> TmuxNavigateUp<CR>", { desc = "Tmux navigate up"})

-- indent
map("v", "<", "<gv", { desc = "Indent Line" })
map("v", ">", ">gv", { desc = "Indent Line" })

-- hover
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    map('n', 'K', function()
      vim.lsp.buf.hover {
        border = 'rounded',
      }
    end, { buffer = event.buf })
  end,
})

map({ "v", "n" },
  "<leader>ca",
  ":Lspsaga code_action <CR>",
  { desc = "Code code action" })

-- LSP movement
map("n",
  "gr",
  function()
    vim.lsp.buf.references()
  end,
  { desc = "LSP references" })
map("n",
  "gD",
  function()
    vim.lsp.buf.declaration()
  end,
  { desc = "LSP declaration" }
)
map("n",
  "gd",
  function()
    vim.lsp.buf.definition()
  end,
  { desc = "LSP definition" }
)
map("",
  "gi",
  function()
    vim.lsp.buf.implementation()
  end,
  { desc = "LSP implementation" })

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
  { desc = "Move selected line / block of text in visual mode down" }
)
map("v",
  "K",
  ":m '<-2<CR>gv=gv",
  { desc = "Move selected line / block of text in visual mode up" }
)
