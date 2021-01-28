let g:grepper = {}
let g:grepper.tools =['grep', 'git', 'rg']
nnoremap <Leader>* :Grepper -cword -noprompt<CR>
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)
nnoremap <Leader>g :Grepper -tool git<CR>
nnoremap <Leader>G :Grepper -tool rg<CR>
command! Todo :Grepper -tool rg -query TODO
nnoremap <Leader>T :Grepper -tool rg -query TODO <CR>
