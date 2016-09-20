"----------------------------------------------------------------------"
" This file is part of vim-kitondro                                    "
" Copyright (c) 2016 Osman Koçak <kocakosm@gmail.com>                  "
" Licensed under the MIT license <https://opensource.org/licenses/MIT> "
"----------------------------------------------------------------------"

if exists("g:loaded_kitondro")
  finish
endif
let g:loaded_kitondro = 1

if !exists(':HideCursor') && !exists(':ShowCursor') && !exists(':ToggleCursor')
  command! HideCursor call kitondro#hide_cursor()
  command! ShowCursor call kitondro#show_cursor()
  command! ToggleCursor call kitondro#toggle_cursor()
endif

nnoremenu <script> Plugin.Kitondro.Hide\ Cursor :HideCursor<cr>
inoremenu <script> Plugin.Kitondro.Hide\ Cursor <c-o>:HideCursor<cr>
nnoremenu <script> Plugin.Kitondro.Show\ Cursor :ShowCursor<cr>
inoremenu <script> Plugin.Kitondro.Show\ Cursor <c-o>:ShowCursor<cr>
nnoremenu <script> Plugin.Kitondro.Toggle\ Cursor :ToggleCursor<cr>
inoremenu <script> Plugin.Kitondro.Toggle\ Cursor <c-o>:ToggleCursor<cr>
