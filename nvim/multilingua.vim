" za http://blog.stelmisoft.pl/2010/sprawdzanie-pisowni-w-edytorze-tekstu-vim/
command! SpellPL setlocal spell spelllang=pl
command! SpellEN setlocal spell spelllang=en

""" translator settings

let g:translator_target_lang = 'en'
" Replace the text with translation
nmap <silent> <Leader>r <Plug>TranslateR
vmap <silent> <Leader>r <Plug>TranslateRV
