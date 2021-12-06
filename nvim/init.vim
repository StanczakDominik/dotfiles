let &packpath = &runtimepath
syntax on

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
source ~/.config/nvim/markdown.vim "here due to mkdx/polyglot conflicts 

call plug#begin('~/.vim/plugged')
Plug 'ActivityWatch/aw-watcher-vim'
Plug 'AndrewRadev/linediff.vim'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'Konfekt/FastFold' " limit automatic fold updates
Plug 'SidOfc/mkdx'
Plug 'SirVer/ultisnips'
Plug 'airblade/vim-gitgutter'      " shows git modified  lines; ]c to jump between hunks; \hs to stage hunks, \hu to unstage, \hp to preview
Plug 'alemidev/vim-combo'
Plug 'altercation/vim-colors-solarized'
Plug 'christoomey/vim-tmux-navigator'  " <C-hjkl> to navigate Vim panes and Tmux windows, <C-\> - prev split
Plug 'dkarter/bullets.vim'
Plug 'erietz/vim-terminator'
Plug 'ferrine/md-img-paste.vim'
Plug 'folke/trouble.nvim'
Plug 'folke/which-key.nvim'
Plug 'gcmt/taboo.vim'
Plug 'godlygeek/tabular'
Plug 'goerz/jupytext.vim'
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install', 'for': 'python' }
Plug 'honza/vim-snippets'
Plug 'hrsh7th/nvim-compe'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'jamessan/vim-gnupg'   " Transparent editing of gnupg-encrypted files
Plug 'jesseleite/vim-agriculture'
Plug 'junegunn/fzf'      
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'                     " distraction-free mode
Plug 'junegunn/limelight.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'kalekundert/vim-coiled-snake' " Automatic folding of python code
Plug 'kdav5758/TrueZen.nvim'
Plug 'kdheepak/JuliaFormatter.vim'
Plug 'kkoomen/vim-doge'  " Docstring generation
Plug 'kshenoy/vim-signature'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'lervag/vimtex'
Plug 'lervag/wiki.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'majutsushi/tagbar'
Plug 'mhinz/vim-grepper'
Plug 'mhinz/vim-startify'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'othree/html5.vim'
Plug 'plasticboy/vim-markdown'
Plug 'preservim/nerdcommenter'
Plug 'preservim/nerdtree'                    " :NERDTree command
Plug 'psf/black'                  " :Black
Plug 'ray-x/lsp_signature.nvim'
Plug 'reedes/vim-pencil'
Plug 'reedes/vim-wordy'
Plug 'ryanoasis/vim-devicons'
Plug 'sheerun/vim-polyglot'       
Plug 't9md/vim-quickhl'
Plug 'tpope/vim-commentary'                 " comment stuff out; gcc command
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'       
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'        
Plug 'tpope/vim-sleuth'           
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'                  " ]l jumps, etc
Plug 'vim-airline/vim-airline'
Plug 'vim-test/vim-test'
Plug 'wannesm/wmgraphviz.vim'
Plug 'whatyouhide/vim-gotham'
Plug 'yazgoo/unicodemoji'
call plug#end()

syntax enable

autocmd FileType make setlocal noexpandtab
colorscheme solarized
let NERDTreeHijackNetrw=1 "Make them both live in peace and harmony
runtime ftplugin/man.vimi
set backspace=indent,eol,start
set backupskip+=*.asc
set completeopt=menuone,noselect
set foldmethod=syntax
set hidden
set hlsearch
set inccommand=split
set isfname+=32
set nowrap
set number
set ruler
set sessionoptions+=tabpages,globals
set showmatch
set showmode
set smartcase
set spelllang=pl,en_us
set splitbelow
set splitright
set tabstop=4 shiftwidth=4 expandtab
set title
set viminfo+=n$HOME/.config/nvim/files/info
set viminfo='100,n$HOME/.config/nvim/files/info
set wildmenu

source ~/.config/nvim/airline.vim
source ~/.config/nvim/compe.vim
source ~/.config/nvim/fzf.vim
source ~/.config/nvim/git.vim
source ~/.config/nvim/goyo.vim
source ~/.config/nvim/gpg.vim
source ~/.config/nvim/grepper.vim
source ~/.config/nvim/julia.vim
source ~/.config/nvim/latex.vim
source ~/.config/nvim/learn-vim.vim
source ~/.config/nvim/limelight.vim
source ~/.config/nvim/lsp.vim
source ~/.config/nvim/mappings.vim
source ~/.config/nvim/multilingua.vim
source ~/.config/nvim/plugin-config/highlights.vim
source ~/.config/nvim/plugin-config/start-screen.vim
source ~/.config/nvim/preferred-editor.vim
source ~/.config/nvim/python.vim
source ~/.config/nvim/test.vim
source ~/.config/nvim/ultisnips.vim
source ~/.config/nvim/window-switching.vim
