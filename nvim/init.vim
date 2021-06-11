set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
"
" TODO break this one up
syntax on
call plug#begin('~/.vim/plugged')
Plug 'junegunn/goyo.vim'                     " distraction-free mode
Plug 'airblade/vim-gitgutter'      " shows git modified  lines; ]c to jump between hunks; \hs to stage hunks, \hu to unstage, \hp to preview
Plug 'tpope/vim-commentary'                 " comment stuff out; gcc command
Plug 'preservim/nerdcommenter'
" Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

Plug 'tpope/vim-unimpaired'                  " ]l jumps, etc
Plug 'tpope/vim-surround'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-obsession'
Plug 'preservim/nerdtree'                    " :NERDTree command
Plug 'reedes/vim-wordy'
Plug 'reedes/vim-pencil'
Plug 'mhinz/vim-startify'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'yazgoo/unicodemoji'
Plug 'jpalardy/vim-slime', { 'for': 'python' }
Plug 'hanschen/vim-ipython-cell', { 'for': 'python' }
let g:slime_target = "neovim"
Plug 'kshenoy/vim-signature'
Plug 'dkarter/bullets.vim'
Plug 'godlygeek/tabular'
Plug 'ActivityWatch/aw-watcher-vim'
Plug 'andweeb/presence.nvim'
Plug 'kdav5758/TrueZen.nvim'
Plug 'junegunn/vim-peekaboo'

Plug 'machakann/vim-highlightedyank'
Plug 'lervag/wiki.vim'

Plug 'whatyouhide/vim-gotham'

Plug 'erietz/vim-terminator'

source ~/.config/nvim/plugin-config/start-screen.vim
Plug 'kalekundert/vim-coiled-snake' " Automatic folding of python code
Plug 'Konfekt/FastFold' " limit automatic fold updates
" Plug  'inkarkat/vim-ReplaceWithRegister'   " \"xgr
Plug 'tpope/vim-fugitive'       
Plug 'tpope/vim-rhubarb'        
Plug 'kkoomen/vim-doge'  " Docstring generation
let g:doge_doc_standard_python = 'numpy'
Plug 'christoomey/vim-tmux-navigator'  " <C-hjkl> to navigate Vim panes and Tmux windows, <C-\> - prev split
Plug 'psf/black'                  " :Black
Plug 'junegunn/fzf'      
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'
Plug 'jesseleite/vim-agriculture'
Plug 'mhinz/vim-grepper'
Plug 'vim-test/vim-test'
Plug 'heavenshell/vim-pydocstring'
Plug 'jeffkreeftmeijer/vim-numbertoggle'   "` Relative line number
Plug 'plasticboy/vim-markdown'
Plug 'othree/html5.vim'
Plug 'tpope/vim-sleuth'           
Plug 'sheerun/vim-polyglot'       


Plug 'thaerkh/vim-workspace'
Plug 'vim-airline/vim-airline'

Plug 'altercation/vim-colors-solarized'
Plug 'junegunn/limelight.vim'
Plug 'jamessan/vim-gnupg'   " Transparent editing of gnupg-encrypted files
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'  
Plug 'JuliaEditorSupport/julia-vim'

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

Plug 'kdheepak/JuliaFormatter.vim'
Plug 'lervag/vimtex'
Plug 'tpope/vim-dispatch'
Plug 'goerz/jupytext.vim'
Plug 'ryanoasis/vim-devicons'
let g:pydocstring_doq_path='/home/dominik/miniconda3/bin/doq'
Plug 'wannesm/wmgraphviz.vim'

call plug#end()


set backspace=indent,eol,start
syntax enable
set showmode
set wildmenu
set ruler
set foldmethod=syntax
runtime ftplugin/man.vimi
set nowrap
set hlsearch
set showmatch
set smartcase
set hidden
set number
set tabstop=4 shiftwidth=4 expandtab
set spelllang=en_us
colorscheme gotham




autocmd FileType make setlocal noexpandtab
nnoremap <leader>m :Make<CR>
set spelllang=pl,en_us


" https://vi.stackexchange.com/a/470
nnoremap <F5> :checktime<CR>




""""""""""""""""terminal

tnoremap <c-b> <c-\><c-n>
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
source /home/dominik/.config/nvim/ipython-cell.vim

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

