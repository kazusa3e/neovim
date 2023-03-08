return {
    {
        "folke/tokyonight.nvim",
        lazy = true,
        config = function()
            require 'tokyonight'.setup {
                style = 'storm'
            }
        end
    },
    {
        "shatur/neovim-ayu",
        lazy = true,
        config = function()
            local bg2 = '#e2f4f0'
            local colors = require 'ayu.colors'
            colors.generate()

            require 'ayu'.setup {
                overrides = {
                    NormalFloat = { bg = bg2 },
                    FloatBorder = { bg = bg2, fg = bg2 },

                    CmpNormal = { bg = bg2 },
                    CmpBorder = { bg = bg2, fg = bg2 },

                    TelescopeNormal = { bg = bg2 },
                    TelescopeBorder = { bg = bg2, fg = bg2 },
                    TelescopeTitle = { bg = colors.accent },
                    TelescopePromptBorder = { bg = bg2, fg = bg2 },
                    Folded = { bg = bg2 },

                    NotePurple = { bg = '#9c27b0', fg = '#ffffff' },
                    NoteCyan = { bg = '#00bcd4', fg = '#ffffff' },
                    NoteGreen = { bg = '#4caf50', fg = '#ffffff' },
                    NoteTodo = { bg = '#03a9f4', fg = '#ffffff' },
                    NoteDDL = { bg = '#f44336', fg = '#ffffff' },

                    -- GitSignsCurrentLineBlame = { fg = '#abb0b6' },
                    -- NonText = { fg = colors.bg },
                    -- VertSplit = { bg = colors.bg, fg = colors.markup },
                    -- LspSignatureActiveParameter = { fg = colors.accent },
                    -- Search = { bg = colors.accent, fg = '#fafafa' },
                    -- Comment = { fg = colors.comment },
                }
            }
        end
    },
}
