" vim: set et sw=2 sts=2 ai:

set shell=$SHELL

" clear all autocommands
autocmd!

call plug#begin()
Plug 'benekastah/neomake'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }

" editing
Plug 'AndrewRadev/splitjoin.vim'
Plug 'PeterRincker/vim-argumentative'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'godlygeek/tabular'
Plug 'luochen1990/rainbow'

" tools
Plug 'vim-scripts/dbext.vim'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'tpope/vim-vinegar'

" ui
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'unblevable/quick-scope'
Plug 'dracula/vim'

" languages
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-bundler', { 'for': 'ruby' }
Plug 'leafo/moonscript-vim', { 'for': 'moon' }
Plug 'lepture/vim-jinja', { 'for': 'jinja' }
Plug 'markcornick/vim-terraform'
Plug 'wlangstroth/vim-racket', { 'for': 'racket' }
call plug#end()

set mouse=

" put backups out of the way
set backup
set backupdir=~/.config/nvim/backup
set directory=~/.config/nvim/backup
" persistent undo
set undofile
set undodir=~/.config/nvim/undo
set undolevels=1000
set undoreload=10000

set background=dark

" show line numbers
set number
" hide -- INSERT --, we have airline
set noshowmode
" use abbreviations in messages
set shortmess+=filmnrxoOtTI
" always set terminal title
set title
" don't put ugly |s into vbars
set fillchars=vert:\ 
" always leave 5 lines around cursor
set scrolloff=5
set sidescrolloff=5
" save history
set viminfo=/50,'50,:50,h
" don't update screen for macros
set lazyredraw
set viewoptions=folds,options,cursor,unix,slash
set iskeyword-=. " '.' is an end of word designator
set iskeyword-=# " '#' is an end of word designator
set iskeyword-=- " '-' is an end of word designator


" highlight tabs & trailing spaces
set list listchars=tab:··,trail:·
" syntax-aware folds
set foldmethod=syntax
" selection method
set wildmode=list:longest,full
" files to ignore
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*
" highlight last search term
set hlsearch
" case insensitive
set ignorecase
" case sensitive if search string contains uppercase
set smartcase
" always replace all matches on line
set gdefault

colorscheme dracula

function! MyFoldText() " {{{
  let line = getline(v:foldstart)

  let nucolwidth = &fdc + &number * &numberwidth
  let windowwidth = winwidth(0) - nucolwidth - 3
  let foldedlinecount = v:foldend - v:foldstart

  " expand tabs into spaces
  let onetab = strpart('          ', 0, &tabstop)
  let line = substitute(line, '\t', onetab, 'g')

  let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
  let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
  return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction " }}}
set foldtext=MyFoldText()


"{{{ filetypes
" add some filetypes
au BufNewFile,BufRead *.gradle setf groovy
au BufNewFile,BufRead *.json set ft=javascript
au BufNewFile,BufRead *.t set ft=sh
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru} set ft=ruby
au BufRead,BufNewFile *.less set ft=css
au BufRead,BufNewFile *.mg/config set ft=gitconfig
au BufNewFile,BufRead *.ftl set ft=html.ftl
au BufNewFile,BufRead *.json set ft=json

" configure filetypes
au FileType xml set expandtab sw=2 sts=2
au FileType yaml set expandtab sw=2 sts=2
au FileType java set expandtab sw=4 sts=4
au FileType make set noet
au FileType ruby set et sw=2 sts=2
au FileType coffee set et sw=2 sts=2
au FileType terraform set et sw=4 sts=4
au FileType json set et sw=4 sts=4
au Filetype php set sts=4 sw=4 ai expandtab
au Filetype go set nolist
au Filetype moon set sts=4 sw=4 ai et

au! BufWritePost *.pp Neomake
"}}}

au FocusLost * silent! wall

" all folds open by default
autocmd BufEnter * let PreFoldPosition = getpos('.') | silent! %foldopen! | call setpos('.', PreFoldPosition)

" restore previous line edited
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$']
let NERDChristmasTree=1
let NERDTreeMinimalUI=1
map <Leader>n :NERDTreeToggle<CR>
let g:gist_private = 1
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_theme='simple'

"{{{ mappings
" press F2 before a paste to turn off autoindent
set pastetoggle=<F2>
" w!! to save with sudo
cmap w!! %!sudo tee > /dev/null %
" use space to pagedown
noremap <Space> <PageDown>
vnoremap < <gv
vnoremap > >gv
"}}}

" pymode is fairly irritating
let g:pymode_rope = 0
let g:pymode_trim_whitespaces = 0

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0

nnoremap <C-P> :FZF!<CR>

inoremap <Left>  <NOP>
inoremap <Right> <NOP>
inoremap <Up>    <NOP>
inoremap <Down>  <NOP>
nnoremap <Left>  <NOP>
nnoremap <Right> <NOP>
nnoremap <Up>    <NOP>
nnoremap <Down>  <NOP>

tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
autocmd BufWinEnter,WinEnter term://* startinsert

nnoremap <C-d> ZZ

let g:rainbow_active = 0
