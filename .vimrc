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
if has("mouse")                     " use mouse
  set mouse=a
end

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
vnoremap < <gv
vnoremap > >gv
vnoremap <F4> :Align =><CR>

au BufNewFile,BufRead *.md   set filetype=markdown
au BufNewFile,BufRead *.htn  set filetype=hatena
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

" align.vim
" let g:Align_xstrlen = 3

" zencoding.vim
let g:user_zen_expandabbr_key = '<c-z>'

" gist.vim
let g:gist_clip_command = 'pbcopy'
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

" ctrlp.vim
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*.so,*.swp,*.swo

" quickrun
let g:quickrun_config = {}
let g:quickrun_config['*'] = {'runner': 'vimproc'}
let g:quickrun_config['coffee'] = {'command' : 'coffee', 'exec' : ['%c -cbp %s']}

if strlen($rvm_bin_path)
  let g:quickrun_config['ruby'] = {'command': 'ruby', 'exec': '$rvm_bin_path/ruby %s', 'runner': 'vimproc'}
endif

" vim-altr
call altr#remove_all()
call altr#define('lib/%.rb', 'spec/%_spec.rb', 'spec/libs/%_spec.rb')
call altr#define(
\  'app/models/%.rb',
\  'spec/models/%_spec.rb',
\  'spec/factories/%s.rb')
call altr#define(
\ 'app/controllers/%_controller.rb',
\ 'spec/controllers/%_spec.rb',
\ 'spec/controllers/%_controller_spec.rb',
\ 'spec/requests/%_spec.rb',
\ 'spec/integration/%_spec.rb')
call altr#define(
\ 'app/helpers/%.rb',
\ 'spec/helpers/%_spec.rb')

set t_Co=256
colorscheme railscasts

let g:indent_guides_enable_on_vim_startup = 1

let g:user_zen_settings = {
\  'lang' : 'ja',
\  'indentation' : '  ',
\}

" Rename current file to given name
command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))

" autocmd CursorMovedI * :call vimproc#system_bg($HOME . "/bin/vim-key-sound.rb '" . getline('.')[col('.') - 2] . "'")

" Type tab key to insert <TAB> or complement a word depending on the cursor posiiton
function! InsertTabOrComplement()
  let col = col('.') - 1
  if col == 0 || getline('.')[col - 1] !~ '\k'
    return "\<TAB>"
  else
    return "\<C-N>"
  endif
endfunction
imap <S-tab> <c-r>=InsertTabOrComplement()<cr>
