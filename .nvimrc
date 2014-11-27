" vim: set et sw=2 sts=2 ai:
set nocompatible

set shell=$SHELL

" clear all autocommands
autocmd!

" put backups out of the way
set backup
set backupdir=~/.nvim/backup
set directory=~/.nvim/backup
" persistent undo
set undofile
set undodir=~/.nvim/undo
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
set iskeyword-=.                    " '.' is an end of word designator
set iskeyword-=#                    " '#' is an end of word designator
set iskeyword-=-                    " '-' is an end of word designator

" highlight tabs & trailing spaces
set list listchars=tab:\ \ ,trail:·
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

if empty(glob('~/.nvim/autoload/plug.vim'))
  silent !mkdir -p ~/.nvim/autoload
  autocmd VimEnter * PlugInstall
endif

let g:plug_threads=1

call plug#begin('~/.nvim/plugged')
Plug 'Shougo/vimproc', { 'do' : 'make -f make_mac.mak' }
Plug 'tpope/vim-sensible'
Plug 'scrooloose/syntastic'

" editing
Plug 'AndrewRadev/splitjoin.vim'
Plug 'PeterRincker/vim-argumentative'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'

" tools
Plug 'Shougo/unite.vim'
Plug 'vim-scripts/dbext.vim'
Plug 'tpope/vim-fugitive'

" ui
Plug 'airblade/vim-gitgutter'
Plug 'bling/vim-airline'
Plug 'chriskempson/base16-vim'

" languages
Plug 'kchmck/vim-coffee-script', { 'for': 'slim' }
Plug 'slim-template/vim-slim', { 'for': 'slim' }
Plug 'tpope/vim-bundler', { 'for': 'ruby' }
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'leafo/moonscript-vim', { 'for': 'moon' }
Plug 'lepture/vim-jinja', { 'for': 'jinja' }
Plug 'fatih/vim-go', { 'for': 'go' }
call plug#end()

let g:ruby_path = system('echo $HOME/.rbenv/shims')
let base16colorspace=256
colorscheme base16-railscasts

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

" configure filetypes
au FileType xml set expandtab sw=2 sts=2
au FileType yaml set expandtab sw=2 sts=2
au FileType java set expandtab sw=4 sts=4
au FileType make set noet
au FileType puppet set et sw=4 sts=4
au FileType ruby set et sw=2 sts=2
au FileType coffee set et sw=2 sts=2
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

let g:unite_enable_start_insert = 1
let g:unite_source_rec_min_cache_files = 0
let g:unite_source_rec_max_cache_files = 0
nnoremap <C-P> :Unite -no-split file_rec/git:--others:--exclude-standard:--cached<CR>
nnoremap <C-G> :Unite -no-split grep:.:-iR<CR>
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])

