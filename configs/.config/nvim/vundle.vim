" ========================================
" NVim Plugin Specification
" ========================================

" set the runtime path to include Vundle and initialize
set rtp+=$HOME/.config/nvim/bundle/vundle

call vundle#begin("$HOME/.config/nvim/bundle")

" let Vundle manage Vundle (required)
Plugin 'VundleVim/Vundle.vim'

" Generic
Bundle "itchyny/lightline.vim"
Bundle "tpope/vim-fugitive"
"Plugin 'unblevable/quick-scope'

" Completion & snippets
Plugin 'Valloric/YouCompleteMe'
"Plugin 'rdnetto/YCM-Generator'
"Plugin 'SirVer/ultisnips'
"Plugin 'honza/vim-snippets'

" Syntax
Plugin 'alisdair/vim-armasm'
"Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
"Plugin 'othree/html5.vim'
"Plugin 'hail2u/vim-css3-syntax'
"Plugin 'cakebaker/scss-syntax.vim'
"Plugin 'Valloric/MatchTagAlways'

" Colorscheme
Plugin 'ajmwagar/vim-deus'
Plugin 'ajmwagar/lightline-deus' " Matching color scheme

" Linting
" Bundle 'scrooloose/syntastic'
Plugin 'w0rp/ale'

" File exploring
Bundle 'scrooloose/nerdtree'
Bundle 'jistr/vim-nerdtree-tabs'

" Load LaTeX if installed
if filereadable(expand("~/.config/nvim/latex.vim"))
    " Vimtex plugin
    Plugin 'lervag/vimtex'
    source ~/.config/nvim/latex.vim
endif

if filereadable(expand("~/.config/nvim/vhdl.vim"))
    " Vimtex plugin
    Plugin 'JPR75/VIP'
    Plugin 'hdl_plugin'
    Plugin 'salinasv/vim-vhdl'
    source ~/.config/nvim/vhdl.vim
endif

Plugin 'ctrlpvim/ctrlp.vim'

" Tags
Plugin 'vim-scripts/taglist.vim'

" Extra support for Golang
Plugin 'fatih/vim-go', { 'do': ':GoInstallBinaries' }

" Automatically update tag files
Plugin 'craigemery/vim-autotag'

" ROS support
" Plugin 'taketwo/vim-ros'

" Show open buffers
Plugin 'bling/vim-bufferline'



call vundle#end()

" ========================================
" Plugin configuration
" ========================================

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<C-j>"
let g:UltiSnipsJumpForwardTrigger = "<C-j>"
let g:UltiSnipsJumpBackwardTrigger = "<C-k>"

" vim-jsx settings
let g:jsx_ext_required = 0

" vim-deus stuff
set t_Co=256
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set background=dark " Setting dark mode
let g:deus_termcolors=256


" Quick scope
" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" ctrlp
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
            \ 'dir':  '\v[\/]\.(git|hg|svn)$',
            \ 'file': '\v\.(exe|so|dll)$',
            \ 'link': 'some_bad_symbolic_links',
            \ }

" nerdtree
let NERDTreeShowHidden=1
let NERDTreeSortOrder=['[\/]$', '*']
let NERDTreeIgnore=['.*\.swp$', '.*\.swo$',]

" Open Nerdtree with ctrl n
map <C-n> :NERDTreeToggle<CR>

" vim-go
" automatically fix imports
let g:go_fmt_command = "goimports"
let g:go_list_type = "quickfix"
let g:go_metalinter_autosave = 1

au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)

" Highlight vars with same name
let g:go_auto_sameids = 1
let g:go_fmt_command = "goimports"
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'


autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')


"nnoremap <silent> <F4> :TlistToggle<CR>
