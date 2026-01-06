" --- Basic setup
set nocompatible              " turn off vi-compatibility
set encoding=utf-8            " internal encoding used by Vim
set fileencoding=utf-8        " default encoding for new files
if exists('&termencoding')
  set termencoding=utf-8      " terminal encoding if option exists
endif

" Filetype, syntax, plugins
filetype plugin indent on     " detect filetype, enable ftplugins and indent
syntax on                     " enable syntax highlighting

" Buffer behavior
set hidden                    " allow switching buffers without saving

" Leader key
let mapleader = " "           " set <Space> as leader
nnoremap <Space> <Nop>        " avoid accidental space in normal mode
vnoremap <Space> <Nop>        " avoid accidental space in visual mode

" Timing
set timeout                   " enable mapping timeouts
set timeoutlen=500            " ms to wait for mapped sequence
set ttimeout                  " enable terminal key code timeout
set ttimeoutlen=100           " ms to wait for terminal key codes
set updatetime=300            " ms for CursorHold and swapfile updates

" --- UI
set number                    " absolute line numbers
set relativenumber            " relative numbers
set cursorline                " highlight current line
set showmatch                 " briefly jump to matching brace
set showcmd                   " show partial commands in status area
set showmode                  " show current mode (INSERT etc.)
set wildmenu                  " enhanced cmdline completion
set wildmode=longest:full,full
set pumheight=12              " popup menu height

" Visual whitespace & soft-wrapping
set wrap                      " enable line wrapping
set linebreak                 " break at word boundaries
set breakindent               " visually indent wrapped lines
set list                      " show invisible characters
set listchars=tab:→\ ,trail:·,extends:>,precedes:<,nbsp:␣,eol:¬
if &term =~ 'xterm\|kitty\|alacritty\|rxvt'
  set showbreak=↪\            " visual marker for wrapped lines
else
  set showbreak=-->           " fallback marker
endif

" Window / split behavior
set splitbelow                " horizontal splits go below
set splitright                " vertical splits go to the right
set scrolloff=8               " keep 8 context lines vertically
set sidescrolloff=8           " keep 8 context columns horizontally
set mouse=a                   " enable mouse in all modes
set ttyfast                   " optimize redraw assumptions for fast terminals
set lazyredraw                " don't redraw while executing macros/scripts

" Searching
set ignorecase                " case-insensitive searches...
set smartcase                 " ...unless the search has uppercase
set incsearch                 " show matches while typing
set hlsearch                  " highlight search results

" Editing & indentation
set autoread                  " auto-reload file changed outside Vim
set expandtab                 " use spaces instead of literal tabs by default
set shiftwidth=2              " indentation width for >>, << and autoindent
set softtabstop=2             " number of spaces a <Tab> inserts in insert mode
set tabstop=2                 " a literal Tab counts as 2 spaces
set smarttab                  " Use shiftwidth/tabstop when inserting tabs
set smartindent               " C-like smart indentation
set autoindent                " inherit indent from previous line
set nrformats=                " disable special nr formats for CTRL-A/CTRL-X increments

" Path / wildignore
set path+=.,**                " allow :find to search subdirs
set wildignore+=*.o,*.obj,*.bak,*.swp,*.pyc,*.class " ignore these in completion

" Statusline
set laststatus=2              " always show statusline
set statusline=%f\ %h%m%r\ [%{&fileformat}]\ %y\ %=%l:%c\ %p%%

" --- Backup / swap / undo
set nobackup
set nowritebackup
set noswapfile
set noundofile

" --- Autocommands
augroup user_vimrc
  " clear existing commands in this group
  autocmd!

  " silently remove trailing whitespace on save
  autocmd BufWritePre * silent! %s/\s\+$//e

  " restore cursor to last edit position
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif

  " filetype-specific local settings:
  autocmd FileType make     setlocal noexpandtab
  autocmd FileType python   setlocal shiftwidth=4 softtabstop=4 expandtab
augroup END

" --- Key mappings
" Normal / visual mappings
nnoremap <leader>w :update<CR>       " write buffer if modified
nnoremap <leader>q :confirm q<CR>    " quit window with confirmation
nnoremap <leader>wq :wq<CR>          " write & quit
nnoremap <leader>wa :wa<CR>          " write all buffers
nnoremap <leader>sv :vsplit<CR>      " vertical split
nnoremap <leader>sh :split<CR>       " horizontal split
nnoremap <leader>sc :close<CR>       " close window
nnoremap <C-h> <C-w>h                " move to left split
nnoremap <C-j> <C-w>j                " move to below split
nnoremap <C-k> <C-w>k                " move to above split
nnoremap <C-l> <C-w>l                " move to right split
nnoremap <leader>bn :bnext<CR>       " next buffer
nnoremap <leader>bp :bprevious<CR>   " previous buffer
nnoremap <leader>bd :bdelete<CR>     " delete buffer
nnoremap <leader>tr :set invrelativenumber<CR> " toggle relativenumbers
vnoremap <leader>y "+y               " yank visual selection to system clipboard
nnoremap <leader>Y "+Y               " yank line to system clipboard
nnoremap gV `[v`]                    " select last inserted text
nnoremap <leader>o o<esc>k           " add blank line below without entering insert mode
nnoremap <leader>O O<esc>j           " add blank line above without entering insert mode
nnoremap <leader>n :nohlsearch<Bar>echo "cleared search"<cr> " clear search highlight

" Insert mode mappings
inoremap jk <Esc>                    " quick exit from insert mode
