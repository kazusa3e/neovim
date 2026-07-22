-- Editor keymaps
-- (vim-shared maps are in ~/.vimrc; plugin maps in their respective files)

-- Comment operator: q → gc (tree-sitter aware, builtin)
vim.keymap.set('n', 'q', 'gc', { remap = true, desc = 'Comment operator' })

-- LSP keymaps (no default bindings; these are global since they no-op without a server)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'LSP: go to definition' })
vim.keymap.set('n', 'gh', vim.lsp.buf.hover, { desc = 'LSP: hover' })
vim.keymap.set('n', '==', function()
    vim.lsp.buf.format({ async = true })
end, { desc = 'LSP: format buffer' })
vim.keymap.set('v', '=', function()
    vim.lsp.buf.format({ async = true })
end, { desc = 'LSP: format selection' })
vim.keymap.set('n', 'qq', 'gcc', { remap = true, desc = 'Comment line' })
vim.keymap.set('v', 'q', 'gc', { remap = true, desc = 'Comment selection' })

-- Completion (built-in vim.lsp.completion, no plugin)
--
-- <C-Space>  trigger completion manually
-- <Tab>      inside popup: cycle to next item; else jump to next snippet tabstop
-- <S-Tab>    inside popup: cycle to previous item; else jump to previous tabstop
-- <CR>       inside popup: accept selected item (<C-y>); otherwise normal newline
--
-- completeopt is "noselect" so no item is pre-selected; cycle with Tab, then <CR>
-- (or <C-y>) to accept.
local function pumvisible()
    return vim.fn.pumvisible() ~= 0
end

-- Manual trigger. The function name varies across 0.11/0.12 (trigger vs get);
-- fall back to omnifunc (<C-x><C-o>) if the API is unavailable.
vim.keymap.set('i', '<C-Space>', function()
    local ok = pcall(function()
        (vim.lsp.completion.trigger or vim.lsp.completion.get)()
    end)
    if not ok then
        vim.api.nvim_feedkeys(
            vim.api.nvim_replace_termcodes('<C-x><C-o>', true, false, true), 'n', false)
    end
end, { desc = 'Trigger completion' })

vim.keymap.set('i', '<Tab>', function()
    if pumvisible() then
        return '<C-n>'
    elseif vim.snippet.active({ direction = 1 }) then
        vim.snippet.jump(1)
    else
        return '<Tab>'
    end
end, { expr = true, silent = true, desc = 'Completion next / snippet next' })

vim.keymap.set('i', '<S-Tab>', function()
    if pumvisible() then
        return '<C-p>'
    elseif vim.snippet.active({ direction = -1 }) then
        vim.snippet.jump(-1)
    else
        return '<S-Tab>'
    end
end, { expr = true, silent = true, desc = 'Completion prev / snippet prev' })

vim.keymap.set('i', '<CR>', function()
    return pumvisible() and '<C-y>' or '<CR>'
end, { expr = true, silent = true, desc = 'Accept completion' })
