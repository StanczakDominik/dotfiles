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

let g:wiki_root = '~/Notes/Professional'
let g:wiki_filetypes = ['md']
let g:wiki_link_extension = '.md'
let g:wiki_global_load = 0
let g:wiki_link_target_type = 'md'
let g:wiki_journal = {
      \ 'name': 'Osobiste/dziennik/daily',
      \ 'frequency': 'daily',
      \ 'date_format': {
      \   'daily' : '%Y-%m-%d',
      \   'weekly' : '%Y_w%V',
      \   'monthly' : '%Y_m%m',
      \ },
      \ 'index_use_journal_scheme': v:true,
      \}

function! TemplateFallback(context)
  call append(0, '# ' . a:context.name)
  call append(1, '')
  call append(2, 'Foobar')
endfunction

let g:wiki_templates = [
      \ { 'match_re': 'index',
      \   'source_filename': '/home/user/templates/index.md'},
      \ { 'match_re': 'dziennik\\/daily',
      \   'source_filename': 'Notes/dziennik/template_daily.md'},
      \ { 'match_func': {x -> v:true},
      \   'source_func': function('TemplateFallback')},
      \]

let g:wiki_zotero_root = '~/Zotero'
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
" au BufRead,BufNewFile *.md setlocal textwidth=80

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
