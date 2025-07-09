return {
  {
    "ayu-theme/ayu-vim",
    name = "ayu",
    lazy = false,
    priority = 1000,
    config = function()
      -- Initial Ayu setup
      vim.g.ayucolor = "mirage" -- Set the mirage variant
      vim.g.ayu_transparent_sidebar = 1 -- Make the sidebar (NvimTree, etc.) transparent
      vim.g.ayu_disable_background = 1 -- Make the main editor background transparent

      vim.opt.winblend = 0 -- For floating windows transparency
      vim.opt.termguicolors = true -- Essential for true colors and transparency

      vim.cmd("colorscheme ayu") -- Apply the colorscheme

      -- ✨ NEW STRATEGY: Defer forcing highlight groups to NONE ✨
      -- This ensures our transparency settings are applied *after* other
      -- ColorScheme autocmds (like snacks.nvim's transparency, etc.) have run,
      -- preventing them from overriding our settings.
      vim.defer_fn(function()
        vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })

        -- Optional: For debugging, you can keep this print
        -- local normal_hl = vim.api.nvim_get_hl_by_name("Normal", true)
        -- print("Deferred Normal guibg after force:", normal_hl.bg)
      end, 50) -- A small delay (e.g., 50ms) is usually sufficient
    end,
  },
}
