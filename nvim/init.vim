" set runtimepath^=~/.vim runtimepath+=~/.vim/after
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
" Plug 'ron89/thesaurus_query.vim'

Plug 'tpope/vim-unimpaired'                  " ]l jumps, etc
Plug 'tpope/vim-surround'
Plug 'tpope/vim-speeddating'
Plug 'ferrine/md-img-paste.vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-obsession'
Plug 'preservim/nerdtree'                    " :NERDTree command
Plug 'reedes/vim-wordy'
Plug 'reedes/vim-pencil'
Plug 'mhinz/vim-startify'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'yazgoo/unicodemoji'
Plug 'kshenoy/vim-signature'
Plug 'dkarter/bullets.vim'
Plug 'godlygeek/tabular'
Plug 'ActivityWatch/aw-watcher-vim'
Plug 'kdav5758/TrueZen.nvim'
Plug 'junegunn/vim-peekaboo'
Plug 'machakann/vim-highlightedyank'
Plug 'lervag/wiki.vim'

Plug 't9md/vim-quickhl'
source ~/.config/nvim/plugin-config/highlights.vim

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

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
" Plug 'airblade/vim-rooter'
Plug 'jesseleite/vim-agriculture'
Plug 'mhinz/vim-grepper'
Plug 'vim-test/vim-test'
Plug 'heavenshell/vim-pydocstring'
Plug 'plasticboy/vim-markdown'
Plug 'othree/html5.vim'
Plug 'tpope/vim-sleuth'           
Plug 'sheerun/vim-polyglot'       


Plug 'thaerkh/vim-workspace'
Plug 'vim-airline/vim-airline'
Plug 'majutsushi/tagbar'

let g:airline#extensions#tagbar#enabled = 1

Plug 'altercation/vim-colors-solarized'
Plug 'gcmt/taboo.vim'
set sessionoptions+=tabpages,globals
Plug 'junegunn/limelight.vim'
Plug 'jamessan/vim-gnupg'   " Transparent editing of gnupg-encrypted files
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
set completeopt=menuone,noselect
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
let g:jupytext_print_debug_msgs = 1
let g:jupytext_fmt = 'py'
Plug 'ryanoasis/vim-devicons'
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install', 'for': 'python' }
let g:pydocstring_doq_path = '/home/dominik/.local/bin/doq'
let g:pydocstring_formatter = 'numpy'
Plug 'wannesm/wmgraphviz.vim'


Plug 'kyazdani42/nvim-web-devicons'
Plug 'folke/trouble.nvim'
Plug 'folke/which-key.nvim'
Plug 'ray-x/lsp_signature.nvim'

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
set title
set tabstop=4 shiftwidth=4 expandtab
set spelllang=en_us
set inccommand=split
colorscheme solarized




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
" source /home/dominik/.config/nvim/ale.vim
source /home/dominik/.config/nvim/multilingua.vim
source /home/dominik/.config/nvim/airline.vim
source /home/dominik/.config/nvim/markdown.vim
source /home/dominik/.config/nvim/lsp.vim
source /home/dominik/.config/nvim/compe.vim
source /home/dominik/.config/nvim/julia.vim
" source /home/dominik/.config/nvim/highlights.vim
" source /home/dominik/.config/nvim/darkmode.vim

au FileType vimwiki set syntax=pandoc
set backupskip+=*.asc
set viminfo+=n$HOME/.config/nvim/files/info
set viminfo='100,n$HOME/.config/nvim/files/info
"Make them both live in peace and harmony
let NERDTreeHijackNetrw=1
augroup GPG
  autocmd!
  autocmd BufReadPost  *.asc :%!gpg -q -d
  autocmd BufReadPost  *.asc |redraw!
  autocmd BufWritePre  *.asc :%!gpg -q -e -a
  autocmd BufWritePost *.asc u
  autocmd VimLeave     *.asc :!clear
augroup END

au BufRead,BufNewFile *.md setlocal textwidth=80

autocmd FileType markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>

set suffixesadd+=.md

let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {"flowchart":{"useMaxWidth":"True"}},
    \ 'disable_sync_scroll': 1,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0
    \ }

let g:wiki_root = '~/vimwiki'
let g:wiki_filetypes = ['wiki', 'md', 'markdown']
let g:wiki_global_load = 0
let g:wiki_link_target_type = 'md'
nnoremap <leader>/ /\<\><left><left>

nmap <F8> :TagbarToggle<CR>
set isfname+=32
