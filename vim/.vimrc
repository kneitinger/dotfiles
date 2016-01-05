let g:OS = 'linux'
set t_Co=256        " 256 color mode
set encoding=utf-8
set background=dark
set noerrorbells
set vb

set nocompatible
filetype off        " required for vundle, re-enabled later.

syntax enable
colorscheme jellybeans

set laststatus=2
hi StatusLine term=reverse ctermbg=4 gui=undercurl guisp=Cyan
set statusline=[%n][%<%F]%h%m%r%=%y[Line:%l/%L][Col:%v][%p%%]
"hi ColorColumn   ctermfg=NONE ctermbg=235 cterm=NONE guifg=NONE guibg=#3c3c3c gui=NONE
"set colorcolumn=80

let mapleader = '\'

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
nmap <leader>w :cal StripTrailingWhitespace()<CR>


map j gj
map k gk
map <Up> <nop>
map <Down> <nop>
map <Left> <nop>
map <Right> <nop>
set mouse=a         " Enable the use of the mouse.
map <Esc><Esc> :w<CR>
noremap Q <Nop>

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
"setlocal spell spelllang=en_us
set tabstop=4       " Number of spaces that a <Tab> in the file counts for.
set shiftwidth=4    " Number of spaces to use for each step of (auto)indent.
set expandtab       " Use the appropriate number of spaces to insert a <Tab>.
set smarttab        " When on, a <Tab> in front of a line inserts blanks
                    " according to 'shiftwidth'. 'tabstop' is used in other
                    " places. A <BS> will delete a 'shiftwidth' worth of space
                    " at the start of the line.

set showcmd         " Show (partial) command in status line.

set number          " Show  current line number.

" Sometimes slow yet very helpful
set relativenumber  " All other line numbers are distance from current line
set cursorline

set showmatch       " When a bracket is inserted, briefly jump to the matching
                    " one. The jump is only done if the match can be seen on the
                    " screen. The time to show the match can be set with
                    " 'matchtime'.

set textwidth=80    " Maximum width of text that is being inserted. A longer
                    " line will be broken after white space to get this width.

set formatoptions=c,q " This is a sequence of letters which describes how
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

" set the runtime path to include Vundle and initialize
"set rtp+=~/.vim/bundle/Vundle.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'vim-latex/vim-latex'
Plugin 'Valloric/YouCompleteMe'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"YouCompleteMe
let g:ycm_warning_symbol = '⚠'
let g:ycm_error_symbol = '✗'
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_insertion = 1

" LaTeX Suite
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat = "pdf"
let g:Tex_ViewRule_pdf = "zathura --debug=error"
let g:Tex_CompileRule_pdf = "rubber --pdf --warn all"
"let g:Tex_CompileRule_pdf = "xelatex"
let g:Tex_Leader = '/'
let g:Imap_FreezeImap = 1

"let g:livepreview_previewer = "zathura --debug=error"

