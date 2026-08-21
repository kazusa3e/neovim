if not require("pack").ensure("mini.pick") then
	return
end

local pick = require("mini.pick")
pick.setup()

local function mtime(path)
	local stat = vim.uv.fs_stat(path)
	if not stat then
		return 0
	end
	return stat.mtime.sec + stat.mtime.nsec / 1e9
end

-- Keep modification-time order for an empty query, then use fuzzy relevance.
local function mtime_match(path_at)
	local cache = {}
	return function(stritems, inds, query)
		if #query > 0 then
			return pick.default_match(stritems, inds, query)
		end

		local items = pick.get_picker_items() or {}
		local function time(ind)
			local path = path_at(items[ind], stritems[ind])
			if not path or path == "" then
				return 0
			end
			if cache[path] == nil then
				cache[path] = mtime(path)
			end
			return cache[path]
		end

		table.sort(inds, function(a, b)
			local a_time, b_time = time(a), time(b)
			return a_time == b_time and a < b or a_time > b_time
		end)
		return inds
	end
end

local function files(local_opts)
	local_opts = vim.deepcopy(local_opts or {})
	local cwd = vim.fs.abspath(local_opts.cwd or vim.fn.getcwd())
	local_opts.cwd = nil

	return pick.builtin.files(local_opts, {
		source = {
			cwd = cwd,
			match = mtime_match(function(_, stritem)
				return vim.fs.joinpath(cwd, stritem)
			end),
		},
	})
end

local function buffers(local_opts)
	return pick.builtin.buffers(local_opts, {
		source = {
			match = mtime_match(function(item)
				return item and vim.api.nvim_buf_get_name(item.bufnr) or nil
			end),
		},
	})
end

local function oldfiles()
	local items = {}
	for _, path in ipairs(vim.v.oldfiles) do
		if vim.fn.filereadable(path) == 1 then
			table.insert(items, path)
		end
	end
	table.sort(items, function(a, b)
		local a_time, b_time = mtime(a), mtime(b)
		return a_time == b_time and a < b or a_time > b_time
	end)

	vim.ui.select(items, {
		prompt = "Oldfiles",
		format_item = function(path)
			return vim.fn.fnamemodify(path, ":p:.")
		end,
	}, function(selected)
		if selected then
			vim.cmd.edit(vim.fn.fnameescape(selected))
		end
	end)
end

vim.keymap.set("n", "<leader>p", files, { desc = "Find files" })
vim.keymap.set("n", "<leader>s", buffers, { desc = "Pick buffer" })
vim.keymap.set("n", "<leader>/", pick.builtin.grep_live, { desc = "Live grep" })
vim.keymap.set("n", "<leader>o", oldfiles, { desc = "Old files" })
-- vim.keymap.set("n", "<leader>r", pick.builtin.resume, { desc = "Resume last picker" })

MiniPick.registry.files = files
MiniPick.registry.buffers = buffers
MiniPick.registry.oldfiles = oldfiles
