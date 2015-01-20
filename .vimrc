
set nocompatible " be iMproved, required

filetype off " required

" set leader key
let mapleader=","

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'jelera/vim-javascript-syntax'
Plugin 'pangloss/vim-javascript'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'Raimondi/delimitMate'
Plugin 'scrooloose/syntastic'
Plugin 'Valloric/YouCompleteMe'
Plugin 'marijnh/tern_for_vim'
Plugin 'scrooloose/nerdtree'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'bling/vim-airline'
Plugin 'mxw/vim-jsx'
"Plugin 'Lokaltog/vim-easymotion' These 4 might be worth checking out
"Plugin 'justinmk/vim-sneak'
"Plugin 'tpope/vim-surround'
"Plugin 'tpope/vim-fugitive' " git stuff, plays good with vim-airline

" All of your Plugins must be added before the following line
call vundle#end() " required
filetype plugin indent on " required

" local directories
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
set undodir=~/.vim/undo

" various options
set nowrap "don't wrap lines
set noerrorbells " disable error bells
set visualbell " use visual bell instead of audio
set report=0 " show all changes
set autoindent
set number " line numbers
set history=1000 " increase history from 20 default to 1000
set incsearch " highlight dynamically as pattern is typed
set hlsearch " highlight search
set ignorecase " ignore case for searches
set smartcase " unless you type an uppercase letter
set showtabline=2 " always show tabline
set smarttab
set backspace=indent,eol,start " allow backspacing over everything in insert
set splitbelow " new window goes below
set splitright " new window goes right
set ruler " show the cursor position
set title " show filename in the window titlebar
set hidden " hide buffer without writing changes to file
set ttyfast " send more characters, faster terminal
set mouse=a " enable mouse in all modes
set ttymouse=xterm " set mouse type to xterm
set undofile " persistent undo
set showcmd " show commands
set timeoutlen=1500 " timeout length for leader key
set clipboard=unnamed " share clipboard with OS
set guioptions-=r " remove right scrollbar
set guioptions-=l " remove left scrollbar
set guioptions-=L " remove left scrollbar when there is a vertical split (NERDTree)

" check why this does not work
" set breakindent

" set relative line numbers
set relativenumber " use relative line numbers, current line still visible
autocmd BufReadPost,BufNewFile * set relativenumber

" should I map escape to capslock or space?
" remap jk to escape in insert mode for faster mode changing
inoremap jk <Esc>

" speed up viewport scrolling
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

set wildchar=<TAB> " tab key activates command-line wildcard expansion
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.psd,*.min.js
set wildmenu " hitting tab in command mode will show completions
set wildmode=list:longest

" colorscheme options
set background=dark
syntax on "syntax highlighting active
color base16-monokai

" vim-indent-guides options
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']

" vim-javascript options
let g:javascript_enable_domhtmlcss=1

" syntastic options
" Install language specific stuff: jshint, jsxhint etc.
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_javascript_checkers = ['jsxhint']
set tabstop=4 " for jshint & jsxhint
" syntastic options

" tern options
" https://github.com/marijnh/tern_for_vim/blob/master/autoload/tern.vim
let g:tern_map_prefix='<Leader>'
let g:tern_map_keys=1
" let tern#is_show_argument_hints_enabled=1
let g:tern_show_argument_hints='on_hold'

" delimitMate options
let delimitMate_expand_cr=1

" NERDTree options
" sync NERDTree with current file
map <C-o> :NERDTreeToggle %<CR>

"ctrlp options
let g:ctrlp_working_path_mode='r' "use the nearest .git directory as cwd
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
set guifont=Inconsolata\ for\ Powerline:h16 " font and font size
set laststatus=2 " Always display statusline in all windows

" Filetype specific options
autocmd BufNewFile,BufReadPost *.js setl et sts=2 sw=2
autocmd BufNewFile,BufReadPost *.jsx setl et sts=2 sw=2
autocmd BufNewFile,BufReadPost *.html setl et sts=2 sw=2
