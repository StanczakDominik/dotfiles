set rtp+=~/.vim/bundle/vundle/
syntax on
call vundle#rc()

Bundle 'gmarik/vundle'
Plugin 'junegunn/goyo.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-commentary'
Plugin 'scrooloose/nerdtree'
Plugin 'ervandew/supertab'
Plugin 'prakashdanish/vimport'
Plugin 'reedes/vim-pencil'
Plugin 'kalekundert/vim-coiled-snake'
Plugin 'Konfekt/FastFold'
Bundle 'tpope/vim-fugitive'       
Plugin 'w0rp/ale'
Plugin 'terryma/vim-multiple-cursors'
" Plugin 'sirver/ultisnips'
Plugin 'christoomey/vim-tmux-navigator'
" Plugin 'lervag/wiki.vim'

"Functionality
Plugin 'junegunn/fzf'      
Plugin 'junegunn/fzf.vim'
Plugin 'mhinz/vim-grepper'
Plugin 'janko/vim-test'
Plugin 'heavenshell/vim-pydocstring'

""Languages
Plugin 'plasticboy/vim-markdown'
Plugin 'othree/html5.vim'
Plugin 'tpope/vim-sleuth'           
Plugin 'sheerun/vim-polyglot'       
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax' 


""Interface
Plugin 'thaerkh/vim-workspace'
Plugin 'vim-airline/vim-airline'

""Themes
Plugin 'altercation/vim-colors-solarized'
"Plugin 'fenetikm/falcon'
"Plugin 'tpope/vim-rhubarb'        
Plugin 'tpope/vim-surround'
Plugin 'jamessan/vim-gnupg'
Plugin 'JuliaEditorSupport/julia-vim'
autocmd BufRead,BufNewFile *.jl set filetype=julia
" Plugin 'ActivityWatch/aw-watcher-vim'

"Plugin 'majutsushi/tagbar'
"Plugin 'tmhedberg/SimpylFold'
""Plugin 'Valloric/YouCompleteMe'
""vim-ultisnips?
""vim-taglist?
""vim-supertab?
""vim-seti?
""vim-rails?
""vim-project
""vim-nerdcommenter
""vim-jedi
Plugin 'lervag/vimtex'
"Plugin 'tpope/vim-commentary'       
"Plugin 'tpope/vim-unimpaired'       
"Plugin 'w0rp/ale'           
"Plugin 'mileszs/ack.vim'    
Plugin 'tpope/vim-dispatch'
"Plugin 'morhetz/gruvbox'
" Plugin 'szymonmaszke/vimpyter'
" Plugin 'Eluminae/vim-LanguageTool'
" let g:languagetool_cmd='/usr/bin/languagetool'
" Plugin 'goerz/jupytext.vim'
" let g:jupytext_enable = 1


Plugin 'neoclide/coc.nvim'

"let g:syntastic_always_populate_loc_list = 1
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
nmap <Leader>tx <Plug>VimwikiToggleRejectedListItem
nmap <Leader>vwr <Plug>Vimwiki2HTMLBrowse
nmap <Leader>vwb <Plug>Vimwiki2HTML

" markdown folding https://vi.stackexchange.com/questions/9543/how-to-fold-markdown-using-the-built-in-markdown-mode 
let g:markdown_folding = 1

Plugin 'vimwiki/vimwiki'
call vundle#end()
let g:vimwiki_list = [
  \ {'path': '$HOME/vimwiki',
  \ 'syntax': 'markdown',
  \ 'ext': '.md',
  \ },
  \ {'path': '$HOME/vimwiki_private',
  \ 'template_path': '$HOME/vimwiki_private/templates',
  \ 'path_html': '$HOME/vimwiki_private/public/',
  \ 'template_default': 'default',
  \ 'auto_tags': 1,
  \ 'template_ext': '.html'}]

autocmd FileType make setlocal noexpandtab
nnoremap <leader>m :Make<CR>


set spelllang=pl,en_us
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

function! g:TestFunction()
    let l:bar = substitute(@%, ".md", ".html", "")
    echo 
    silent execute printf("!google-chrome-stable public/%s", l:bar)
endfunction

nnoremap <leader>v :call TestFunction()<CR>
set statusline^=%{coc#status()}
filetype plugin indent on
" colorscheme solarized
