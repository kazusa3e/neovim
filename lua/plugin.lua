-- must be set before lazy.nvim loads to apply to all keymaps
vim.g.mapleader = ' '

local function setup()
    local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
    if not vim.uv.fs_stat(lazypath) then
        vim.fn.system {
            'git', 'clone', '--filter=blob:none',
            'https://github.com/folke/lazy.nvim.git',
            '--branch=stable', lazypath
        }
    end
    vim.opt.rtp:prepend(lazypath)
    require 'lazy'.setup { import = 'plugins' }
end

setup()
