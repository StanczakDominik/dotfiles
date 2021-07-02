" fix Julia highlighting
autocmd BufRead,BufNewFile *.jl set filetype=julia
" LaTeX to unicode as you type in julia
let g:latex_to_unicode_auto = 1
let g:latex_to_unicode_tab = 1


" julia function form toggle
noremap <Leader>f :call julia#toggle_function_blockassign()<CR>
" let g:which_key_map.f = 'julia function block toggle'

" tagbar for Julia
let g:tagbar_type_julia = {
    \ 'ctagstype' : 'julia',
    \ 'kinds'     : [
        \ 't:struct', 'f:function', 'm:macro', 'c:const']
    \ }


" " ----------------------- Julia Language Server ---------------------------
" "  NOTE: you may need to manually do LspInstall julials
" " -------------------------------------------------------------------------
" lua << EOF
"     local nvim_lsp = require'nvim_lsp'
"     nvim_lsp.julials.setup({on_attach=require'diagnostic'.on_attach})
" EOF
" 
" autocmd Filetype julia setlocal omnifunc=v:lua.vim.lsp.omnifunc
" 
" " show diagnostics when hovering for too long
" autocmd CursorHold * lua vim.lsp.util.show_line_diagnostics()
" 
" let g:diagnostic_enable_virtual_text = 0
" let g:diagnostic_show_sign = 0
" 
" let g:which_key_map.l = {'name': 'Language Server Protocol'}
" 
" nnoremap <silent> <leader>lg :lua vim.lsp.util.show_line_diagnostics()<CR>
" let g:which_key_map.l.g = 'line diagonstics'
" nnoremap <silent> <leader>lh :lua vim.lsp.buf.hover()<CR>
" let g:which_key_map.l.h = 'documentation'
" nnoremap <silent> <leader>lf :lua vim.lsp.buf.definition()<CR>
" let g:which_key_map.l.f = 'jump to definition'
" nnoremap <silent> <leader>lr :lua vim.lsp.buf.references()<CR>
" let g:which_key_map.l.r = 'references'
" nnoremap <silent> <leader>l0 :lua vim.lsp.buf.document_symbol()<CR>
" let g:which_key_map.l.0 = 'document symbol'
" 
" let g:which_key_map.d = {'name': 'Directory'}
" 
" nnoremap <silent> <leader>dp :pwd<CR>
" let g:which_key_map.d.p = 'show present working directory'
" nnoremap <silent> <leader>dd :cd %:p:h<CR>:pwd<CR>
" let g:which_key_map.d.d = 'change to directory of current file'
" nnoremap <silent> <leader>de :cd %:p:h/..<CR>:pwd<CR>
" let g:which_key_map.d.e = 'change to parent directory of current file directory'
" nnoremap <silent> <leader>dh :cd<CR>:pwd<CR>
" let g:which_key_map.d.h = 'change to home directory'
" nnoremap <silent> <leader>dJ :cd -<CR>:pwd<CR>
" let g:which_key_map.d.J = 'change to previous directory'
" nnoremap <leader>da :set autochdir!<CR>
" let g:which_key_map.d.a = 'toggle auto directory switching'
" 
" " disable obnoxious underlining of everything in the damn universe
" let g:diagnostic_enable_underline = 0
" " -------------------------------------------------------------------------
" "  (end Julia Language Server)
" " -------------------------------------------------------------------------
