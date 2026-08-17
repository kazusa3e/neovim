-- Plugin management (Neovim 0.12 built-in vim.pack)
--
-- Plugins are installed to site/pack/core/opt/ by default.
-- Nothing is installed eagerly; call require('pack').ensure(name) at the
-- point where a plugin is first used. vim.pack.add() is idempotent, so the
-- first call installs (blocking, needs git + network) and later calls are
-- no-ops. Plugin code is require()-able immediately after add().
-- Update with: vim.pack.update() → review → :write to confirm

local M = {}

local SRC = {
    ['nvim-treesitter']            = 'https://github.com/neovim-treesitter/nvim-treesitter',
    ['treesitter-parser-registry'] = 'https://github.com/neovim-treesitter/treesitter-parser-registry',
    ['mini.diff']                  = 'https://github.com/nvim-mini/mini.diff',
    ['conform.nvim']               = 'https://github.com/stevearc/conform.nvim',
}

--- Install (if missing) and load a plugin on first use. Idempotent.
function M.ensure(name)
    local src = SRC[name]
    if not src then
        error('pack.ensure: unknown plugin ' .. tostring(name))
    end
    vim.pack.add({ { src = src, name = name } }, { confirm = false })
end

return M
