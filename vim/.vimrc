" .vimrc

set nocompatible
let g:OS = 'linux'
set t_Co=256
set encoding=utf-8
set background=dark
set number          " Show  current line number.
set relativenumber  " All other line numbers are distance from current line
set cursorline
syntax on

filetype off        " required

" Funcions

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

" Remaps
let mapleader = ','
nmap <leader>tw :call StripTrailingWhitespace()<CR>
" Disable Arrow Keys
map <Up> <nop>
map <Down> <nop>
map <Left> <nop>
map <Right> <nop>

" Search Options
set hlsearch        " When there is a previous search pattern, highlight all
                    " its matches.
set incsearch       " While typing a search command, show immediately where the
                    " so far typed pattern matches.
set ignorecase      " Ignore case in search patterns.
set smartcase       " Override the 'ignorecase' option if the search pattern
                    " contains upper case characters.


" Tabs, spaces and backspaces
set backspace=2     " Influences the working of <BS>, <Del>, CTRL-W
                    " and CTRL-U in Insert mode. This is a list of items,
                    " separated by commas. Each item allows a way to backspace
                    " over something.

set autoindent      " Copy indent from current line when starting a new line
                    " (typing <CR> in Insert mode or when using the "o" or "O"

set tabstop=4       " Number of spaces that a <Tab> in the file counts for.
set shiftwidth=4    " Number of spaces to use for each step of (auto)indent.
set expandtab       " Use the appropriate number of spaces to insert a <Tab>.
                    " Spaces are used in indents with the '>' and '<' commands
                    " and when 'autoindent' is on. To insert a real tab when
                    " 'expandtab' is on, use CTRL-V <Tab>.
set smarttab        " When on, a <Tab> in front of a line inserts blanks
                    " according to 'shiftwidth'. 'tabstop' is used in other
                    " places. A <BS> will delete a 'shiftwidth' worth of space
                    " at the start of the line.

set showcmd         " Show (partial) command in status line.

set textwidth=80

set formatoptions=c,q,r,t " This is a sequence of letters which describes how
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

" Airline.vim
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme="bubblegum"
let g:airline_enable_syntastic = 1
set noshowmode      " Do not show current mode, airline already does
set laststatus=2    " airline is always visible

" Syntastic.vim
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'

call pathogen#infect()
filetype plugin indent on
