" https://gist.github.com/1290007
if exists('current_compiler')
  finish
endif
let current_compiler = 'csslint'

if exists(":CompilerSet") != 2 " older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo-=C

CompilerSet makeprg=csslint\ --format=compact\ %
CompilerSet errorformat=%A%f:\ line\ %l\\,\ col\ %c\\,\ %m

let &cpo = s:cpo_save
unlet s:cpo_save
