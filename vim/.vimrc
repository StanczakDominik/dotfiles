set rtp+=~/.vim/bundle/vundle/
syntax on
call vundle#rc()
" Plugins {{{
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
Plugin 'tpope/vim-obsession'
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
Plugin 'reedes/vim-wordy'
Plugin 'reedes/vim-pencil'
" Plugin 'kana/vim-textobject-user'
" Plugin 'reedes/vim-textobj-quote'
" Plugin 'reedes/vim-textobj-sentence'
" augroup textobj_sentence
"   autocmd!
"   autocmd FileType markdown call textobj#sentence#init()
"   autocmd FileType textile call textobj#sentence#init()
" augroup END

Plugin 'mhinz/vim-startify'
source ~/.config/nvim/plugin-config/start-screen.vim

" augroup textobj_quote
"   autocmd!
"   autocmd FileType markdown call textobj#quote#init()
"   autocmd FileType textile call textobj#quote#init()
"   autocmd FileType text call textobj#quote#init({'educate': 0})
" augroup END


" augroup pencil
"   autocmd!
"   autocmd FileType markdown,mkd call pencil#init()
"   autocmd FileType text         call pencil#init()
" augroup END
"
" Automatic folding of python code
Plugin 'kalekundert/vim-coiled-snake'

" limit automatic fold updates
Plugin 'Konfekt/FastFold'

" "xgr
Plugin  'inkarkat/vim-ReplaceWithRegister'
" TODO Git stuff
Bundle 'tpope/vim-fugitive'       
Plugin 'tpope/vim-rhubarb'        

" Linter
" Plugin 'w0rp/ale'

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
Plugin 'airblade/vim-rooter'
Plugin 'jesseleite/vim-agriculture'

Plugin 'mhinz/vim-grepper'
Plugin 'vim-test/vim-test'
Plugin 'heavenshell/vim-pydocstring'

" VIM Jedi
Plugin 'davidhalter/jedi-vim'

" :Pytest
" Plugin 'alfredodeza/pytest.vim'

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
let g:airline#extensions#whitespace#enabled = 0

""Themes
Plugin 'altercation/vim-colors-solarized'
"Plugin 'fenetikm/falcon'

Plugin 'junegunn/limelight.vim'

"
" Transparent editing of gnupg-encrypted files
Plugin 'jamessan/vim-gnupg'
Plugin 'JuliaEditorSupport/julia-vim'
let g:latex_to_unicode_tab = 1
autocmd BufRead,BufNewFile *.jl set filetype=julia
autocmd BufRead,BufNewFile *.txt set filetype=markdown

Plugin 'lervag/vimtex'
Plugin 'tpope/vim-dispatch'

"
" Plugin 'szymonmaszke/vimpyter'
Plugin 'goerz/jupytext.vim'
"
Plugin 'ryanoasis/vim-devicons'

let g:pydocstring_doq_path='/home/dominik/miniconda3/bin/doq'

Plugin 'wannesm/wmgraphviz.vim'
" }}}

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

" Limelight {{{



" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240


" }}}
"
" Goyo {{{
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
" }}}
"Prose Mode from https://statico.github.io/vim3.html {{{
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
" }}}

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

" markdown folding https://vi.stackexchange.com/questions/9543/how-to-fold-markdown-using-the-built-in-markdown-mode 
let g:markdown_folding = 1

call vundle#end()

autocmd FileType make setlocal noexpandtab
nnoremap <leader>m :Make<CR>


set spelllang=pl,en_us
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" set statusline^=%{coc#status()}
set statusline^=%{ObsessionStatus()}
filetype plugin indent on
colorscheme solarized

nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>
let test#strategy = "dispatch"


" https://vi.stackexchange.com/a/470
nnoremap <F5> :checktime<CR>

let g:pytest_test_dir = 'tests'
" Pytest
nmap <silent><Leader>y <Esc>:Pytest file<CR>
nmap <silent><Leader>t <Esc>:Pytest project<CR>
" let g:pytest_open_errors = 'current'

" Disable arrows {{{
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
" }}}

"
"
" floating fzf as in https://www.reddit.com/r/neovim/comments/djmehv/im_probably_really_late_to_the_party_but_fzf_in_a/ {{{
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"
let $FZF_DEFAULT_OPTS=' --color=dark --color=fg:15,bg:-1,hl:1,fg+:#ffffff,bg+:0,hl+:1 --color=info:0,prompt:0,pointer:12,marker:4,spinner:11,header:-1 --layout=reverse  --margin=1,4'
let g:fzf_layout = { 'window': 'call FloatingFZF()' }

function! FloatingFZF()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')

  let height = float2nr(10)
  let width = float2nr(80)
  let horizontal = float2nr((&columns - width) / 2)
  let vertical = 1

  let opts = {
        \ 'relative': 'editor',
        \ 'row': vertical,
        \ 'col': horizontal,
        \ 'width': width,
        \ 'height': height,
        \ 'style': 'minimal'
        \ }

  call nvim_open_win(buf, v:true, opts)
endfunction

nnoremap <silent> <C-p> :call fzf#vim#files('.', {'options': '--prompt ""'})<CR>
nnoremap <silent> <leader>b :Buffers<CR>

" }}}
" folding as per https://dougblack.io/words/a-good-vimrc.html#organization
" vim:foldmethod=marker:foldlevel=0
