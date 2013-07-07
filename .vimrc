
"{{{ setup
" be vim
set nocompatible
" load neobundle
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc', {
  \ 'build' : {
  \     'windows' : 'make -f make_mingw32.mak',
  \     'cygwin' : 'make -f make_cygwin.mak',
  \     'mac' : 'make -f make_mac.mak',
  \     'unix' : 'make -f make_unix.mak',
  \    },
  \ }
"}}}

"{{{ bundles
" syntax checking
NeoBundle 'scrooloose/syntastic'
" misc handy mappings
NeoBundle 'tpope/vim-unimpaired'
" commenting
NeoBundle 'scrooloose/nerdcommenter'
" project tree
NeoBundle 'scrooloose/nerdtree'
" git
NeoBundle 'tpope/vim-fugitive'
" vertically align
NeoBundle 'godlygeek/tabular'
" change "surrounds"
NeoBundle 'tpope/vim-surround'
" markdown
NeoBundle 'tpope/vim-markdown'

NeoBundle 'cucumber.zip'
NeoBundle 'chaquotay/ftl-vim-syntax'
NeoBundle 'dmreiland/vim-puppet'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'ap/vim-css-color'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'groenewege/vim-less'
NeoBundle 'bling/vim-airline'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'michaeljsmith/vim-indent-object'
NeoBundle 'ervandew/supertab'
NeoBundle "MarcWeber/vim-addon-mw-utils"
NeoBundle "tomtom/tlib_vim"
NeoBundle "georgebashi/snipmate-snippets"
NeoBundle "garbas/vim-snipmate"
NeoBundle "jnwhiteh/vim-golang"
NeoBundle "nsf/gocode", {'rtp': 'vim/'}
NeoBundle "hukl/Smyck-Color-Scheme", {'script_type' : 'colors'}
"}}}

" detect file type and load plugins & indent rules
filetype plugin indent on
NeoBundleCheck


"{{{ ctrlp
let g:ctrlp_working_path_mode = 2
let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files --exclude-standard -co']
let g:ctrlp_by_filename = 1
let g:ctrlp_use_caching = 0
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_mruf_relative = 1
let g:ctrlp_dotfiles = 0
let g:ctrlp_mruf_case_sensitive = 0
"}}}

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

"{{{ syntax
syntax on
set background=dark
colorscheme smyck
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

"{{{ mappings
" press F2 before a paste to turn off autoindent
set pastetoggle=<F2>
" w!! to save with sudo
cmap w!! %!sudo tee > /dev/null %
" use space to pagedown
noremap <Space> <PageDown>
" switch windows with ,
nmap , <C-w><C-w>
vnoremap < <gv
vnoremap > >gv
"}}}

"{{{ misc vim settings
set autowrite
set virtualedit=block
set modeline
set modelines=10
"}}}

"{{{ misc plugin settings
" my name for snippets
let g:snips_author = 'George Bashi'
"autocmd vimenter * NERDTree | winc l
let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$']
let NERDChristmasTree=1
let NERDTreeMinimalUI=1
map <Leader>n :NERDTreeToggle<CR>
let g:gist_private = 1
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['java'] }
"}}}

"{{{ clever bits
" remember last file location
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal g'\"" | endif
endif

" all folds open by default
autocmd BufEnter * let PreFoldPosition = getpos('.') | silent! %foldopen! | call setpos('.', PreFoldPosition)

augroup FTMisc
  " save when losing focus, update fugitive status when gaining
  autocmd FocusLost   * silent! wall
  autocmd FocusGained * silent! call fugitive#reload_status()

  " chmod +x new files on save if they start with hashbang
  autocmd BufNewFile  * let b:chmod_exe=1
  autocmd BufWritePre * if exists("b:chmod_exe") |
        \ unlet b:chmod_exe |
        \ if getline(1) =~ '^#!' | let b:chmod_new="+x" | endif |
      \ endif
  autocmd BufWritePost,FileWritePost * if exists("b:chmod_new")|
        \ silent! execute "!chmod ".b:chmod_new." <afile>"|
        \ unlet b:chmod_new|
        \ endif
  " allow browsing inside jars
  autocmd BufReadCmd *.jar call zip#Browse(expand("<amatch>"))
augroup END

"}}}


" autocomplete stuff {{{
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabLongestEnhanced = 1
let g:SuperTabLongestHighlight = 1
let g:SuperTabClosePreviewOnPopupClose = 1
" }}}

" eclim {{{
let g:EclimJavaImportExclude = [ "^com\.sun\..*", "^sun\..*", "^sunw\..*" ]
let g:EclimJavaImportPackageSeparationLevel = 0
"}}}

" vim: set foldmethod=marker:
