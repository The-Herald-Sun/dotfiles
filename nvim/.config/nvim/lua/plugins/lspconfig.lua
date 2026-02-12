-- ~/.config/nvim/lua/plugins/lspconfig.lua

-- This table will hold your nvim-lspconfig options.
-- LazyVim merges this with its default settings.
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          cmd = { "/home/sam/.conda/envs/SIT225/bin/pyright-langserver", "--stdio" },

          settings = {
            python = {
              pythonPath = "/home/sam/.conda/envs/SIT225/bin/python",
            },
          },
        },
      },
    },
  },
}
