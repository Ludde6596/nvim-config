--Important before loading packages
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.g.have_nerd_font = true
--Default line numbers
vim.o.number = true
--Sync clipboard between OS and Neovim
vim.schedule(function()
  vim.o.clipboard = "unnamedplus"
end)

vim.o.breakindent = true
vim.o.undofile = true
--Case insensitive seraching
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.signcolumn = "yes"

--Faster update timings and keymap timings
vim.o.updatetime = 250
vim.o.timeoutlen = 300

--Split screen behaviour
vim.o.splitright = true
vim.o.splitbelow = true

--Whitespace symbols
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

--Preview substitutions
vim.o.inccommand = "split"
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true

--Keymaps
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- [[ Basic Autocommands ]]
-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

local indent_by_ft = {
  lua = { shiftwidth = 2, tabstop = 2, softtabstop = 2, expandtab = true },
  javascript = { shiftwidth = 2, tabstop = 2, softtabstop = 2, expandtab = true },
  svelte = { shiftwidth = 2, tabstop = 2, softtabstop = 2, expandtab = true },
  typescript = { shiftwidth = 2, tabstop = 2, softtabstop = 2, expandtab = true },
  json = { shiftwidth = 2, tabstop = 2, softtabstop = 2, expandtab = true },
  yaml = { shiftwidth = 2, tabstop = 2, softtabstop = 2, expandtab = true },
  html = { shiftwidth = 2, tabstop = 2, softtabstop = 2, expandtab = true },
  css = { shiftwidth = 2, tabstop = 2, softtabstop = 2, expandtab = true },

  python = { shiftwidth = 4, tabstop = 4, softtabstop = 4, expandtab = true },

  make = { shiftwidth = 4, tabstop = 4, softtabstop = 0, expandtab = false },
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function(ev)
    local opts = indent_by_ft[ev.match]
    if not opts then
      return
    end

    for key, value in pairs(opts) do
      vim.opt_local[key] = value
    end
  end,
})

require("ludde.lazy")
