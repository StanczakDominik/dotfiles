let g:ale_linters = {
\   'python': ['flake8'],
\}
"
" Use the global executable with a special name for flake8.
let g:ale_python_flake8_executable = '/usr/bin/flake8'
let g:ale_python_flake8_use_global = 1

