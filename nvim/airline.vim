let g:airline#extensions#whitespace#enabled = 0
let g:airline_powerline_fonts = 1
let g:airline#extensions#tagbar#enabled = 1

set statusline^=%{ObsessionStatus()}

" function! g:ComboStatus()
" 	if !exists('g:combo')
" 		return ''
" 	endif
" 	return printf("%d|%-2d", g:best_combo, g:combo_counter)
" endfunction

" call airline#parts#define_function('foo', 'g:ComboStatus')

" Here is how you would define a part that is visible only if the window width
" greater than a minimum width.
" call airline#parts#define_minwidth('foo', 50)

" Parts can be configured to be visible conditionally.
  " call airline#parts#define_condition('foo', 'getcwd() =~ "Treść"')


" Now add part "foo" to section section airline_section_y:
" let g:airline_section_z = airline#section#create_right(['%{g:airline_section_z}', 'foo'])

" let g:airline_section_b = 'test %{g:ComboStatus()}'
