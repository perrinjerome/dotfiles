map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

imap <C-k> <Esc>c$
imap <C-a> <Esc>I
imap <C-e> <ESC>A
map <C-Tab> <C-W>w
imap <C-Tab> <C-O><C-W>w
cmap <C-Tab> <C-C><C-Tab>

" Some macros to manage the buffer of vim
map <F2> :bp<C-M>
map <F3> :bn<C-M>
map <F1> p<C-M>:wp<C-M>:bn<C-M>
map <F1> p<C-M>:wp<C-M>:bn<C-M>
map <F4> :SVNDiff<C-M>
let SVNCommandDiffOpt= "x '-up'"

" map <F7> :bd<C-M>

" remape esc
cmap <C-j> <Esc>
imap <C-j> <Esc>

set nocompatible
set backspace=indent,eol,start
set autoindent
set nobackup 
set autoread 
"set showmode
set showcmd
set laststatus=2

set ignorecase           " be case insensitive on searches
set smartcase            " but do be case sensitive on searches with capital letters

set viminfo='100,f1

set incsearch
set hlsearch

set rulerformat=%55(%{strftime('%a\ %b\ %e\ %I:%M\ %p')}\ %5L,%-6(%c%V%)\ %P%)
set ruler

"runtime plugin/py-function-signature.vim
"runtime plugin/python_check_syntax.vim
runtime plugin/pythonhelper.vim
if !exists("*TagInStatusLine")
  function TagInStatusLine()
    return ''
  endfunction
endif
if !exists("*haslocaldir")
  function! HasLocalDir()
    return ''
  endfunction
else
  function! HasLocalDir()
    if haslocaldir()
      return '[lcd]'
    endif
    return ''
  endfunction
endif


"set rulerformat=%40(%f\ %)%=%12(%l,%v%)\ %P
"set statusline=%<%f\ %h%m%r%=%-10.(%l,%v%)\ %P
set statusline=%<%f\ %h%m%r%=%-10.(%l,%v%)\ %P

set statusline=                 " my status line contains:
set statusline+=%n:             " - buffer number, followed by a colon
set statusline+=%<%f            " - relative filename, truncated from the left
set statusline+=\               " - a space
set statusline+=%h              " - [Help] if this is a help buffer
set statusline+=%m              " - [+] if modified, [-] if not modifiable
set statusline+=%r              " - [RO] if readonly
set statusline+=%2*%{HasLocalDir()}%*           " [lcd] if :lcd has been used
set statusline+=\               " - a space
set statusline+=%1*%{TagInStatusLine()}%*       " [current class/function]
set statusline+=\               " - a space
set statusline+=%=              " - right-align the rest
set statusline+=%-10.(%l,%c%V%) " - line,column[-virtual column]
set statusline+=\               " - a space
set statusline+=%4L             " - total number of lines in buffer
set statusline+=\               " - a space
set statusline+=%P              " - position in buffer as percentage


set background=dark

set nopaste
"set softtabstop=2
set suffixes=.bak,~,.swp,.pyc

"vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>


" remaps 
:nmap <F1> :echo<CR> 
:imap <F1> <C-o>:echo<CR> 


if has("autocmd")
  filetype plugin on
endif 

augroup filetypedetect
au BufNewFile,BufRead *.stx	setf stx
augroup END

set noerrorbells
set visualbell
set t_vb=


set softtabstop=2
set shiftwidth=2
set expandtab

set tw=79
setl ff=unix
set sm

let python_highlight_all = 1
"autocmd FileType python set omnifunc=pythoncomplete#Complete
syntax on


" Filetypes
au! BufRead,BufNewFile /tmp/cad*  set filetype=python
au! BufRead,BufNewFile *.dtml  set filetype=html
au! BufRead,BufNewFile *.pt  set filetype=xml
au! BufRead,BufNewFile *.zpt  set filetype=xml

" And corresponding bindings
au BufRead,BufNewFile *.pt  map <F5> :!galeon %<CR>
au BufRead,BufNewFile *.zpt  map <F5> :!galeon %<CR>
au BufRead,BufNewFile *.dtml  map <F5> :!galeon %<CR>
au BufRead,BufNewFile *.html  map <F5> :!galeon %<CR>
au BufRead,BufNewFile *.htm  map <F5> :!galeon %<CR>

au BufNewFile,BufRead *.py   map <F5> :w <CR> :!clear <CR> :!python %<CR>
au BufNewFile,BufRead *.py   map <F11> :!pyflakes %<CR>
"au BufNewFile,BufRead *.py   set foldmethod=indent
au BufNewFile,BufRead *.py   map <F10> :!mpylint --report=n %<CR>

au BufRead,BufNewFile *.tex  map <F5> :!latex %<CR>
au BufRead,BufNewFile *.tex  map <F6> :!bibtex rapport<CR>
au BufRead,BufNewFile *.tex  map <F7> :!pdflatex %<CR>

au BufRead,BufNewFile */bt/*  set noeol binary

au BufRead,BufNewFile *.po  map <F9> :!curl -u ERP5TypeTestCase: -F file=@% -F lang=fr http://localhost:9089/erp5/Localizer/erp5_ui/manage_import<CR>
au BufRead,BufNewFile *.po  map <F10> :!curl -u zope:zope -F file=@% -F lang=fr http://localhost:18080/erp5/Localizer/erp5_content/manage_import<CR>


" au BufRead,BufNewFile buildout.cfg  map <F4> :!python -S bin/buildout<CR>


au BufRead *Test.stx map <F5> :!python.local RestTestSuite.py %<CR>
au BufNewFile,BufRead /tmp/sql* set syntax=sql

" XML
let g:xml_syntax_folding = 1 
map <S-F6> :set filetype=xml<CR>:set foldmethod=syntax<CR>:colors peachpuff<CR> 
au FileType content.xml exe "%!xmllint --format -"

let g:netrw_uid  = "jerome"
let g:netrw_passwd = "jerome"

set spelllang=en_gb
set spellfile=~/.vim/spell.en.utf-8.add

:highlight clear SpellBad
:highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline
:highlight clear SpellCap
:highlight SpellCap term=underline cterm=underline
:highlight clear SpellRare
:highlight SpellRare term=underline cterm=underline
:highlight clear SpellLocal
:highlight SpellLocal term=underline cterm=underline

" setlocal spell
map <F12> :setlocal spell<CR>

" paths for python
" set path+=/home/jerome/erp5/zelenium_runner/config_master/Products/
" set path+=/home/jerome/zopes/Zope-2.9.8-final/lib/python/

" tags
" set tags+=$HOME/.vim/tags/python.ctags
"

au BufNewFile,BufRead bzr_log.*   setf bzrlog

set pastetoggle=<S-F4>

set runtimepath^=~/.vim/bundle/ctrlp.vim
