vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "<leader>pu", '<cmd>!vendor/bin/phpunit <cr>')
vim.keymap.set("n", "<leader>puf", '<cmd>!vendor/bin/phpunit %<cr>')
vim.keymap.set("n", "<leader>ppp", '<cmd>!php artisan test --parallel --processes=4 <cr>')
vim.keymap.set("n", "<leader>mfs", '<cmd>!php artisan migrate:fresh --seed --database=mysql_test<cr>')
vim.keymap.set("n", "<leader>fnl", '<cmd>!composer final-check<cr>')
vim.keymap.set("n", "<leader>yrd", '<cmd>!yarn run dev<cr>')
vim.keymap.set("n", "<leader>yrb", '<cmd>!yarn run build<cr>')
vim.keymap.set("n", "<leader>yy", "\"+yy")

vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<leader>y", "\"+y")

vim.keymap.set('n', '<leader>ff', '<cmd>!php-cs-fixer --rules=@PSR2 --using-cache=no fix %<cr>')
