set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
"
" TODO break this one up
source /home/dominik/.config/nvim/.vimrc
source /home/dominik/.config/nvim/window-switching.vim
source /home/dominik/.config/nvim/preferred-editor.vim
source /home/dominik/.config/nvim/latex.vim
source /home/dominik/.config/nvim/fzf.vim
source /home/dominik/.config/nvim/grepper.vim
source /home/dominik/.config/nvim/ultisnips.vim
source /home/dominik/.config/nvim/git.vim
source /home/dominik/.config/nvim/limelight.vim
source /home/dominik/.config/nvim/goyo.vim
source /home/dominik/.config/nvim/test.vim
source /home/dominik/.config/nvim/learn-vim.vim
source /home/dominik/.config/nvim/ale.vim
source /home/dominik/.config/nvim/multilingua.vim
source /home/dominik/.config/nvim/airline.vim
source /home/dominik/.config/nvim/markdown.vim
source /home/dominik/.config/nvim/lsp.vim
source /home/dominik/.config/nvim/julia.vim

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

