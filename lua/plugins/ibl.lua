return{
{
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl", -- new module name
  config = function()
    require("ibl").setup({
      indent = { char = "│" }, -- character for indentation line
      scope = { enabled = true }, -- highlights current scope
      exclude = {
        filetypes = { "help", "dashboard", "neo-tree", "Trouble", "lazy" },
        buftypes = { "terminal", "nofile" },
      },
    })
  end,
}}
