
if filereadable(expand("~/.plugins.vim"))
     source ~/.plugins.vim
endif

syntax on                             "Enable syntax highlighting
set number                            "Line numbers are good
set title                             "Titles are cool
set hidden                            "Hide buffer instead of closing it
set pastetoggle=<F2>                  "Paste without being smart
set backspace=indent,eol,start        "Allow backspace in insert mode
set history=1000                      "Store lots of :cmdline history
set showcmd                           "Show incomplete cmds down the bottom
set visualbell                        "No sounds
set noerrorbells                      "Removes error bells
set autoread                          "Reload files changed outside vim
set autoindent                        "Auto indentation
set smartindent                       "Smart indentation
set smartcase                         "Smart casing
set smarttab                          "Smart tab
set hlsearch                          "Highlights search results
set incsearch                         "Includes partial searches
set showmatch                         "Shows matching braces
set ignorecase                        "Ignores case in searches
set shiftround                        "Move word to word with shift navigation
set history=1000                      "Command history
set undolevels=1000                   "Undo history
set udf                               "Persistant undo across sessions
set scrolloff=4                       "Makes cursor stay 8 lines away from screen edge
set tabstop=4 shiftwidth=4 expandtab  "Tabs to spaces
nnoremap <tab> :bnext<cr>             "Tab to next buffer
nnoremap <s-tab> :bprevious<cr>       "Shift-tab to previous buffer

" Matching parentheses
hi MatchParen cterm=bold ctermbg=none ctermfg=34

" Open nerd tree
"noremap <Leader><tab> :NERDTreeTabsToggle<CR>

" Undo
if has('persistent_undo')
    silent !mkdir ~/.config/vim/undo > /dev/null 2>&1
    set undodir=~/.config/vim/undo
    set undofile
endif

" Spell check
augroup spell_check
    autocmd!
    autocmd FileType no ft setlocal spell spelllang-en_us
augroup END

autocmd BufRead,BufNewFile *.md setlocal spell spelllang=en_us

function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

" Using file extension
autocmd BufWritePre *.h,*.c,*.java,*.cpp :call <SID>StripTrailingWhitespaces()
