" markdown folding https://vi.stackexchange.com/questions/9543/how-to-fold-markdown-using-the-built-in-markdown-mode 
autocmd BufRead,BufNewFile *.txt set filetype=markdown

let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_autowrite = 1
let g:vim_markdown_edit_url_in = 'tab'



autocmd FileType markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>
" there are some defaults for image directory and image name, you can change them
" let g:mdip_imgdir = 'img'
" let g:mdip_imgname = 'image'

let g:wiki_root = '~/Notes/vimwiki'
let g:wiki_filetypes = ['wiki', 'md', 'markdown']
let g:wiki_global_load = 0
let g:wiki_link_target_type = 'md'
nnoremap <leader>/ /\<\><left><left>

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
au BufRead,BufNewFile *.md setlocal textwidth=80

autocmd FileType markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>
let g:mdip_imgdir = '_resources'
let g:mdip_imgname = 'image'


set suffixesadd+=.md
au FileType vimwiki set syntax=pandoc
let g:mkdx#settings     = {
            \ 'highlight': { 'enable': 1,
                            \ 'frontmatter': { 'yaml': 1, 'toml': 0, 'json': 0},
                            \},
            \ 'enter': { 'shift': 1 },
            \ 'links': {
                \ 'external': { 'enable': 1 },
                \ 'conceal': 1,
                \ },
            \ 'toc': { 'text': 'Table of Contents', 'update_on_write': 1 },
            \ 'fold': { 'enable': 1 } 
            \ }
let g:polyglot_disabled = ['markdown'] " for vim-polyglot users, it loads Plasticboy's markdown
                                       " plugin which unfortunately interferes with mkdx list indentation.
vnoremap <leader>wl :call mkdx#WrapText('v', '[[', ']]')<Cr>
