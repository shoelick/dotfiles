set nocompatible
filetype off

" Load plugins
if filereadable(expand("~/.config/nvim/vundle.vim"))
    source ~/.config/nvim/vundle.vim
endif

" Required by Vundle
filetype plugin indent on

" Non-vundle related config

syntax on
set number                      "Line numbers are good
set title                       "Titles are cool

set pastetoggle=<F2>            "Toggle GUI paste without screwing up indent
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete :cmds down the bottom
set visualbell                  "No sounds
set noerrorbells                "Removes error bells
set autoread                    "Reload files changed outside vim
set autoindent                  "Copy the previous line's indentation
set smartindent                 "Automatically add indent to new scopes
set smarttab                    "Inserts tabs according to shiftwidth
set hlsearch                    "Highlights search results
set incsearch                   "Includes partial searches
set showmatch                   "Shows matching braces
set shiftround                  "Round #indents to multiple of shiftwidth
set history=1000                "Command history
set undolevels=1000             "Undo history
set udf                         "Persistant undo across sessions
set scrolloff=4                 "Makes cursor stay 8 lines away from the top or bottom

" These two together cause search only to be case sensitive when a capital
" letter is in the search
set smartcase
set ignorecase

"Hide buffer instead of closing it. Also disable buffering of empty files
set hidden

" Tabs to spaces
set tabstop=4 shiftwidth=4 expandtab

" Delete trailing whitespaces on file write
autocmd BufWritePre * %s/\s\+$//e

""""""""""""""""""""""""""""""""""""""""""""""""" HIGHLIGHTING

" Matching parentheses
hi MatchParen cterm=bold ctermbg=none ctermfg=34

" Colored line numbers are better
" This comes with colorscheme deus I think
hi LineNr ctermfg=130 guifg=Brown

" Enable colored line highlight
set cursorline

" Mark line length limit
set colorcolumn=80

""""""""""""""""""""""""""""""""""""""""""""""""" COLORS
colorscheme deus

""""""""""""""""""""""""""""""""""""""""""""""""" BOTTOM BAR
" lightline
set laststatus=2 " no display fix
set noshowmode

" Setting up pretty status bar
let g:lightline = {
            \ 'colorscheme': 'deus',
            \ 'component': {
            \   'readonly': '%{&readonly?"":""}',
            \ },
            \ 'separator': { 'left': '', 'right': '' },
            \ 'subseparator': { 'left': '', 'right': '' }
            \ }

""""""""""""""""""""""""""""""""""""""""""""""""" OTHER

" Undo
if has('persistent_undo')
    silent !mkdir ~/.config/nvim/undo > /dev/null 2>&1
    set undodir=~/.config/nvim/undo
    set undofile
endif


" netrw (built-in filebrowser)
let g:netrw_liststyle=3         "List styles for file explorer
let g:netrw_altv=1
let g:netrw_preview=1
let g:netrw_sort_sequence='[\/]$,*' " sort is affecting only: directories on the top, files below
let g:netrw_list_hide='.*\.swp$'
let g:netrw_use_noswf=0

let asmsyntax='armasm'
let filetype_inc='armasm'

" Key mappings
let mapleader = "\<Space>"
let maplocalleader = "\\"
nnoremap <leader>c :noh<cr>         " Clear search highlighting with <space>c
nnoremap <tab> :bnext<cr>           " Tab to next buffer
nnoremap <s-tab> :bprevious<cr>     " Shift-tab to previous buffer
noremap <Leader><tab> :NERDTreeTabsToggle<CR>
noremap <Leader>` :call VexToggle("")<CR>
noremap <Leader>i :exe "normal i".nr2char(getchar())<CR>
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

"stuff to ignore when tab completing
set wildignore=*.o,*.obj,*~
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**

set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg,*.svg
set wildignore+=*.swp,*.pyc,*.bak,*.class,*.orig
set wildignore+=.git,.hg,.bzr,.svn
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

" Special rules for makefiles
augroup makefile
    autocmd!
    autocmd FileType make setlocal noexpandtab
augroup END

" Spell check
augroup spell_check
    autocmd!
    autocmd FileType no ft setlocal spell spelllang-en_us
augroup END

autocmd BufRead,BufNewFile *.md setlocal spell spelllang=en_us

" Strip trailing whitespace on the specified filetypes
function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd BufWritePre *.h,*.c,*.java,*.cpp,*.go,*.js :call <SID>StripTrailingWhitespaces()

set mmp=5000
