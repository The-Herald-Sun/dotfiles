-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
---
---- Set this after the colorscheme has loaded

local ayu_augroup = vim.api.nvim_create_augroup("AyuHighlights", { clear = true })

vim.api.nvim_create_autocmd("ColorScheme", {
  group = ayu_augroup,
  callback = function()
    -- Check if the current colorscheme is 'ayu' and if the function 'ayu#colors' exists.
    -- This check is crucial to prevent the 'Unknown function' error.
    if vim.g.colors_name == "ayu" and vim.fn.exists("ayu#colors") ~= 0 then
      local ayu_colors = vim.fn["ayu#colors"]()

      -- Set Bufferline highlights using the ayu color palette
      vim.api.nvim_set_hl(0, "BufferlineFill", { bg = ayu_colors.background })
      vim.api.nvim_set_hl(0, "BufferlineBuffer", { fg = ayu_colors.comment, bg = ayu_colors.bg_s1 })
      vim.api.nvim_set_hl(0, "BufferlineBufferSelected", { fg = ayu_colors.fg, bg = ayu_colors.bg_s0, bold = true })

      -- Set the Normal highlight group to a specific background color
      vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
    end
  end,
})

vim.defer_fn(function()
  vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })
end, 0)
