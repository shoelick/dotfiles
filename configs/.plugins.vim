" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

" let Vundle manage Vundle (required)
Plugin 'VundleVim/Vundle.vim'

" Generic
Plugin 'itchyny/lightline.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

"Plugin 'unblevable/quick-scope'

" Completion & snippets
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'rdnetto/YCM-Generator'
"Plugin 'SirVer/ultisnips'
"Plugin 'honza/vim-snippets'

" Syntax
"Plugin 'alisdair/vim-armasm'
"Plugin 'pangloss/vim-javascript'
"Plugin 'mxw/vim-jsx'
"Plugin 'othree/html5.vim'
"Plugin 'hail2u/vim-css3-syntax'
"Plugin 'cakebaker/scss-syntax.vim'
"Plugin 'Valloric/MatchTagAlways'

" Python smart formatting
"Plugin 'vim-scripts/indentpython.vim'
"Plugin 'nvie/vim-flake8'

" Colorscheme
Plugin 'ajmwagar/vim-deus'
Plugin 'ajmwagar/lightline-deus' " Matching color scheme

" Linting
"Plugin 'scrooloose/syntastic'
"Plugin 'w0rp/ale'

" File exploring
"Plugin 'scrooloose/nerdtree'
"Plugin 'jistr/vim-nerdtree-tabs'

" Load LaTeX if installed
"if filereadable(expand("~/.config/nvim/latex.vim"))
"    " Vimtex plugin
"    Plugin 'lervag/vimtex'
"    source ~/.config/nvim/latex.vim
"endif

"if filereadable(expand("~/.config/nvim/vhdl.vim"))
"    " Vimtex plugin
"    Plugin 'JPR75/VIP'
"    Plugin 'hdl_plugin'
"    Plugin 'salinasv/vim-vhdl'
"    source ~/.config/nvim/vhdl.vim
"endif

"Plugin 'ctrlpvim/ctrlp.vim'

" Tags
"Plugin 'vim-scripts/taglist.vim'

" Extra support for Golang
"Plugin 'fatih/vim-go', { 'do': ':GoInstallBinaries' }

" Automatically update tag files
"Plugin 'craigemery/vim-autotag'

" ROS support
" Plugin 'taketwo/vim-ros'

" Show open buffers
Plugin 'bling/vim-bufferline'


call vundle#end()

filetype plugin indent on

" ========================================
" Plugin configuration
" ========================================

" ...
