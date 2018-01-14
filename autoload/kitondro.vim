"----------------------------------------------------------------------"
" This file is part of vim-kitondro                                    "
" Copyright (c) 2016-2018 Osman Koçak <kocakosm@gmail.com>             "
" Licensed under the MIT license <https://opensource.org/licenses/MIT> "
"----------------------------------------------------------------------"

let s:cursor_bg = 'NONE'
let s:cursor_fg = 'NONE'
let s:cursor_gui = 'NONE'
let s:gui_properties = ['bold', 'italic', 'reverse', 'inverse']
let s:gui_properties += ['standout', 'underline', 'undercurl']

function! s:get_cursor_highlight(key) abort
  if a:key ==? 'gui'
    let gui = []
    for k in s:gui_properties
      if s:get_cursor_highlight(k) !=? 'NONE'
        let gui += [k]
      endif
    endfor
    return empty(gui) ? 'NONE' : join(gui, ',')
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
  return [bg, fg, gui] !=? ['NONE', 'NONE', 'NONE']
endfunction

function! s:save_cursor_highlight() abort
  let s:cursor_bg = s:get_cursor_highlight('bg')
  let s:cursor_fg = s:get_cursor_highlight('fg')
  let s:cursor_gui = s:get_cursor_highlight('gui')
endfunction

function! s:hide_cursor() abort
  if s:is_cursor_visible()
    call s:save_cursor_highlight()
    call s:set_cursor_highlight('NONE', 'NONE', 'NONE')
  endif
endfunction

function! s:show_cursor() abort
  if !s:is_cursor_visible()
    if [s:cursor_bg, s:cursor_fg, s:cursor_gui] ==? ['NONE', 'NONE', 'NONE']
      if exists('g:colors_name')
        execute 'colorscheme ' . g:colors_name
      else
        call s:warn('Can''t figure out cursor''s highlight attributes')
      endif
    else
      call s:set_cursor_highlight(s:cursor_bg, s:cursor_fg, s:cursor_gui)
    endif
  endif
endfunction

function! s:toggle_cursor() abort
  if s:is_cursor_visible()
    call s:hide_cursor()
  else
    call s:show_cursor()
  endif
endfunction

function! s:run_if_has_gui(f) abort
  if has('gui_running')
    return a:f()
  else
    call s:warn('Only GUI versions of Vim are supported')
  endif
endfunction

function! s:warn(msg) abort
  echohl WarningMsg | echomsg '[kitondro] ' . a:msg | echohl None
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

if has('autocmd') && exists('##ColorScheme')
  augroup __kitondro__
    autocmd!
    autocmd ColorScheme * call <sid>save_cursor_highlight()
  augroup END
endif
