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
set t_Co=256
set t_Sf=e[3%dm                     " xterm-256color
set t_Sb=e[4%dm                     " xterm-256color
set expandtab                       " change tab into space
set tabstop=2                       " tab width
set softtabstop=2                   " tab width
set shiftwidth=2                    " tab width
set textwidth=0                     " prevent auto linebreak
set shiftround                      " round indent
set modelines=1                     " line num in :set
set number                          " show line num
set autoindent                      " auto indent
set cursorline                      " highlight cursor line
set clipboard+=unnamed              " clipboard <=> yank
set list                            " highlight space/tab at the end of line
set listchars=tab:^\ ,trail:~       " highlight space/tab at the end of line
set visualbell t_vb=                " kill beep flash
set t_vb=                           " kill beep sound
set laststatus=2
set formatoptions=q                 " disable auto-insert line feeds
set nofoldenable                    " disable auto-folding
set noswapfile                      " do not create .*.swp
if has("mouse")                     " use mouse
  set mouse=a
end
colorscheme railscasts

map j      gj
map k      gk
map <Up>   g<Up>
map <Down> g<Down>
map Y y$
map <F1> :CopyPath<CR><ESC>
map <F2> <Plug>(altr-back)
map <F3> <Plug>(altr-forward)
imap {} {}<Left>
imap [] []<Left>
imap () ()<Left>
imap <> <><Left>
imap "" ""<Left>
imap '' ''<Left>
nmap <ESC><ESC> :nohlsearch<CR><ESC>
nmap "" :%s/'/"/g<CR>
vnoremap < <gv
vnoremap > >gv
vnoremap <F4> :Alignta <<0 \ /1<CR>

au BufNewFile,BufRead *.md   set filetype=markdown
au BufNewFile,BufRead *.sass set filetype=sass
au BufNewFile,BufRead *.json set filetype=json


" vim-powerline
let g:Powerline_symbols = 'fancy'

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

" zencoding.vim
let g:user_zen_expandabbr_key = '<c-z>'
let g:user_zen_settings = {
\  'lang' : 'ja',
\  'indentation' : '  ',
\}

" gist.vim
let g:gist_clip_command = 'pbcopy'
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

" ctrlp.vim
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*.so,*.swp,*.swo

" vim-altr
call altr#remove_all()
call altr#define('lib/%.rb', 'spec/%_spec.rb', 'spec/libs/%_spec.rb')
call altr#define(
\  'app/decorators/%.rb',
\  'spec/decorators/%_spec.rb')
call altr#define(
\  'app/models/%.rb',
\  'spec/models/%_spec.rb')
call altr#define(
\ 'app/controllers/%_controller.rb',
\ 'spec/controllers/%_spec.rb',
\ 'spec/controllers/%_controller_spec.rb',
\ 'spec/requests/%_spec.rb',
\ 'spec/integration/%_spec.rb')
call altr#define(
\ 'app/helpers/%.rb',
\ 'spec/helpers/%_spec.rb')

let g:indent_guides_enable_on_vim_startup = 1

" for crontab
augroup CrontabForVim
  autocmd BufReadPre crontab.* setl nowritebackup
augroup END
