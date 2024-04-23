-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "one_light",

  -- hl_override = {
  -- 	Comment = { italic = true },
  -- 	["@comment"] = { italic = true },
  -- },
  tabufline = {
    enabled = false,
  },
  nvdash = {
    load_on_startup = true,
  },
  term = {
    float = {
      row = 0.1,
      col = 0.1,
      width = 0.8,
      height = 0.7,
    },
  },
}

return M
