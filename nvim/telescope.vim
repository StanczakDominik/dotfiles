" Find files using Telescope command-line sugar.

lua << EOF
-- Compe setup
require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')
EOF

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <C-p> :<C-u>Telescope find_files<Cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <C-G> :Telescope grep_string<CR>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <silent> <leader>b :Telescope buffers<CR>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <silent><leader>g :Telescope git_files<CR>


