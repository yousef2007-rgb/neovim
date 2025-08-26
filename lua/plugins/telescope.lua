return {
    'nvim-telescope/telescope.nvim',
    keys = {
        {"<leader>pf", "<cmd>Telescope find_files<cr>"},
        {"<C-p>", "<cmd>Telescope git_files<cr>"},
        {"<leader>pd", "<cmd>Telescope live_grep<cr>"},
    },
    tag = '0.1.8',
-- or                              , branch = '0.1.x',
      dependencies = { 'nvim-lua/plenary.nvim' }
    
}
