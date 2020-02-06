scriptencoding utf-8
"----------------------------------------------------------------------"
" This file is part of vim-kitondro                                    "
" Copyright (c) 2016-2020 Osman Koçak <kocakosm@gmail.com>             "
" Licensed under the MIT license <https://opensource.org/licenses/MIT> "
"----------------------------------------------------------------------"

if exists('g:loaded_kitondro')
  finish
endif
let g:loaded_kitondro = 1

command! KitondroHideCursor call kitondro#hide_cursor()
command! KitondroShowCursor call kitondro#show_cursor()
command! KitondroToggleCursor call kitondro#toggle_cursor()
