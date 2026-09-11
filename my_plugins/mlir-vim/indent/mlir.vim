" Vim indent file
" Language: MLIR

if exists('b:did_indent')
  finish
endif
let b:did_indent = 1

setlocal expandtab shiftwidth=2 softtabstop=2
setlocal indentkeys=0{,0},0),0],<:>,!^F,o,O,e
setlocal indentexpr=GetMLIRIndent()

let b:undo_indent = 'setlocal expandtab< shiftwidth< softtabstop< indentkeys< indentexpr<'

if exists('*GetMLIRIndent')
  finish
endif

function! s:IsCommentLine(lnum) abort
  let l:first = match(getline(a:lnum), '\S') + 1
  return l:first > 0
        \ && synIDattr(synID(a:lnum, l:first, 1), 'name') ==# 'mlirComment'
endfunction

function! s:MatchingOpenIndent(close) abort
  let l:pairs = {'}': ['{', '}'], ')': ['(', ')'], ']': ['\[', '\]']}
  let l:save_cursor = getpos('.')
  let l:column = match(getline(v:lnum), '\V' . a:close) + 1
  call cursor(v:lnum, l:column)
  let l:open_line = searchpair(l:pairs[a:close][0], '', l:pairs[a:close][1], 'bnW')
  call setpos('.', l:save_cursor)
  return l:open_line > 0 ? indent(l:open_line) : -1
endfunction

function! GetMLIRIndent() abort
  let l:line = getline(v:lnum)
  let l:close = matchstr(l:line, '^\s*\zs[][})]')
  if !empty(l:close)
    let l:matching_indent = s:MatchingOpenIndent(l:close)
    if l:matching_indent >= 0
      return l:matching_indent
    endif
  endif

  let l:previous = prevnonblank(v:lnum - 1)
  while l:previous > 0 && s:IsCommentLine(l:previous)
    let l:previous = prevnonblank(l:previous - 1)
  endwhile
  if l:previous == 0
    return 0
  endif

  let l:indent = indent(l:previous)
  let l:previous_line = getline(l:previous)
  if l:previous_line =~ '[{[(]\s*$'
        \ || l:previous_line =~ '^\s*\^[-A-Za-z$._0-9]\+.*:\s*$'
    let l:indent += shiftwidth()
  endif

  return l:indent
endfunction
