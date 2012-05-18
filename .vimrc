syntax on
filetype on
filetype indent on
filetype plugin on

call pathogen#infect()

set nocompatible                    " Use Vim default instead of 100% vi compativility
set backspace=indent,eol,start      " more powerful backspacing
set nobackup                        " Don't keep a backup file
set viminfo=!,'50,<1000,s100,\"50   " read/write a .viminfo file, don't store more than
set history=100                     " keep 100 lines of command line history
set ruler                           " show the cursor position all the time
set t_Sf=e[3%dm                     " xterm-256color
set t_Sb=e[4%dm                     " xterm-256color
set expandtab                       " change tab into space
set tabstop=2                       " tab width
set softtabstop=2                   " tab width
set shiftwidth=2                    " tab width
set shiftround                      " round indent
set modelines=0                     " line num in :set
set number                          " show line num
set autoindent                      " auto indent
set clipboard+=unnamed              " clipboard <=> yank
set list                            " highlight space/tab at the end of line
set listchars=tab:^\ ,trail:~       " highlight space/tab at the end of line
set visualbell t_vb=                " kill beep flash
set t_vb=                           " kill beep sound
if has("mouse")                     " use mouse
  set mouse=a
end

vnoremap < <gv
vnoremap > >gv
imap {} {}<Left>
imap [] []<Left>
imap () ()<Left>
imap "" ""<Left>
imap '' ''<Left>
imap <> <><Left>
map  j      gj
map  k      gk
map  <Up>   g<Up>
map  <Down> g<Down>
nmap <ESC><ESC> :nohlsearch<CR><ESC>" ESCx2 => :nohlsearch
map Y       y$

au BufNewFile,BufRead *.md   set filetype=markdown
au BufNewFile,BufRead *.htn  set filetype=hatena
au BufNewFile,BufRead *.sass set filetype=sass
au BufNewFile,BufRead *.pm   set shiftwidth=4 tabstop=4 softtabstop=4
au BufNewFile,BufRead *.py   set shiftwidth=4 tabstop=4 softtabstop=4
au FileType perl             set shiftwidth=4 tabstop=4 softtabstop=4
au BufNewFile,BufRead *.t    set shiftwidth=4 tabstop=4 softtabstop=4
au BufNewFile,BufRead *.css  set shiftwidth=2 tabstop=2 softtabstop=2
au BufNewFile,BufRead *.erb  set shiftwidth=2 tabstop=2 softtabstop=2
au BufNewFile,BufRead *.tt   set filetype=tt2html shiftwidth=2 tabstop=2 softtabstop=2
au BufNewFile,BufRead *.html set filetype=tt2html shiftwidth=2 tabstop=2 softtabstop=2


" emphasis space at the end of line
" 末尾の半角スペースを
set list
set listchars=tab:^\ ,trail:~

" emphasis 2byte-space at the end of line
function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=underline ctermfg=darkgrey gui=underline guifg=darkgrey
endfunction
if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    autocmd ColorScheme       * call ZenkakuSpace()
    autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
  augroup END
  call ZenkakuSpace()
endif

" align.vim
let g:Align_xstrlen = 3

" zencoding.vim
let g:user_zen_expandabbr_key = '<c-z>'

" gist.vim
let g:gist_clip_command = 'pbcopy'
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

" ctrlp.vim
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*.so,*.swp,*.swo

" gjslint
autocmd FileType javascript :compiler gjslint
autocmd QuickfixCmdPost make copen

" csslint
autocmd FileType css compiler csslint

" quickrun
let g:quickrun_config = {}
let g:quickrun_config['coffee'] = {'command' : 'coffee', 'exec' : ['%c -cbp %s']}
