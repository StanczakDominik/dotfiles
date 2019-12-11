set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source /home/dominik/.config/nvim/.vimrc
nnoremap <C-p> :<C-u>FZF<Cr>

let g:grepper = {}
let g:grepper.tools =['grep', 'git', 'rg']
nnoremap <Leader>* :Grepper -cword -noprompt<CR>
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)
nnoremap <Leader>g :Grepper -tool git<CR>
nnoremap <Leader>G :Grepper -tool rg<CR>
let test#strategy = "dispatch"

au FileType vimwiki set syntax=pandoc

set backupskip+=*.asc
set viminfo=

augroup GPG
  autocmd!
  autocmd BufReadPost  *.asc :%!gpg -q -d
  autocmd BufReadPost  *.asc |redraw!
  autocmd BufWritePre  *.asc :%!gpg -q -e -a
  autocmd BufWritePost *.asc u
  autocmd VimLeave     *.asc :!clear
augroup END
