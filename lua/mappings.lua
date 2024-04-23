-- require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map("n", "<leader>lf", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "Format Files" })

map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Lsp floating diagnostics" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Lsp prev diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Lsp next diagnostic" })

map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Nvimtree Toggle window" })

map("n", "<leader>f", "<cmd>Telescope find_files<cr>", { desc = "Telescope Find files" })
map("n", "<leader>F", "<cmd>Telescope live_grep<CR>", { desc = "Telescope Live grep" })
map("n", "<leader>s", "<cmd>Telescope buffers<CR>", { desc = "Telescope Find buffers" })
map("n", "<leader>ao", "<cmd>Telescope oldfiles<CR>", { desc = "Telescope Find oldfiles" })

map("t", "<C-x>", "<C-\\><C-N>", { desc = "Terminal Escape terminal mode" })

map({ "n", "t" }, "<C-q>", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "Terminal Toggle Floating term" })

-- map("n", "gD", vim.lsp.buf.declaration, opts "Lsp Go to declaration")
map("n", "gd", vim.lsp.buf.definition, { desc = "Lsp Go to definition" })
map("n", "gh", vim.lsp.buf.hover, { desc = "Lsp hover information" })
-- map("n", "gp", vim.lsp.buf.document_symbol, { desc = "Lsp document symbol" })
map("n", "gp", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "Lsp document symbols" })
-- map("n", "gi", vim.lsp.buf.implementation, {desc =  "Lsp Go to implementation"})
-- map("n", "<leader>sh", vim.lsp.buf.signature_help, {desc =  "Lsp Show signature help"})
-- map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, {desc =  "Lsp Add workspace folder"})
-- map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, {desc =  "Lsp Remove workspace folder"})

-- map("n", "<leader>wl", function()
--   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
-- end, {desc =  "Lsp List workspace folders"})

-- map("n", "<leader>D", vim.lsp.buf.type_definition, {desc =  "Lsp Go to type definition"})

map("n", "<leader>R", function()
  require "nvchad.lsp.renamer"()
end, { desc = "Lsp NvRenamer" })

map({ "n", "v" }, "g.", vim.lsp.buf.code_action, { desc = "Lsp Code action" })
map("n", "gr", vim.lsp.buf.references, { desc = "Lsp Show references" })
