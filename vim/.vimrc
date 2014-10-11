" .vimrc

let g:OS = 'linux'
set t_Co=256        " 256 color mode
set encoding=utf-8
set background=dark

set nocompatible
filetype off        " required for vundle, reenabled later.

syntax enable
colorscheme jellybeans




let mapleader = ','

" Remove trailing whitespace
" http://vim.wikia.com/wiki/Remove_unwanted_spaces
function! StripTrailingWhitespace()
    if !&binary && &filetype != 'diff'
        normal mz
        normal Hmy
        %s/\s\+$//e
        normal 'yz<CR>
        normal `z
        retab
    endif
endfunction

nmap <leader>tW :cal StripTrailingWhitespace()<CR>

map <Up> <nop>
map <Down> <nop>
map <Left> <nop>
map <Right> <nop>
set mouse=a         " Enable the use of the mouse.
map <Esc><Esc> :w<CR>

" Search Options
set hlsearch        " When there is a previous search pattern, highlight all
                    " its matches.
set incsearch       " While typing a search command, show immediately where the
                    " so far typed pattern matches.
set ignorecase      " Ignore case in search patterns.
set smartcase       " Override the 'ignorecase' option if the search pattern
                    " contains upper case characters.


" Tabs, spaces and backspaces
" set backspace=2     " Influences the working of <BS>, <Del>, CTRL-W
                    " and CTRL-U in Insert mode. This is a list of items,
                    " separated by commas. Each item allows a way to backspace
                    " over something.

" set autoindent      " Copy indent from current line when starting a new line

set tabstop=4       " Number of spaces that a <Tab> in the file counts for.
set shiftwidth=4    " Number of spaces to use for each step of (auto)indent.
set expandtab       " Use the appropriate number of spaces to insert a <Tab>.
set smarttab        " When on, a <Tab> in front of a line inserts blanks
                    " according to 'shiftwidth'. 'tabstop' is used in other
                    " places. A <BS> will delete a 'shiftwidth' worth of space
                    " at the start of the line.

set showcmd         " Show (partial) command in status line.

set number          " Show  current line number.
set relativenumber  " All other line numbers are distance from current line
set cursorline

set showmatch       " When a bracket is inserted, briefly jump to the matching
                    " one. The jump is only done if the match can be seen on the
                    " screen. The time to show the match can be set with
                    " 'matchtime'.

set textwidth=80    " Maximum width of text that is being inserted. A longer
                    " line will be broken after white space to get this width.

set formatoptions=c,q,rt " This is a sequence of letters which describes how
                    " automatic formatting is to be done.
                    "
                    " letter    meaning when present in 'formatoptions'
                    " ------    ---------------------------------------
                    " c         Auto-wrap comments using textwidth, inserting
                    "           the current comment leader automatically.
                    " q         Allow formatting of comments with "gq".
                    " r         Automatically insert the current comment leader
                    "           after hitting <Enter> in Insert mode.
                    " t         Auto-wrap text using textwidth (does not apply
                    "           to comments)

set ruler           " Show the line and column number of the cursor position,
                    " separated by a comma.


" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
"Plugin 'edkolev/tmuxline.vim'
"Plugin 'wellle/tmux-complete.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'bling/vim-airline'
"Plugin 'tomasr/molokai'
Plugin 'scrooloose/syntastic'
Plugin 'nanotech/jellybeans.vim'
"Plugin 'ervandew/supertab'
"Plugin 'sbl/scvim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"   Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
"   Plugin 'L9'
" Git plugin not hosted on GitHub
"   Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"   Plugin 'file:///home/gmarik/path/to/plugin'

" Airline.vim
let g:airline_powerline_fonts = 1
let g:airline_theme="bubblegum"
let g:airline_enable_syntastic = 1
set noshowmode      " Do not show current mode, airline already does
set laststatus=2    " airline is always visible

" Syntastic.vim
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'

" Supercollider
" let g:sclangTerm = "roxterm -e $SHELL -ic"
