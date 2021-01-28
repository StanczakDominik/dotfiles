let g:startify_lists = [
          \ { 'type': 'files',     'header': ['   Files']            },
          \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
          \ { 'type': 'sessions',  'header': ['   Sessions']       },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ ]
let g:startify_session_dir = '~/.config/nvim/session'

let g:startify_bookmarks = [
            \ { 'i': '~/.vimrc' },
            \ { 'z': '~/.zshrc' },
            \ { 'b': '~/Code/beeminder/beeminder.py' },
            \ { 's': '~/Code/sc2replayhandler/sc2replayhandler.py' },
            \ { 'P': '~/Code/PlasmaPy' },
            \ '~/Writing',
            \ '~/Code',
            \ ]
let g:startify_session_autoload = 1

let g:startify_session_delete_buffers = 1

let g:startify_fortune_use_unicode = 1
let g:startify_session_persistence = 1
