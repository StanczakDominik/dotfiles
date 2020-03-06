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

" TODO Linter, completion
" Plugin 'w0rp/ale'

" PyCharm style multiple cursors via <C-n>
" Plugin 'terryma/vim-multiple-cursors'

" TODO snippets
" Plugin 'sirver/ultisnips'

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

"
Plugin 'tpope/vim-surround'

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
let g:pydocstring_doq_path='/home/dominik/miniconda3/bin/doq'

Plugin 'neoclide/coc.nvim'

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
" markdown folding https://vi.stackexchange.com/questions/9543/how-to-fold-markdown-using-the-built-in-markdown-mode 
let g:markdown_folding = 1

call vundle#end()

autocmd FileType make setlocal noexpandtab
nnoremap <leader>m :Make<CR>


set spelllang=pl,en_us
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

set statusline^=%{coc#status()}
filetype plugin indent on
colorscheme solarized

nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>


" https://vi.stackexchange.com/a/470
nnoremap <F5> :checktime<CR>

" Start NERDTree
autocmd VimEnter * NERDTree
" Go to previous (last accessed) window.
autocmd VimEnter * wincmd p

let g:pytest_test_dir = 'tests'
" Pytest
nmap <silent><Leader>y <Esc>:Pytest file<CR>
nmap <silent><Leader>t <Esc>:Pytest project<CR>
" let g:pytest_open_errors = 'current'


" coc.vim
"
"" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
