vim.o.number = true
vim.o.clipboard = "unnamedplus"
vim.o.relativenumber = true
vim.o.termguicolors = true

vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.smartindent = true

vim.o.cursorline = true
vim.o.cursorlineopt = 'number'

vim.o.swapfile = false
vim.o.backup = false

--vim.opt.hlsearch = false
--vim.opt.incsearch = true

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>yy", "\"+yy")
vim.keymap.set("v", "<leader>yy", "\"+yy")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

vim.keymap.set("n", "<leader>pu", '<cmd>!vendor/bin/phpunit <cr>')
vim.keymap.set("n", "<leader>puf", '<cmd>!vendor/bin/phpunit %<cr>')
vim.keymap.set("v", "<leader>y", "\"+y")

local tele_built = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', tele_built.find_files, { desc = "Find Files" })
vim.keymap.set('n', '<leader>ps', tele_built.live_grep, { desc = "Grep" })
vim.keymap.set('n', '<leader>fb', tele_built.buffers, { desc = "Find Buffers" })
vim.keymap.set('n', '<leader>fh', tele_built.help_tags, { desc = "Find Help" })
vim.keymap.set('n', '<leader>fc', tele_built.command_history, { desc = "COMMAND HISTORY" })
vim.keymap.set('n', '<leader>e', tele_built.diagnostics, { desc = "Diagnostics" })
vim.keymap.set('n', '<leader>gs', tele_built.git_status, { desc = "Git Status" })
vim.keymap.set('n', '<leader>t', tele_built.builtin, { desc = "Telescope" })
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set('n', '<leader>gg', "<cmd>LazyGit<cr>", { desc = "Lazy Git" })
vim.keymap.set('n', '<leader>ss', "<cmd>write<cr>", { desc = "Write File" })

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end )
vim.keymap.set("n", "<C-n>", function() ui.nav_file(2) end )
vim.keymap.set("n", "<C-b>", function() ui.nav_file(3) end )
vim.keymap.set("n", "<C-g>", function() ui.nav_file(4) end )


vim.g.maplocalleader = "\\"

require("lazy").setup({
    spec = {
        { "ellisonleao/gruvbox.nvim" },
        -- Configure LazyVim to load gruvbox
        {
            'nvim-telescope/telescope.nvim', tag = '0.1.8',
            dependencies = { 'nvim-lua/plenary.nvim' }
        },
        {
            'ThePrimeagen/harpoon',
            dependencies = { 'nvim-lua/plenary.nvim' }
        },
        {"neovim/nvim-lspconfig"},
        {"williamboman/mason.nvim"},
        {"williamboman/mason-lspconfig.nvim"},
        {
            "hrsh7th/nvim-cmp",
            dependencies = {
                'hrsh7th/cmp-nvim-lsp',
                'hrsh7th/cmp-buffer',
                'hrsh7th/cmp-path',
                'hrsh7th/cmp-cmdline',
                'L3MON4D3/LuaSnip',
                'saadparwaiz1/cmp_luasnip',
                'hrsh7th/cmp-vsnip',
                'hrsh7th/vim-vsnip',
                'rafamadriz/friendly-snippets',
            },
        },
        { "nvim-treesitter/nvim-treesitter",  build = ":TSUpdate" },
        {
            "kdheepak/lazygit.nvim",
            lazy = true,
            cmd = {
                "LazyGit",
                "LazyGitConfig",
                "LazyGitCurrentFile",
                "LazyGitFilter",
                "LazyGitFilterCurrentFile",
            },
            -- optional for floating window border decoration
            dependencies = {
                "nvim-lua/plenary.nvim",
            },
            -- setting the keybinding for LazyGit with 'keys' is recommended in
            -- order to load the plugin when the command is run for the first time
            keys = {
                { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
            }
        }
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "gruvbox" } },
    -- automatically check for plugin updates
    checker = { enabled = true },
})

require("mason").setup()
require("mason-lspconfig").setup()

vim.lsp.enable("vue_ls");
vim.lsp.enable("tailwindcss");
vim.lsp.enable("intelephense");
vim.lsp.enable("html");

local cmp = require'cmp'

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            --vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)

            -- For `mini.snippets` users:
            -- local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
            -- insert({ body = args.body }) -- Insert at cursor
            -- cmp.resubscribe({ "TextChangedI", "TextChangedP" })
            -- require("cmp.config").set_onetime({ sources = {} })
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        --{ name = 'vsnip' }, -- For vsnip users.
        { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
    }, {
        { name = 'buffer' },
    })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
})

vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])



