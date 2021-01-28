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
