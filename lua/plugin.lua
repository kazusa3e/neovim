vim.g.mapleader = ' '

local _M = {}

function _M.setup ()
        local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
        if not vim.loop.fs_stat(lazypath) then
            vim.fn.system {
                'git', 'clone', '--filter=blob:none',
                'https://github.com/folke/lazy.nvim.git',
                '--branch=stable', lazypath
            }
        end
        vim.opt.rtp:prepend(lazypath)
        require 'lazy'.setup {import = 'plugins'}
end

_M.setup()
