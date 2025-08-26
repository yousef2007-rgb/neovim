    return {
      "nvim-lualine/lualine.nvim",
      event = "VeryLazy", -- Load lualine very late to ensure other plugins are ready
      config = function()
        require("lualine").setup({
          options = {
            -- Your lualine options here, e.g., theme, global statusline
            theme = "auto",
            globalstatus = true,
          },
          sections = {
            -- Define your statusline sections and components
            lualine_a = { 'mode' },
            lualine_b = { 'branch', 'diff', 'diagnostics' },
            lualine_c = { 'filename' },
            lualine_x = { 'encoding', 'fileformat', 'filetype' },
            lualine_y = { 'progress' },
            lualine_z = { 'location' },
          },
          inactive_sections = {
            -- Define inactive statusline sections
          },
          extensions = { 'nvim-tree', 'lazy' }, -- Example extensions
        })
      end,
    }
