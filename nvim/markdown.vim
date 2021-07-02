" markdown folding https://vi.stackexchange.com/questions/9543/how-to-fold-markdown-using-the-built-in-markdown-mode 
autocmd BufRead,BufNewFile *.txt set filetype=markdown
let g:markdown_folding = 1

let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_autowrite = 1
let g:vim_markdown_edit_url_in = 'tab'
