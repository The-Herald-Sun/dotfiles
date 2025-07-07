-- ~/.config/nvim/lua/plugins/colorscheme.lua
return {
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true, -- Main transparency setting
      styles = {
        sidebars = "transparent", -- Optional: Make sidebars (like Neo-tree) transparent
        floats = "transparent", -- Optional: Make floating windows (like LSP info) transparent
      },
    },
  },
}
