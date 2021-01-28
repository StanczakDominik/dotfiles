autocmd Filetype julia setlocal omnifunc=v:lua.vim.lsp.omnifunc
let g:latex_to_unicode_tab = 1

lua << EOF 
require'lspconfig'.julials.setup{}
EOF 
