vim.cmd [[ source $HOME/.vimrc ]]

vim.g.clipboard = 'osc52'

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'markdown',
    command = 'setlocal tw=0'
})

local function safe_umap(mode, lhs)
    if vim.fn.maparg(lhs, mode) ~= '' then
        vim.cmd(string.format('%sunmap %s', mode, lhs))
    end
end

-- disable some builtin keybindings
safe_umap('n', 'gc')
safe_umap('n', 'gcc')
safe_umap('n', 'grt')
safe_umap('n', 'gri')
safe_umap('n', 'grr')
safe_umap('n', 'gra')
safe_umap('n', 'grn')

vim.opt.fillchars:append("diff:╱")
