vim.opt.expandtab=true
vim.opt.tabstop=4
vim.opt.shiftwidth=4
vim.opt.softtabstop=4

vim.opt.nu=true
vim.opt.relativenumber=true
vim.opt.smartindent=true
vim.opt.scrolloff=8

vim.opt.clipboard:prepend("unnamed")
vim.opt.clipboard:prepend("unnamedplus")

vim.g.mapleader = " "
vim.keymap.set("v", "<leader>y", ":w !xsel -i -b")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    { "folke/tokyonight.nvim", lazy = false, priority = 1000, opts = {} },
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {"alexghergh/nvim-tmux-navigation"},
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
    {'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' }},
    { 'nvim-tree/nvim-tree.lua', dependencies = { 'nvim-tree/nvim-web-devicons' }},
}

local opts = {}

require("lazy").setup(plugins, opts)
vim.cmd[[colorscheme tokyonight-night]]
local telescope = require('telescope').setup({
    defaults = {
        previewer = true,
        layout_config = {
            horizontal = {
                preview_cutoff = 0,
            },
        },
    },
})
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})

local ntnav = require('nvim-tmux-navigation').setup({})
vim.keymap.set("n", "<C-h>", "<Cmd>NvimTmuxNavigateLeft<CR>", {})
vim.keymap.set("n", "<C-j>", "<Cmd>NvimTmuxNavigateDown<CR>", {})
vim.keymap.set("n", "<C-k>", "<Cmd>NvimTmuxNavigateUp<CR>", {})
vim.keymap.set("n", "<C-l>", "<Cmd>NvimTmuxNavigateRight<CR>", {})

local config = require("nvim-treesitter.configs")
config.setup({
    ensure_installed = { "c", "lua" },
    sync_install = false,
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },  
})

local nvimtree = require("nvim-tree").setup({
    view = { width = 30 }
})
vim.keymap.set('n', '<C-b>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

local lualine = require('lualine').setup{
    options = {
        icons_enabled = true,
        theme = 'horizon',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {},
        lualine_y = {'filetype'},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
}
