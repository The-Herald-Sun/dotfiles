-- ~/.config/nvim/lua/plugins/ayu.lua
return {
  {
    "ayu-theme/ayu-vim",
    name = "ayu",
    lazy = false,
    priority = 1000,
    config = function()
      -- Initial Ayu setup
      vim.g.ayucolor = "mirage"
      vim.g.ayu_transparent_sidebar = 1
      vim.g.ayu_disable_background = 1

      vim.opt.winblend = 0
      vim.opt.termguicolors = true

      -- Apply the colorscheme. This is crucial for initializing the plugin.
      vim.cmd("colorscheme ayu")
    end,
  },
}
