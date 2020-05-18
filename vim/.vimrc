set rtp+=~/.vim/bundle/vundle/
syntax on
call vundle#rc()
"
" plugin manager
Bundle 'gmarik/vundle'                         

" distraction-free mode
Plugin 'junegunn/goyo.vim'                     

" shows git modified  lines; ]c to jump between hunks; \hs to stage hunks, \hu to unstage, \hp to preview
Plugin 'airblade/vim-gitgutter'                

" comment stuff out; gcc command
Plugin 'tpope/vim-commentary'                  
Plugin 'preservim/nerdcommenter'

" vim-unimpaired - ]l jumps, etc
Plugin 'tpope/vim-unimpaired'                  
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-speeddating'

Plugin 'tpope/vim-repeat'
"
":NERDTree command
Plugin 'preservim/nerdtree'
"
"use Tab for all completions
" Plugin 'metalelf0/supertab'
"
" TODO something with imports?
" Plugin 'prakashdanish/vimport'
"
" TODO tool for writers?
" Plugin 'reedes/vim-pencil'
"
" Automatic folding of python code
Plugin 'kalekundert/vim-coiled-snake'

" limit automatic fold updates
Plugin 'Konfekt/FastFold'

" TODO Git stuff
Bundle 'tpope/vim-fugitive'       
Plugin 'tpope/vim-rhubarb'        

" Linter
Plugin 'w0rp/ale'

" Docstring generation
Plugin 'kkoomen/vim-doge'
let g:doge_doc_standard_python = 'numpy'

" PyCharm style multiple cursors via <C-n>
" Plugin 'terryma/vim-multiple-cursors'

" <C-hjkl> to navigate Vim panes and Tmux windows, <C-\> - prev split
Plugin 'christoomey/vim-tmux-navigator'

" :Black
Plugin 'psf/black'

"Functionality
Plugin 'junegunn/fzf'      
Plugin 'junegunn/fzf.vim'
Plugin 'jesseleite/vim-agriculture'

Plugin 'mhinz/vim-grepper'
Plugin 'janko/vim-test'
Plugin 'heavenshell/vim-pydocstring'

" VIM Jedi
Plugin 'davidhalter/jedi-vim'

" :Pytest
Plugin 'alfredodeza/pytest.vim'

"` Relative line number
Plugin 'jeffkreeftmeijer/vim-numbertoggle'

""Languages
Plugin 'plasticboy/vim-markdown'
Plugin 'othree/html5.vim'
Plugin 'tpope/vim-sleuth'           
Plugin 'sheerun/vim-polyglot'       


""Interface
Plugin 'thaerkh/vim-workspace'
Plugin 'vim-airline/vim-airline'

""Themes
Plugin 'altercation/vim-colors-solarized'
"Plugin 'fenetikm/falcon'

"
" Transparent editing of gnupg-encrypted files
Plugin 'jamessan/vim-gnupg'
Plugin 'JuliaEditorSupport/julia-vim'
autocmd BufRead,BufNewFile *.jl set filetype=julia

Plugin 'lervag/vimtex'
Plugin 'tpope/vim-dispatch'
" let g:languagetool_cmd='/usr/bin/languagetool'
"
" Plugin 'szymonmaszke/vimpyter'
" Plugin 'goerz/jupytext.vim'
" let g:jupytext_enable = 1
"
Plugin 'ryanoasis/vim-devicons'

let g:pydocstring_doq_path='/home/dominik/miniconda3/bin/doq'

"map <Leader>j :Make<CR>
"let g:tex_flavor = "latex"
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
"set clipboard=unnamedplus
set number
"set tags=~/.mytags
set tabstop=4 shiftwidth=4 expandtab
set spelllang=en_us
"set tags=~/.mytags

"Prose Mode from https://statico.github.io/vim3.html
function! ProseMode()
  call goyo#execute(0, [])
  set spell noci nosi noai nolist noshowmode noshowcmd wrap
  set complete+=s
"  set bg=light
"  if !has('gui_running')
"    let g:solarized_termcolors=256
" endif
"  colors solarized
endfunction
"
"set shell=/bin/bash
"
command! ProseMode call ProseMode()
nmap \p :ProseMode<CR>

let g:ale_linters = {
\   'python': ['flake8'],
\}
"
" Use the global executable with a special name for flake8.
let g:ale_python_flake8_executable = '/usr/bin/flake8'
let g:ale_python_flake8_use_global = 1

" za http://blog.stelmisoft.pl/2010/sprawdzanie-pisowni-w-edytorze-tekstu-vim/
command! SpellPL setlocal spell spelllang=pl
command! SpellEN setlocal spell spelllang=en

nnoremap <C-p> :<C-u>FZF<CR>

function! g:Goyo_before()
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

function! g:Goyo_after()
  " Quit Vim if this is the only remaining buffer
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      qa!
    else
      qa
    endif
  endif
endfunction

let g:goyo_callbacks = [function('g:Goyo_before'), function('g:Goyo_after')]
" markdown folding https://vi.stackexchange.com/questions/9543/how-to-fold-markdown-using-the-built-in-markdown-mode 
let g:markdown_folding = 1

call vundle#end()

autocmd FileType make setlocal noexpandtab
nnoremap <leader>m :Make<CR>


set spelllang=pl,en_us
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" set statusline^=%{coc#status()}
filetype plugin indent on
colorscheme solarized

nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>


" https://vi.stackexchange.com/a/470
nnoremap <F5> :checktime<CR>

let g:pytest_test_dir = 'tests'
" Pytest
nmap <silent><Leader>y <Esc>:Pytest file<CR>
nmap <silent><Leader>t <Esc>:Pytest project<CR>
" let g:pytest_open_errors = 'current'

noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
