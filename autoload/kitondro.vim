"----------------------------------------------------------------------"
" This file is part of vim-kitondro                                    "
" Copyright (c) 2016 Osman Koçak <kocakosm@gmail.com>                  "
" Licensed under the MIT license <https://opensource.org/licenses/MIT> "
"----------------------------------------------------------------------"

let s:cursor_bg = 'NONE'
let s:cursor_fg = 'NONE'
let s:cursor_gui = 'NONE'
let s:gui_properties = ['bold', 'italic', 'reverse', 'inverse']
let s:gui_properties += ['standout', 'underline', 'undercurl']

function! s:get_cursor_highlight(key) abort
  if a:key == 'gui'
    let gui = []
    for k in s:gui_properties
      if s:get_cursor_highlight(k) != 'NONE'
        let gui += [k]
      endif
    endfor
    return len(gui) == 0 ? 'NONE' : join(gui, ',')
  endif
  let arg = synIDattr(synIDtrans(hlID('Cursor')), a:key)
  return (arg == -1 || arg == '') ? 'NONE' : arg
endfunction

function! s:set_cursor_highlight(bg, fg, gui) abort
  execute 'hi Cursor guibg=' . a:bg . ' guifg=' . a:fg . ' gui=' . a:gui
endfunction

function! s:is_cursor_visible() abort
  let bg = s:get_cursor_highlight('bg')
  let fg = s:get_cursor_highlight('fg')
  let gui = s:get_cursor_highlight('gui')
  return !(bg == 'NONE' && fg == 'NONE' && gui == 'NONE')
endfunction

function! s:hide_cursor() abort
  if s:is_cursor_visible()
    let s:cursor_bg = s:get_cursor_highlight('bg')
    let s:cursor_fg = s:get_cursor_highlight('fg')
    let s:cursor_gui = s:get_cursor_highlight('gui')
    call s:set_cursor_highlight('NONE', 'NONE', 'NONE')
  endif
endfunction

function! s:show_cursor() abort
  if !s:is_cursor_visible()
    call s:set_cursor_highlight(s:cursor_bg, s:cursor_fg, s:cursor_gui)
  endif
endfunction

function! s:toggle_cursor() abort
  if s:is_cursor_visible()
    call kitondro#hide_cursor()
  else
    call kitondro#show_cursor()
  endif
endfunction

function! s:run_if_has_gui(f) abort
  if has('gui_running')
    return a:f()
  else
    call s:warn('vim-kitondro only supports GUI versions of Vim')
  endif
endfunction

function! s:warn(msg) abort
  echohl WarningMsg | echomsg a:msg | echohl None
endfunction

function! kitondro#is_cursor_visible() abort
  return s:run_if_has_gui(function('s:is_cursor_visible'))
endfunction

function! kitondro#hide_cursor() abort
  call s:run_if_has_gui(function('s:hide_cursor'))
endfunction

function! kitondro#show_cursor() abort
  call s:run_if_has_gui(function('s:show_cursor'))
endfunction

function! kitondro#toggle_cursor() abort
  call s:run_if_has_gui(function('s:toggle_cursor'))
endfunction
