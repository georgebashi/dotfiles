" vim: set et sw=2 sts=2 ai:
scriptencoding utf-8

set shell=$SHELL

call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'w0rp/ale'

Plug 'AndrewRadev/splitjoin.vim'
Plug 'PeterRincker/vim-argumentative'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'

Plug 'godlygeek/tabular'
Plug 'luochen1990/rainbow'

Plug 'junegunn/fzf'

Plug 'itchyny/lightline.vim'
Plug 'unblevable/quick-scope'

Plug 'sheerun/vim-polyglot'
Plug 'markcornick/vim-terraform', { 'for': 'terraform' }

Plug 'dracula/vim', { 'as': 'dracula' }

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
  let l:line = getline(v:foldstart)

  let l:nucolwidth = &foldcolumn + &number * &numberwidth
  let l:windowwidth = winwidth(0) - l:nucolwidth - 3
  let l:foldedlinecount = v:foldend - v:foldstart

  " expand tabs into spaces
  let l:onetab = strpart('          ', 0, &tabstop)
  let l:line = substitute(l:line, '\t', l:onetab, 'g')

  let l:line = strpart(l:line, 0, l:windowwidth - 2 -len(l:foldedlinecount))
  let l:fillcharcount = l:windowwidth - len(l:line) - len(l:foldedlinecount)
  return l:line . '…' . repeat(' ',l:fillcharcount) . l:foldedlinecount . '…' . ' '
endfunction " }}}
set foldtext=MyFoldText()


augroup vimrc
  autocmd!

  "{{{ filetypes
  " add some filetypes
  autocmd BufNewFile,BufRead *.gradle setf groovy
  autocmd BufNewFile,BufRead *.json set ft=javascript
  autocmd BufNewFile,BufRead *.t set ft=sh
  autocmd BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru} set ft=ruby
  autocmd BufRead,BufNewFile *.less set ft=css
  autocmd BufRead,BufNewFile *.mg/config set ft=gitconfig
  autocmd BufNewFile,BufRead *.ftl set ft=html.ftl
  autocmd BufNewFile,BufRead *.json set ft=json

  " configure filetypes
  autocmd FileType xml set expandtab sw=2 sts=2
  autocmd FileType yaml set expandtab sw=2 sts=2
  autocmd FileType java set expandtab sw=4 sts=4
  autocmd FileType make set noet
  autocmd FileType ruby set et sw=2 sts=2
  autocmd FileType coffee set et sw=2 sts=2
  autocmd FileType terraform set et sw=4 sts=4
  autocmd FileType json set et sw=4 sts=4
  autocmd Filetype php set sts=4 sw=4 ai expandtab
  autocmd Filetype go set nolist
  autocmd Filetype moon set sts=4 sw=4 ai et

  autocmd! BufWritePost *.pp Neomake
  "}}}

  autocmd FocusLost * silent! wall

  " all folds open by default
  autocmd BufEnter * let PreFoldPosition = getpos('.') | silent! %foldopen! | call setpos('.', PreFoldPosition)

  " restore previous line edited
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END

let g:gist_private = 1

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
let g:pymode_python = 'python3'

inoremap <Left>  <NOP>
inoremap <Right> <NOP>
inoremap <Up>    <NOP>
inoremap <Down>  <NOP>
nnoremap <Left>  <NOP>
nnoremap <Right> <NOP>
nnoremap <Up>    <NOP>
nnoremap <Down>  <NOP>

nnoremap <C-d> ZZ

let g:rainbow_active = 1
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
let g:lightline = {
      \ 'colorscheme': 'Dracula',
      \ }
