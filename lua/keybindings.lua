local keybindings = {}

local map = vim.keymap.set
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- open current buf with default external application
map('n', '<leader>oo', '<CMD>silent !open "%"<CR>')
map('n', '<leader>of', '<CMD>silent !open -R "%"<CR>')
map('n', '<leader>oc', '<CMD>silent !code .<CR>')
map('n', '<leader>om', '<CMD>silent !markmap "%" -o $(mktemp -d)/$(uuidgen).html --no-toolbar<CR>')

-- delete buffer
map('n', '<S-x>', '<CMD>Bdelete<CR>')

function keybindings.lsp()
    -- map('n', 'gd', function() vim.lsp.buf.definition() end)
    map('n', 'g=', function() vim.lsp.buf.format { async = true } end)
    map('v', 'g=', 'gq')
    map('n', 'gh', function() vim.lsp.buf.hover() end)
end

function keybindings.telescope()
    map('n', '<LEADER>f', '<CMD>Telescope find_files<CR>')
    map('n', '<LEADER>F', '<CMD>Telescope live_grep<CR>')
    map('n', '<LEADER>af', '<CMD>Telescope find_files follow=true no_ignore=true hidden=true<CR>')
    map('n', '<LEADER>aF', '<CMD>Telescope live_grep follow=true no_ignore=true hidden=true<CR>')
    map('n', '<LEADER>ao', '<CMD>Telescope oldfiles<CR>')
    map('n', '<LEADER>s', '<CMD>Telescope buffers<CR>')
    map('n', '<LEADER>gs', '<CMD>Telescope git_status<CR>')
    map('n', '<LEADER>p', '<CMD>Telescope lsp_document_symbols<CR>')
    map('n', '<C-p>', '<CMD>Telescope builtin<CR>')
end

function keybindings.nvim_tree()
    map('n', '<LEADER>e', '<CMD>NvimTreeToggle<CR>')
    map('n', '<LEADER>E', '<CMD>NvimTreeFindFile<CR>')
end

function keybindings.zk()
    map('n', '<LEADER>nf', '<CMD>ZkNotes<CR>')
    map('n', '<LEADER>nb', '<CMD>ZkBacklinks<CR>')
    map('n', '<LEADER>nt', '<CMD>ZkTags<CR>')

    map('n', '<LEADER>nd', '<CMD>ZkNew { dir = "journals/daily" }<CR>')
    map('n', '<LEADER>nw', '<CMD>ZkNew { dir = "journals/weekly" }<CR>')
    map('n', '<LEADER>nm', '<CMD>ZkNew { dir = "journals/monthly" }<CR>')
    map('n', '<LEADER>ny', '<CMD>ZkNew { dir = "journals/yearly" }<CR>')

    map('n', '<LEADER>nB', function()
        local title = vim.fn.input('Please enter title of book: ')
        vim.cmd(string.format('silent !zk new books -p -t "%s"', title))
        vim.cmd(string.format(':ZkNew { dir = "books", title = "%s" }', title))
    end)
    map('n', '<LEADER>nC', function()
        local title = vim.fn.input('Please enter title of course: ')
        vim.cmd(string.format('silent !zk new courses -p -t "%s"', title))
        vim.cmd(string.format(':ZkNew { dir = "courses", title = "%s" }', title))
    end)
    map('n', '<LEADER>nn', function()
        local title = vim.fn.input('Please enter title of note: ')
        vim.cmd(string.format('silent !zk new -p -t "%s"', title))
        vim.cmd(string.format(':ZkNew { title = "%s" }', title))
    end)
end

function keybindings.trouble()
    map('n', '<leader>td', '<CMD>Trouble document_diagnostics<CR>')
    map('n', '<leader>tD', '<CMD>Trouble workspace_diagnostics<CR>')
    -- map('n', 'gR', '<CMD>Trouble lsp_references<CR>')
    map('n', '<leader>tq', '<CMD>Trouble quickfix<CR>')
end

function keybindings.diffview()
    map('n', '<leader>gD', '<CMD>DiffviewOpen<CR>')
end

function keybindings.gitsigns()
    map('n', '<leader>gd', '<CMD>Gitsigns preview_hunk<CR>')
    map('n', '<leader>gr', '<CMD>Gitsigns reset_hunk<CR>')
    map('n', '<leader>gR', '<CMD>Gitsigns reset_buffer<CR>')
    map('n', '<leader>ga', '<CMD>Gitsigns stage_hunk<CR>')
    map('n', '<leader>gA', '<CMD>Gitsigns stage_buffer<CR>')
    map('n', '[g', '<CMD>Gitsigns prev_hunk<CR>')
    map('n', ']g', '<CMD>Gitsigns next_hunk<CR>')
end

function keybindings.session_manager()
    map('n', '<leader>q', '<CMD>SessionManager load_current_dir_session<CR>')
end

function keybindings.toggleterm()
    map('t', '`', '<C-\\><C-n>')
    map('n', '<C-q>', '<CMD>ToggleTerm direction=float<CR>')
    map('t', '<C-q>', '<CMD>ToggleTerm direction=float<CR>')
    map('n', '<leader>r', function()
        local term_ok, term = pcall(require, 'toggleterm')
        if not term_ok then return end
        local ft = vim.bo.filetype
        local function s(modifier)
            return vim.fn.expand(modifier)
        end

        local d = {
            python = string.format('python3 "%s"', s('%:t')),
            java = string.format('javac "%s" && java "%s"', s('%:t'), s('%:t:r')),
            cpp = string.format('clang++ -g "%s" && ./a.out', s('%:t')),
            c = string.format('cc -g "%s" && ./a.out', s('%:t'))
            -- TODO: more fts be added here
        }
        for k, v in pairs(d) do
            if k == ft then
                term.exec(v, 1, nil, s('%:p:h'), 'float')
            end
        end
    end)
end

function keybindings.dial()
    map('n', '<C-a>', require 'dial.map'.inc_normal())
    map('n', '<C-x>', require 'dial.map'.dec_normal())
    map('v', '<C-a>', require 'dial.map'.inc_visual())
    map('v', '<C-x>', require 'dial.map'.dec_visual())
    map('v', 'g<C-a>', require 'dial.map'.inc_gvisual())
    map('v', 'g<C-x>', require 'dial.map'.dec_gvisual())
end

function keybindings.ufo()
    map('n', 'zR', require 'ufo'.openAllFolds)
    map('n', 'zM', require 'ufo'.closeAllFolds)

    map('n', 'zf', '[fzc', { remap = true })
end

function keybindings.lspsaga()
    map('n', 'g.', '<CMD>Lspsaga code_action<CR>')
    map('n', '[d', '<CMD>Lspsaga diagnostic_jump_prev<CR>')
    map('n', ']d', '<CMD>Lspsaga diagnostic_jump_next<CR>')
    map('n', 'gr', '<CMD>Lspsaga rename<CR>')
end

function keybindings.hop()
    map('n', 'f', '<CMD>HopWord<CR>')
    map('n', 'F', '<CMD>HopLine<CR>')
end

function keybindings.vimtex()
    map('n', '<leader>ll', '<Plug>(vimtex-compile)')
    map('n', '<leader>lc', '<Plug>(vimtex-clean-full)')
    map('n', '<leader>lz', '<Plug>(vimtex-view)')
end

function keybindings.comment()
    map('i', '<C-q>', '<ESC>qa', { remap = true })
    map('i', '<C-e>', '<ESC>Qa', { remap = true })
end

function keybindings.glance()
    map('n', 'gd', '<CMD>Glance definitions<CR>')
    map('n', 'gR', '<CMD>Glance references<CR>')
end

function keybindings.easy_align()
    map('n', 'e', '<Plug>(EasyAlign)')
    map('x', 'e', '<Plug>(EasyAlign)')
end

function keybindings.treesj()
    map('n', '<leader>j', '<CMD>TSJToggle<CR>')
end

return keybindings
