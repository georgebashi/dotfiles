
"{{{ setup
" be vim
set nocompatible
" load vundle
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
"}}}

"{{{ bundles
" vundle plugin manager
Bundle 'gmarik/vundle'
" solarized theme
Bundle 'altercation/vim-colors-solarized'
" syntax checking
Bundle 'scrooloose/syntastic'
" misc handy mappings
Bundle 'tpope/vim-unimpaired'
" commenting
Bundle 'scrooloose/nerdcommenter'
" project tree
Bundle 'scrooloose/nerdtree'
" git
Bundle 'tpope/vim-fugitive'
" vertically align
Bundle 'godlygeek/tabular'
" change "surrounds"
Bundle 'tpope/vim-surround'
" markdown
Bundle 'tpope/vim-markdown'
" buffer tabs
" haskellmode
Bundle 'kevinstreit/VIM-Haskell'

Bundle 'cucumber.zip'
Bundle 'chaquotay/ftl-vim-syntax'
Bundle 'dmreiland/vim-puppet'
Bundle 'mattn/gist-vim'
Bundle 'pangloss/vim-javascript'
Bundle 'kchmck/vim-coffee-script'
Bundle 'skammer/vim-css-color'
Bundle 'hail2u/vim-css3-syntax'
Bundle 'groenewege/vim-less'
Bundle 'Lokaltog/vim-powerline'
Bundle 'kien/ctrlp.vim'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'michaeljsmith/vim-indent-object'
Bundle 'ervandew/supertab'
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "georgebashi/snipmate-snippets"
Bundle "garbas/vim-snipmate"
"}}}


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
au BufWinLeave *.* silent! mkview
au BufWinEnter *.* silent! loadview

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
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
" highlight tabs & trailing spaces
set list listchars=tab:\ \ ,trail:·
" detect file type and load plugins & indent rules
filetype plugin indent on
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
set t_Co=256
set background=dark
let g:solarized_termtrans=1
colorscheme solarized
call togglebg#map("<F5>")
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
" gradle = groovy
au BufNewFile,BufRead *.gradle setf groovy
" json = js
au BufNewFile,BufRead *.json set ft=javascript
" add some ruby types
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}    set ft=ruby
au BufRead,BufNewFile *.less set ft=css
" .mg/config is a gitconfig file
au BufRead,BufNewFile *.mg/config set ft=gitconfig
" use 4 spaces in xml
au FileType xml set expandtab sw=4 sts=4
" use tabs in makefiles
au FileType make set noexpandtab
" reload vimrc after saving
au BufWritePost .vimrc source $MYVIMRC
" allow modelines
set modeline
" search for modelines in first and last 10 lines
set modelines=10
"}}}

"{{{ mappings
" use kj as a quicker <Esc>
inoremap kj <Esc>
" use ; as a quicker :
map ; :
" move ; to ;;
noremap ;; ;
" press F2 before a paste to turn off autoindent
set pastetoggle=<F2>
" create blank line without entering insert
nnoremap <silent> zj o<Esc>
nnoremap <silent> zk O<Esc>
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
let g:Powerline_symbols = 'compatible'
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd guibg=#073642 ctermbg=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#073642 ctermbg=0
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
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

au BufNewFile,BufRead *.ftl set ft=html.ftl
au FileType puppet set et sw=4 sts=4

" autocomplete stuff {{{
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabLongestEnhanced = 1
let g:SuperTabLongestHighlight = 1
let g:SuperTabClosePreviewOnPopupClose = 1
" }}}

" vim: set foldmethod=marker:
