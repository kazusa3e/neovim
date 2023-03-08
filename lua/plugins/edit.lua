return {
    -- fold
    {
        'kevinhwang91/nvim-ufo',
        dependencies = {
            { 'kevinhwang91/promise-async', lazy = true },
        },
        lazy = false,
        keys = {
            { 'zM', function() require 'ufo'.closeAllFolds() end },
            { 'zR', function() require 'ufo'.openAllFolds() end },
        },
        config = function()
            require 'ufo'.setup {
                open_fold_hl_timeout = 0,
                provider_selector = function(bufnr, filetype, buftype)
                    -- return { 'lsp' }
                    return { 'treesitter' }
                end,
                fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
                    local newVirtText = {}
                    local suffix = ('    %d lines'):format(endLnum - lnum)
                    local sufWidth = vim.fn.strdisplaywidth(suffix)
                    local targetWidth = width - sufWidth
                    local curWidth = 0
                    for _, chunk in ipairs(virtText) do
                        local chunkText = chunk[1]
                        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                        if targetWidth > curWidth + chunkWidth then
                            table.insert(newVirtText, chunk)
                        else
                            chunkText = truncate(chunkText, targetWidth - curWidth)
                            local hlGroup = chunk[2]
                            table.insert(newVirtText, {chunkText, hlGroup})
                            chunkWidth = vim.fn.strdisplaywidth(chunkText)
                            -- str width returned from truncate() may less than 2nd argument, need padding
                            if curWidth + chunkWidth < targetWidth then
                                suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
                            end
                            break
                        end
                        curWidth = curWidth + chunkWidth
                    end
                    table.insert(newVirtText, {suffix, 'MoreMsg'})
                    return newVirtText
                end
            }

            -- remember folds
            vim.cmd [[
                augroup remember_folds
                autocmd!
                autocmd BufWinLeave *.* silent! mkview
                autocmd BufWinEnter *.* silent! loadview
                augroup END
            ]]
        end
    },

    -- auto pairs
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = function()
            require 'nvim-autopairs'.setup {}
        end
    },

    -- comment
    {
        'numToStr/Comment.nvim',
        event = { 'BufReadPost', 'BufNewFile' },
        config = function()
            require 'Comment'.setup {
                padding = true,
                sticky = false,
                toggler = {
                    line = 'qq',
                    block = 'QQ'
                },
                opleader = {
                    line = 'q',
                    block = 'Q'
                },
                extra = {
                    above = 'qO',
                    below = 'qo',
                    eol = 'qa'
                },
                mappings = {
                    basic = true,
                    extra = true,
                }
            }
        end
    }
}
