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

" for crontab
augroup CrontabForVim
  autocmd BufReadPre crontab.* setl nowritebackup
augroup END

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


" For CRuby
function! s:CRuby_setup()
  setlocal tabstop=8 softtabstop=4 shiftwidth=4 noexpandtab
  syntax keyword cType VALUE ID RUBY_DATA_FUNC BDIGIT BDIGIT_DBL BDIGIT_DBL_SIGNED ruby_glob_func
  syntax keyword cType rb_global_variable
  syntax keyword cType rb_classext_t rb_data_type_t
  syntax keyword cType rb_gvar_getter_t rb_gvar_setter_t rb_gvar_marker_t
  syntax keyword cType rb_encoding rb_transcoding rb_econv_t rb_econv_elem_t rb_econv_result_t
  syntax keyword cType RBasic RObject RClass RFloat RString RArray RRegexp RHash RFile RRational RComplex RData RTypedData RStruct RBignum
  syntax keyword cType st_table st_data
  syntax match   cType display "\<\(RUBY_\)\?T_\(OBJECT\|CLASS\|MODULE\|FLOAT\|STRING\|REGEXP\|ARRAY\|HASH\|STRUCT\|BIGNUM\|FILE\|DATA\|MATCH\|COMPLEX\|RATIONAL\|NIL\|TRUE\|FALSE\|SYMBOL\|FIXNUM\|UNDEF\|NODE\|ICLASS\|ZOMBIE\)\>"
  syntax keyword cStatement ANYARGS NORETURN PRINTF_ARGS
  syntax keyword cStorageClass RUBY_EXTERN
  syntax keyword cOperator IMMEDIATE_P SPECIAL_CONST_P BUILTIN_TYPE SYMBOL_P FIXNUM_P NIL_P RTEST CLASS_OF
  syntax keyword cOperator INT2FIX UINT2NUM LONG2FIX ULONG2NUM LL2NUM ULL2NUM OFFT2NUM SIZET2NUM SSIZET2NUM
  syntax keyword cOperator NUM2LONG NUM2ULONG FIX2INT NUM2INT NUM2UINT FIX2UINT
  syntax keyword cOperator NUM2LL NUM2ULL NUM2OFFT NUM2SIZET NUM2SSIZET NUM2DBL NUM2CHR CHR2FIX
  syntax keyword cOperator NEWOBJ OBJSETUP CLONESETUP DUPSETUP
  syntax keyword cOperator PIDT2NUM NUM2PIDT
  syntax keyword cOperator UIDT2NUM NUM2UIDT
  syntax keyword cOperator GIDT2NUM NUM2GIDT
  syntax keyword cOperator FIX2LONG FIX2ULONG
  syntax keyword cOperator POSFIXABLE NEGFIXABLE
  syntax keyword cOperator ID2SYM SYM2ID
  syntax keyword cOperator RSHIFT BUILTIN_TYPE TYPE
  syntax keyword cOperator RB_GC_GUARD_PTR RB_GC_GUARD
  syntax keyword cOperator Check_Type
  syntax keyword cOperator StringValue StringValuePtr StringValueCPtr
  syntax keyword cOperator SafeStringValue Check_SafeStr
  syntax keyword cOperator ExportStringValue
  syntax keyword cOperator FilePathValue
  syntax keyword cOperator FilePathStringValue
  syntax keyword cOperator ALLOC ALLOC_N REALLOC_N ALLOCA_N MEMZERO MEMCPY MEMMOVE MEMCMP
  syntax keyword cOperator RARRAY RARRAY_LEN RARRAY_PTR RARRAY_LENINT
  syntax keyword cOperator RBIGNUM RBIGNUM_POSITIVE_P RBIGNUM_NEGATIVE_P RBIGNUM_LEN RBIGNUM_DIGITS
  syntax keyword cOperator Data_Wrap_Struct Data_Make_Struct Data_Get_Struct
  syntax keyword cOperator TypedData_Wrap_Struct TypedData_Make_Struct TypedData_Get_Struct

  syntax keyword cConstant Qtrue Qfalse Qnil Qundef
  syntax keyword cConstant IMMEDIATE_MASK FIXNUM_FLAG SYMBOL_FLAG

  " for bignum.c
  syntax keyword cOperator BDIGITS BIGUP BIGDN BIGLO BIGZEROP
  syntax keyword cConstant BITPERDIG BIGRAD DIGSPERLONG DIGSPERLL BDIGMAX
endfunction

function! s:CRuby_ext_setup()
  let dirname = expand("%:h")
  let extconf = dirname . "/extconf.rb"
  if filereadable(extconf)
    call s:CRuby_setup()
  endif
endfunction

augroup CRuby
  autocmd!
  autocmd BufWinEnter,BufNewFile ~/Dropbox/src/ruby/*.[chy] call s:CRuby_setup()
  autocmd BufWinEnter,BufNewFile *.{c,cc,cpp,h,hh,hpp} call s:CRuby_ext_setup()
augroup END
