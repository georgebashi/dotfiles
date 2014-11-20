" vim: set et sw=2 sts=2 ai:
set nocompatible

call plug#begin('~/.vim/plugged')
Plug 'chriskempson/base16-vim'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'vim-ruby/vim-ruby'
Plug 'bling/vim-airline'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'scrooloose/syntastic'
Plug 'Shougo/vimproc', { 'do' : 'make -f make_mac.mak' }
Plug 'Shougo/unite.vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'leafo/moonscript-vim'
Plug 'lepture/vim-jinja'
Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'
Plug 'vim-scripts/dbext.vim'
Plug 'PeterRincker/vim-argumentative'
call plug#end()

let g:ruby_path = system('echo $HOME/.rbenv/shims')

set background=dark
let base16colorspace=256
colorscheme base16-railscasts

"{{{ paths
" put backups out of the way
set backupdir=~/.vim/backup
set directory=~/.vim/backup
" persistent undo
set undodir=~/.vim/undo
set undolevels=1000
set undoreload=10000
" always use utf8
set encoding=utf-8
"}}}

"{{{ ui
" show line numbers
set number
" show file position
set ruler
" always show status bar
set laststatus=2
" hide -- INSERT --, we have airline
set noshowmode
" make backspace do what you expect
set backspace=indent,eol,start
" use abbreviations in messages
set shortmess=aI
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

"}}}

"{{{ whitespace
" default indent 2 spaces
"set tabstop=2
"set shiftwidth=2
"set softtabstop=2
"set expandtab
" highlight tabs & trailing spaces
set list listchars=tab:\ \ ,trail:·
" syntax-aware folds
set foldmethod=syntax
" autoindent by default
set autoindent
"}}}

"{{{ tab completion
" selection method
set wildmenu
set wildmode=list:longest,full
" files to ignore
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*
"}}}

"{{{ search
" highlight last search term
set hlsearch
" incremental search
set incsearch
" case insensitive
set ignorecase
" case sensitive if search string contains uppercase
set smartcase
" always replace all matches on line
set gdefault
"}}}

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
"}}}

au FocusLost * silent! wa

" all folds open by default
autocmd BufEnter * let PreFoldPosition = getpos('.') | silent! %foldopen! | call setpos('.', PreFoldPosition)

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
" switch windows with ,
" nmap <silent> <Up> :wincmd k<CR>
" nmap <silent> <Down> :wincmd j<CR>
" nmap <silent> <Left> :wincmd h<CR>
" nmap <silent> <Right> :wincmd l<CR>
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

