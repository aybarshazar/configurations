" be iMproved, required
set nocompatible

" vundle
filetype off

" set leader key
" map space to default leader key (\)
" otherwise nothing will show up in showcmd corner
map <Space> <leader>

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'jelera/vim-javascript-syntax'
Plugin 'pangloss/vim-javascript'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'Raimondi/delimitMate'
" Plugin 'scrooloose/syntastic'
" Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'bling/vim-airline'

" These might be worth checking out
"Plugin 'Lokaltog/vim-easymotion'
"Plugin 'justinmk/vim-sneak'
"Plugin 'tpope/vim-surround'
"Plugin 'tpope/vim-fugitive' " git stuff, plays good with vim-airline
"Plugin 'terryma/vim-multiple-cursors'
"Plugin 'Shougo/unite.vim'
"Plugin 'jlanzarotta/bufexplorer'
"Plugin 'kshenoy/vim-signature' " marks

" All of your Plugins must be added before the following line
" vundle
call vundle#end()
" vundle
filetype plugin indent on

" local directories
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
set undodir=~/.vim/undo

" don't wrap lines
set nowrap

" disable error bells
set noerrorbells

" use visual bell instead of audio
set visualbell

" show all changes
set report=0

set autoindent

" show line numbers
set number

"set relative line numbers
set relativenumber "use relative line numbers, current line still visible
autocmd BufReadPost,BufNewFile * set relativenumber

" increase history from 20 default to 1000
set history=1000

" highlight search
set hlsearch

" highlight dynamically as pattern is typed
set incsearch

" ignore case for searches
set ignorecase
" unless you type an uppercase letter
set smartcase

set showtabline=2 "always show tabline

set smarttab

" allow backspacing over everything in insert
set backspace=indent,eol,start

" new window goes right
set splitright
" new window goes below
set splitbelow

" show line and column number for cursor
set ruler

" show filename in the window titlebar
set title

" hide buffer without writing changes to file
set hidden

" send more characters, faster terminal
set ttyfast

" enable mouse in all modes
set mouse=a

" set mouse type to xterm
set ttymouse=xterm

" persistent undo
set undofile

" show commands
set showcmd

" timeout length for leader key
set timeoutlen=1500

" share clipboard with OS
set clipboard=unnamed

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

"colorscheme options
set background=dark
syntax on "syntax highlighting active
"set t_Co=256 "enable 256 colors in terminal vim

if has("gui_running")
    color base16-monokai

    " remove right scrollbar
    set guioptions-=r

    " remove left scrollbar
    set guioptions-=l

    " remove left scrollbar when there is a vertical split (NERDTree)
    set guioptions-=L
endif

" should I map escape to capslock or space?
" remap jk to escape in insert mode for faster mode changing
inoremap jk <Esc>

" tab key activates command-line wildcard expansion
set wildchar=<TAB>
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.psd,*.min.js
set wildmenu " hitting tab in command mode will show completions
set wildmode=list:longest

" vim-indent-guides options
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']

" nerdtree options
" use CTRL-o to toggle nerdtree
map <C-o> :NERDTreeToggle<CR>

" vim-javascript options
let g:javascript_enable_domhtmlcss=1

" syntastic options
" Install language specific stuff: jshint, jsxhint etc.
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_javascript_checkers = ['jshint']
" set tabstop=4 "for jshint
" syntastic options

" delimitMate options
let delimitMate_expand_cr=1

" nerdcommenter options
let NERDSpaceDelims=1

" ctrlp options
" use the nearest .git directory as cwd
let g:ctrlp_working_path_mode='r'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll|png|jpg|jpeg)$'
  \ }

" vim-airline options
let g:airline_powerline_fonts=1
let g:airline_theme="base16"
let g:airline#extensions#tabline#enabled=1 " show bufferline
let g:airline#extensions#tabline#buffer_nr_show=1 " show buffer number
let g:airline#extensions#tabline#buffer_idx_mode=1 " shortcuts for buffers
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
let g:airline#extensions#tabline#fnamemod=':t' " last component of filename
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h14 " font and font size
set laststatus=2 " Always display statusline in all windows

" Filetype specific options
autocmd BufNewFile,BufReadPost *.js setl et sts=2 sw=2
autocmd BufNewFile,BufReadPost *.html setl et sts=2 sw=2
autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2
