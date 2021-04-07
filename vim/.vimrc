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

" call plug#begin('~/.local/share/nvim/plugged')



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
" inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u


" https://vi.stackexchange.com/a/470
nnoremap <F5> :checktime<CR>


"------------------------------------------------------------------------------
" ipython-cell configuration
"------------------------------------------------------------------------------
" Keyboard mappings. <Leader> is \ (backslash) by default

" map <Leader>s to start IPython
nnoremap <Leader>s :SlimeSend1 ipython --matplotlib<CR>

" map <Leader>r to run script
nnoremap <Leader>r :IPythonCellRun<CR>

" map <Leader>R to run script and time the execution
nnoremap <Leader>R :IPythonCellRunTime<CR>

" map <Leader>c to execute the current cell
nnoremap <Leader>c :IPythonCellExecuteCell<CR>

" map <Leader>C to execute the current cell and jump to the next cell
nnoremap <Leader>C :IPythonCellExecuteCellJump<CR>

" map <Leader>l to clear IPython screen
nnoremap <Leader>l :IPythonCellClear<CR>

" map <Leader>x to close all Matplotlib figure windows
nnoremap <Leader>x :IPythonCellClose<CR>

" " map [c and ]c to jump to the previous and next cell header
" nnoremap [c :IPythonCellPrevCell<CR>
" nnoremap ]c :IPythonCellNextCell<CR>

" map <Leader>h to send the current line or current selection to IPython
nmap <Leader>h <Plug>SlimeLineSend
xmap <Leader>h <Plug>SlimeRegionSend

" map <Leader>p to run the previous command
nnoremap <Leader>p :IPythonCellPrevCommand<CR>

" " map <Leader>Q to restart ipython
" nnoremap <Leader>Q :IPythonCellRestart<CR>

" map <Leader>d to start debug mode
nnoremap <Leader>d :SlimeSend1 %debug<CR>

" map <Leader>q to exit debug mode or IPython
nnoremap <Leader>q :SlimeSend1 exit<CR>


""""""""""""""""terminal

tnoremap <c-b> <c-\><c-n>
