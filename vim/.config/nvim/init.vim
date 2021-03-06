set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
"
" TODO break this one up
source /home/dominik/.config/nvim/.vimrc
source /home/dominik/.config/nvim/window-switching.vim
source /home/dominik/.config/nvim/preferred-editor.vim
source /home/dominik/.config/nvim/latex.vim
" source /home/dominik/.config/nvim/coc.vim
" source /home/dominik/.config/nvim/julia.vim

nnoremap <C-p> :<C-u>FZF<Cr>

let g:grepper = {}
let g:grepper.tools =['grep', 'git', 'rg']
nnoremap <Leader>* :Grepper -cword -noprompt<CR>
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)
nnoremap <Leader>g :Grepper -tool git<CR>
nnoremap <Leader>G :Grepper -tool rg<CR>
command! Todo :Grepper -tool rg -query TODO
nnoremap <Leader>T :Grepper -tool rg -query TODO <CR>

let test#strategy = "dispatch"

au FileType vimwiki set syntax=pandoc

set backupskip+=*.asc

set viminfo+=n$HOME/.config/nvim/files/info
set viminfo='100,n$HOME/.config/nvim/files/info
"Make them both live in peace and harmony
let NERDTreeHijackNetrw=0 
augroup GPG
  autocmd!
  autocmd BufReadPost  *.asc :%!gpg -q -d
  autocmd BufReadPost  *.asc |redraw!
  autocmd BufWritePre  *.asc :%!gpg -q -e -a
  autocmd BufWritePost *.asc u
  autocmd VimLeave     *.asc :!clear
augroup END
