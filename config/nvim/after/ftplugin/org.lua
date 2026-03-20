-- Minimal org folding based on headline depth.
vim.opt_local.foldmethod = "expr"
vim.opt_local.foldexpr = "getline(v:lnum)=~'^\\*\\+' ? '>' . len(matchstr(getline(v:lnum), '^\\*\\+')) : '='"
vim.opt_local.foldlevel = 99
