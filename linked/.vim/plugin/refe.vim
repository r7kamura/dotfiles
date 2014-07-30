" refe.vim
" Author: Yuichi Tateno <hotchpotch@NOSPAM@gmail.com>
" Last Change:  2007 Jun 12
" Version: 0.1.0, for Vim 7.0
" Licence: MIT Licence
"
" DESCRIPTION:
"  This plugin is ReFe Browser on Vim.
"
"  ReFe (http://i.loveruby.net/ja/prog/refe.html ) is Ruby reference manual
"  search tool for Japanese like Ri.
"
" ScreenCast:
"  http://rails2u.com/projects/refe.vim/screencast.html
"  
" ScreenShot:
"
" Install details: 
"  download refe.vba, and vimcommand: vim -c 'so %' refe.vba
"
" Help:
"  Please see refe.vim help
"  :h refe
"
" $Id: refe.vim 111 2007-01-17 11:10:40Z gorou $

if exists("g:loaded_refe")
  finish
endif
let g:loaded_refe = 1

if !exists('g:loaded_lookupfile')
  runtime plugin/lookupfile.vim
endif

if !exists('g:RefeCommand')
  let g:RefeCommand = 'refe'
endif

if !exists('g:RefeMinPatLength')
  let g:RefeMinPatLength = 3
endif

if !exists('g:RefeUseLookupFile')
  let g:RefeUseLookupFile = 1
endif

let s:RefeSNR = ''
function! s:SNR()
  if s:RefeSNR == ''
    let s:RefeSNR = matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSNR$')
  endif
  return s:RefeSNR
endfun

let g:RefeSNR = s:SNR()

function! s:ErrorMsg(msg)
  echohl ErrorMsg | echo a:msg | echohl NONE
endfun

let s:RefeStack = []

let s:RefeBufNo = -1
function! s:RefeViewBufShow()
  if s:RefeBufNo == -1 || s:RefeBufNo != bufnr('%')
    exec 'to sp' . '[Refe]'
    let s:RefeBufNo = bufnr('%')
  end
  setlocal nomodifiable
  setlocal nobuflisted 
  setlocal nonumber 
  setlocal noswapfile
  setlocal buftype=nofile
  setlocal bufhidden=delete
  setlocal noshowcmd
  setlocal nowrap 
  " setlocal foldmethod=syntax

  au BufHidden <buffer> call <SID>RefeClear()
endfunction

function! s:RefeClear()
  call s:ErrorMsg('call RefeClear')
  unlet! s:RefeStack
  let s:RefeStack = []
endfunction

let s:RefeCacheCompList = {}
function! s:RefeCompList(arg, ...)
  let option = '-s'
  if a:0 > 0
    let option = a:{1}
  endif

  let arg = s:RefeArgEscape(a:arg)

  let cmd_arg = option . ' ' . arg
  if !has_key(s:RefeCacheCompList, cmd_arg)
    let s:RefeCacheCompList[cmd_arg] = s:RefeCompListImpl(cmd_arg)
  endif

  return s:RefeCacheCompList[cmd_arg]
endfunction

function! s:RefeCompListImpl(arg)
  let result = s:RefeCmd(a:arg)
  if match(result, 'not match') == 0 
    return []
  else
    return split(result, '[\n ]\+')
  endif
endfunction

function! s:RefeCmd(arg)
  return system(g:RefeCommand . ' ' . a:arg)
endfunction

function! s:RefeRender(arg)
  silent! %g/\v.?/d_
  let arg = s:RefeArgEscape(a:arg)
  silent! put= s:RefeCmd(arg)
  call cursor(1, 1)
  d _
endfunction

function! s:RefeRenderList(arg)
  silent! %g/\v.?/d_
  for line in a:arg
    silent! put= line
  endfor
  call cursor(1, 1)
  d _
endfunction

function! s:RefeKeymapList()
  noremap <buffer> <silent> <CR> :call <SID>RefeListToView()<CR>
  noremap <buffer> <silent> o :call <SID>RefeListToView()<CR>
  call s:RefeKeymapCommon()
endfunction

function! s:RefeKeymap()
  silent! nunmap <buffer> <silent> <CR>
  call s:RefeKeymapCommon()
  noremap <buffer> <silent> o :Refe <cword><CR>
endfunction

function! s:RefeKeymapCommon()
  noremap <buffer> <silent> q :call <SID>RefeClose()<CR>
  noremap <buffer> <silent> <C-C> :call <SID>RefeClose()<CR>
  noremap <buffer> <silent> B :call <SID>RefeRestoreStack()<CR>
  noremap <buffer> <silent> K :Refe <cword><CR>
  noremap <buffer> <silent> - :call <SID>RefeClassView()<CR>
  if s:RefeIsLookup() == 1
    noremap <buffer> <silent> <C-K> :Refe<CR>
    noremap <buffer> <silent> s :Refe <CR>
  else
    noremap <buffer> <silent> <C-K> :Refe 
    noremap <buffer> <silent> s :Refe 
  end
endfunction

function! s:RefeHelpKeymap()
  echomsg 'q\, <C-C>    close'
  echomsg 'B           back page'
  echomsg 'o\, K        open under cursor word'
  echomsg '-           current/parent class'
  echomsg 's\, <C-K>    search'
endfunction

function! s:RefeListToView()
  call s:RefeView(getline('.'))
endfunction

function! s:RefeClose()
  close
endfunction

function! s:RefeSyntaxList()
  syn clear
  setlocal ft=refelist

  unlet! b:current_syntax
  syn match refeListMethod ".*$"
  syn match refeSep "[:.#]"
  syn match refeListClass "\v\u\w*"

  hi def link refeListClass rubyClass
  hi def link refeListMethod rubyFunction
  hi def link refeSep rubyOperator
  let b:current_syntax = "refelist"
endfunction

function! s:RefeIsClass()
  if match(getline(1), '====') == 0
    return 1
  else
    return 0
  endif
endfunction

function! s:RefeSyntax()
  syn clear
  setlocal ft=refe

  unlet! b:current_syntax
  syn include @refeRuby syntax/ruby.vim

  if s:RefeIsClass()
    " class/module
    silent! %s/^----/\r----/g
    call cursor(1, 1)
    syntax region refeRubyCodeBlock start=+^  + end=+$+ contains=@refeRuby
    syntax region refeClass matchgroup=refeLine start=+^\z(====\)+ end=+\z1$+ keepend
    syntax region refeClass matchgroup=refeLine start=+^\z(----\)+ end=+\z1$+ keepend
  else
    syntax region refeRubyCodeBlock start=+^      + end=+$+ contains=@refeRuby
    syntax region refeRubyCodeInline matchgroup=refeLine start=+^---+ end=+$+ contains=@refeRuby oneline
  end
  "syntax match refeString '^\s*\*'
  "syntax match refeFunction '\([]\|[]=\|==\|===\|=\?\|=~\)'

  syntax match refeClassMethod '\v[a-zA-Z_][A-Za-z0-9_:#]*[?!=~]?' contains=@refeClassSepMethod
  syntax cluster refeClassSepMethod contains=refe_class_class,refe_class_method,refe_class_sep

  syn match refe_class_sep '\v(::|#)' contained nextgroup=ref_class_class,ref_class_method
  syn match refe_class_class '\v\u\w+' contained nextgroup=refe_class_sep
  syn match refe_class_method '\v[_a-z][A-Za-z0-9_]+[?!=~]?' contained nextgroup=refe_class_sep
  
  hi def link refeString rubyString
  hi def link refeClass rubyClass
  hi def link refeFunction rubyFunction
  hi def link refeLine rubyOperator

  hi def link refe_class_sep rubyOperator
  hi def link refe_class_sep_sharp rubyOperator
  hi def link refe_class_class rubyClass
  hi def link refe_class_method rubyFunction

  let b:current_syntax = "refe"
endfunction

function! s:RefeClassView()
  let arg = s:RefeClassViewName()
  if len(arg) > 0
    call s:RefeExec(0, arg)
  endif
endfunction

function! s:RefeClassName()
  let lineres = matchlist(getline(1), '^\v\=\=\=\= (\u[A-Za-z0-9_:]*) \=\=\=\=$')
  if !empty(lineres)
     return lineres[1]
  else
    return ''
  endif
endfunction

function! s:RefeClassViewName()
  let str = getline(1)
  let className = s:RefeClassName()
  if className
    let str = className
  endif

  let res = matchlist(str, '^\v((\u[A-Za-z0-9_:#]*)(::|#|\.))\w*[\?!=~]?$')
  if !empty(res)
    return res[2]
  else
    return ''
  endif
endfunction

let s:RefeRubyOtherMethods = ['%', '&', '*', '+', '-', '<<', '<=>', '==', '[]', '[]=', '|', '<=', '=~', '>', '>=']

function! s:RefeExpandCword()
  if &filetype !=# 'refe'
    return expand('<cword>')
  endif

  if match(expand('<cWORD>'), '^\v((\u[A-Za-z0-9_:#]*)(::|#|\.))?\w*[\?!=~]?$') >= 0 || 
     \ index(s:RefeRubyOtherMethods, expand('<cWORD>')) >= 0
    let cword = expand('<cWORD>')
  else
    let cword = expand('<cword>')
  endif

  if s:RefeIsClass()
    let pos = getpos('.')
    let line = pos[1]

    if search('---- Instance methods (inherited) ----', 'bn') < line
      " none
    elseif search('---- Singleton methods (inherited) ----', 'bn') < line
      " none
    elseif search('---- Instance methods ----', 'bn') < line
      " instance method
      let cword = s:RefeClassName() . '#' . cword
    elseif search('---- Singleton methods ----', 'bn') < line
      " singleton method
      let cword = s:RefeClassName() . '.' . cword
    endif
  endif

  return cword
endfunction

function! s:RefeExec(bang, ...)
  let args = join(a:000, ' ')
  if args ==# '<cword>' " FIXME
    let args = s:RefeExpandCword()
  endif

  let comp = s:RefeCompList(args)
  if len(comp) == 0
    if s:RefeIsLookup() == 0
      " none
      call s:ErrorMsg('No Match')
    else
      call s:RefeLookup(args)
    endif
  elseif len(comp) == 1
    call s:RefeView(args)
  else
    if s:RefeIsLookup() == 0
      call s:RefeView(comp, 'List')
    else
      call s:RefeLookup(args)
    endif
  end
endfunction

let s:RefeCurrentStack = []

function! s:RefeRestoreStack()
  if len(s:RefeStack) > 0
    if !empty(s:RefeCurrentStack)
      let s:RefeCurrentStack = []
    endif

    let stack = remove(s:RefeStack, -1)
    call call(s:SNR() . 'Refe' . stack[0], stack[1])
  else
    call s:ErrorMsg('No stack')
  endif
endfunction

function! s:RefeAddStack(arg)
  call s:RefeAppendCurrentStack()
  let s:RefeCurrentStack = a:arg
endfunction

function! s:RefeAppendCurrentStack()
  if len(s:RefeCurrentStack) > 0
    call add(s:RefeStack, s:RefeCurrentStack)
    let s:RefeCurrentStack = []
  endif
endfunction

function! s:RefeIsLookup()
  if exists('g:loaded_lookupfile') && g:RefeUseLookupFile
    return 1
  else
    return 0
  endif
endfunction

function! s:RefeLookup(arg)
  call s:RefeSaveLookup('LookupFunc')
  call s:RefeSaveLookup('LookupNotifyFunc')
  call s:RefeSaveLookup('LookupAcceptFunc')
  call s:RefeSaveLookup('MinPatLength')
  let g:LookupFile_MinPatLength = g:RefeMinPatLength
  let g:LookupFile_LookupFunc = function(s:SNR() . 'RefeComplete')
  let g:LookupFile_LookupAcceptFunc = function(s:SNR() . 'RefeLookupView')
  let g:LookupFile_LookupNotifyFunc = function(s:SNR() . 'RefeLookupRestore')

  exe 'LookupFile ' . a:arg 
  aug LookupFileReset
    au BufHidden <buffer> call <SID>RefeLookupRestore()
  aug END
endfunction

let s:RefeSaveLookupDict = {}
function! s:RefeSaveLookup(key)
  if !has_key(s:RefeSaveLookupDict, a:key)
    let s:RefeSaveLookupDict[a:key] = g:LookupFile_{a:key}
    unlet! g:LookupFile_{a:key}
  endif
endfunction

function! s:RefeLookupRestore()
  for key in keys(s:RefeSaveLookupDict)
    unlet! g:LookupFile_{key}
    let g:LookupFile_{key} = s:RefeSaveLookupDict[key]
    unlet! s:RefeSaveLookupDict[key]
  endfor
endfunction

function! s:RefeLookupView(...)
  call g:LookupFile_LookupNotifyFunc()
  let arg = getline('.')
  let result = s:RefeComplete(arg)
  if len(result) > 2
    let arg = result[0]
  endif
  return "\<C-Y>\<Esc>:AddPattern\<CR>\<Esc>:call lookupfile#CloseWindow()\<CR>:Refe " . arg . "\<CR>"
endfunction

function! s:RefeView(arg, ...)
  let mode = ''
  let stack = 0

  if len(a:000) > 0
    let mode = a:1
  endif

  if stack == 0
    call s:RefeAddStack(['View', [a:arg, mode]])
  endif
  call s:RefeViewBufShow()
  setlocal modifiable
  call s:RefeRender{mode}(a:arg)
  call s:RefeKeymap{mode}()
  call s:RefeSyntax{mode}()
  setlocal nomodifiable
endfunction

function! s:shellescape(arg)
  if has('win32') || has('win16') || has('win64') || has('dos32') || has('win95')
    return '"' . substitute(a:arg, '"', '""', 'g') . '"'
  else
    return "'" . substitute(a:arg, "'", "'\\\\''", 'g') . "'"
  endif
endfunction

function! s:RefeArgEscape(arg)
  let arg = a:arg
  if match(arg, "^'") == -1
    let args = split(arg, '\s')
    let arg = ''
    for ar in args
      let arg .= s:shellescape(ar) . ' '
    endfor
  endif
  return arg
endfunction

function! s:RefeComplete(arg, ...)
  return s:RefeCompList(a:arg)
endfunction

command! -nargs=* -bang -complete=customlist,s:RefeComplete Refe :call s:RefeExec(<bang>0,<f-args>)

