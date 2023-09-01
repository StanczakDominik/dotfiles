-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt
opt.relativenumber = false -- disable relative line numbers
opt.shiftwidth = 4 -- Size of an indent
opt.spelllang = { "pl", "en" }
opt.tabstop = 4 -- Number of spaces tabs count for
opt.clipboard = "unnamed" -- Do not by default sync with system cliboard
-- TODO
---- This file is automatically loaded by plugins.core
--vim.g.mapleader = " "
--vim.g.maplocalleader = "\\"
--
--local opt = vim.opt
--
--opt.showmode = false -- Dont show mode since we have a statusline
--opt.sidescrolloff = 8 -- Columns of context
--opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
--opt.wildmode = "longest:full,full" -- Command-line completion mode
--
--vim.g.markdown_recommended_style = 0
