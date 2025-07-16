-- ~/.config/nvim/lua/plugins/lspconfig.lua

-- This table will hold your nvim-lspconfig options.
-- LazyVim merges this with its default settings.
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Configuration for the pyright language server
        pyright = {
          -- Explicitly define the command to run pyright-langserver
          -- This bypasses any PATH issues Neovim might have with Conda's environment
          cmd = { "/home/sam/.conda/envs/SIT225/bin/pyright-langserver", "--stdio" },

          -- Essential internal settings for pyright itself
          settings = {
            python = {
              -- Tell pyright's analysis engine which Python interpreter to use
              pythonPath = "/home/sam/.conda/envs/SIT225/bin/python",
            },
            -- You can also include other pyright analysis settings here if needed.
            -- These are read by the pyright server itself.
            -- For example, to set strict type checking or define extra import paths:
            -- analysis = {
            --   diagnosticMode = "workspace", -- Analyze entire workspace
            --   use = {"strict"}, -- Enable strict type checking rules
            --   extraPaths = { "./" }, -- Assuming your modules are in the project root
            -- },
          },
        },
        -- You can list other language servers here if you configure them, e.g.:
        -- lua_ls = {},
        -- rust_analyzer = {},
      },
      -- You can also add general LSP client settings here if needed
      -- e.g., capabilities = vim.lsp.protocol.make_client_capabilities()
    },
  },
}
