"----------------------------------------------------------------------"
" This file is part of vim-kitondro                                    "
" Copyright (c) 2016 Osman Koçak <kocakosm@gmail.com>                  "
" Licensed under the MIT license <https://opensource.org/licenses/MIT> "
"----------------------------------------------------------------------"

if exists("g:loaded_kitondro")
  finish
endif
let g:loaded_kitondro = 1

let s:save_cpo = &cpo
set cpo&vim

if !exists(':HideCursor') && !exists(':ShowCursor') && !exists(':ToggleCursor')
  command! HideCursor call kitondro#hide_cursor()
  command! ShowCursor call kitondro#show_cursor()
  command! ToggleCursor call kitondro#toggle_cursor()
endif

function! s:create_menu_entry(name, target) abort
  execute 'nnoremenu <script> <silent> '
        \ . 'Plugin.Kitondro.' . a:name . ' :call ' . a:target . '<cr>'
  execute 'inoremenu <script> <silent> '
        \ . 'Plugin.Kitondro.' . a:name . ' <c-o>:call ' . a:target . '<cr>'
endfunction

call s:create_menu_entry('Hide\ Cursor', 'kitondro#hide_cursor()')
call s:create_menu_entry('Show\ Cursor', 'kitondro#show_cursor()')
call s:create_menu_entry('Toggle\ Cursor', 'kitondro#toggle_cursor()')

let &cpo = s:save_cpo
unlet s:save_cpo
