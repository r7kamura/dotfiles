if has('gui_macvim')
  set antialias
  set nobackup

  set guifont=Bitstream\ Vera\ Sans\ Mono:h18
  let g:Powerline_symbols = 'fancy'

  set showtabline=2
  set title
  set guioptions-=T                " hide menu bar
  set fuoptions=maxvert,maxhorz    " fill screen in full screen
  hi CursorIM guifg=NONE guibg=Red " colorize when using IME

  " colorscheme molokai
  colorscheme railscasts
endif
