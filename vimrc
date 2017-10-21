"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pathogen Initialization
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
call pathogen#helptags()
syntax on
filetype plugin indent on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Basic Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if !has('nvim')
    set nocompatible
    set t_Co=256        " 256 color mode
endif

set encoding=utf-8
set noerrorbells
set novisualbell
set t_vb=
set tm=500

set autoread        " Automatically reload files upon change
set history=1000

" buffers need not be written before switching
" http://derekwyatt.org/2009/08/20/the-absolute-bare-minimum/
set hidden

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Appearance
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set background=dark
" bytefluent.com/vivify is a good scheme discovery tool
try
    colorscheme alduin
catch
    colorscheme jellybeans
endtry

set colorcolumn=81

" Ensure that highlight commands are run after colorscheme is loaded
" run :so ~/.vim/color_names.vim to find desired values
au! VimEnter  * hi Comment     cterm=italic
              \ | hi MatchParen  ctermfg=15 ctermbg=131
              \ | hi StatusLine  cterm=bold ctermbg=131 ctermfg=16
              \ | hi User1       ctermbg=131
              \ | hi TabLineSel  cterm=bold ctermfg=16 ctermbg=131
              \ | hi TabLine     cterm=standout,italic ctermfg=0 ctermbg=131
              \ | hi TabLineFill ctermbg=0
              \ | hi Normal guibg=NONE ctermbg=NONE

set laststatus=2    " always show status bar

" status: [paste indicator][buffer num][filename][git stuff][modified][readonly]
set statusline=%{HasPaste()}[%n][%<%F]%{fugitive#statusline()}%m%r%=
" status: spacer [filetype]['Col:'column]['Line:' n/N:percentage through file]
set statusline+=%y[Col:%c][Line:%l/%L:%p%%]

set tabline=%!TabLine()

set number          " Show  current line number.
set relativenumber  " All other line numbers are distance from current line
set cursorline      " Highlight current line
set showcmd         " Show (partial) command in status line.
set lazyredraw      " Don't redraw screen until macro completes
set scrolloff=5     " Pad scrolls with 5 lines of context
set wildmenu        " Show bar of command autocompletes
set wildignore=*.o,*.out,*~,*.pyc,*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
set cmdheight=2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ','
let g:mapleader = ','

" Make motion on wrapped lines intuitive
noremap <silent> j gj
noremap <silent> k gk
" Save on 2 Escs
map <Esc><Esc> :w<CR>
" No Ex mode!!
noremap Q <Nop>
" Make Y behave like C/D, instead of yy
map Y y$
" Clear search highlights upon screen-clear
nnoremap <C-L> :nohl<CR><C-L>
" Reselect visual block after indent
vnoremap < <gv
vnoremap > >gv
" Add newline in normal mode with return key
nmap <CR> o<Esc>
" Change cursor position in insert mode
inoremap <C-h> <left>
inoremap <C-l> <right>
inoremap <C-k> <up>
inoremap <C-j> <down>

" Move between windows with std vim movements
map <C-h> :tabprevious<CR>
map <C-l> :tabnext<CR>

" Tab creation/movement
map <leader>tc :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>td :tabclose<cr>
map <leader>tm :tabmove
map <leader>tn :tabnext<cr>
map <leader>tb :tabprevious<cr>
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/
" Go to last tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Toggle paste mode on and off
set pastetoggle=
map <leader>pp :setlocal paste!<cr>


" * or # search for selection in visual mode
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Edit .vimrc
nmap <silent> <leader>ev :e $MYVIMRC<cr>
" Source .vimrc
nmap <silent> <leader>sv :so $MYVIMRC<cr>

" Spell check on/off
nmap <silent> <leader>sp :setlocal spell!<CR>
" Spell check jump
map <leader>sn ]s
map <leader>sp [s
" Spell check add
map <leader>sa zg
" Spell check suggestions
map <leader>s? z=

set mouse=a         " Enable the use of the mouse.

" Remove trailing whitespace
" http://vim.wikia.com/wiki/Remove_unwanted_spaces
nmap <leader>w :cal StripTrailingWhitespace()<CR>


" Search Options
set hlsearch        " Highlight all search matches
set incsearch       " Match as search pattern is being typed
set ignorecase      " Ignore case in search patterns ...
set smartcase       " ...unless the search term has an upper case character



" Tabs, spaces and backspaces
" set backspace=2     " Influences the working of <BS>, <Del>, CTRL-W
                    " and CTRL-U in Insert mode. This is a list of items,
                    " separated by commas. Each item allows a way to backspace
                    " over something.

set autoindent      " Copy indent from current line when starting a new line
set smartindent     " Make intuitive indent choices for some contexrs

set tabstop=4       " Number of spaces that a <Tab> in the file counts for.
set shiftwidth=4    " Number of spaces to use for each step of (auto)indent.
set expandtab       " Use the appropriate number of spaces to insert a <Tab>.
set smarttab        " Be smart about auto tabbing

set showmatch       " When a bracket is inserted, show the matching one
set matchtime=1     " Tenths of a second to show the match

set textwidth=79    " Line auto-break column threshold

set formatoptions=c,r,q,t,j

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filetype-Specific Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Force certain extensions to be recognized
augroup filetype
    au! BufRead,BufNewFile *.ll     set filetype=llvm
    au! BufRead,BufNewFile *.fst    set filetype=faust
    au! BufRead,BufNewFile *.dsp    set filetype=faust
    au! BufRead,BufNewFile *.lib    set filetype=faust
    au! BufRead,BufNewFile *.lhs    set textwidth=74
    au! BufRead,BufNewFile *.lhs    set colorcolumn=76
    au! BufRead,BufNewFile *.yml    set ts=2 shiftwidth=2
augroup END

autocmd FileType tex setlocal shiftwidth=2 tabstop=2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Miscellaneous Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" W allows writing a file that you forgot to sudo vim on
"   - existence check lets you :source vimrc without error
if !exists("sudowrite")
    command W w !sudo tee % > /dev/null
    let sudowrite=1
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Backup/Swap/Persistence Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
try
    set undodir=~/.vim/cache/undo
    set undofile
catch
endtry

try
    set backupdir=~/.vim/cache/backup
    set backup
catch
endtry

try
    set directory=~/.vim/cache/swap
    set swapfile
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Function definitions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

" For use in status line
function! HasPaste()
    if &paste
        return '[PASTE]'
    endif
    return ''
endfunction

function! TabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    let tabnr = i + 1 " range() starts at 0
    let winnr = tabpagewinnr(tabnr)
    let buflist = tabpagebuflist(tabnr)
    let bufnr = buflist[winnr - 1]
    let bufname = fnamemodify(bufname(bufnr), ':t')

    let s .= '%' . tabnr . 'T'
    let s .= (tabnr == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
    let s .= ' ' . tabnr

    let n = tabpagewinnr(tabnr,'$')
    if n > 1 | let s .= ':' . n | endif

    let s .= empty(bufname) ? ' [No Name]' : ' ' . bufname

    let bufmodified = getbufvar(bufnr, "&mod")
    if bufmodified | let s .= '[+] ' | else | let s .= ' ' | endif
  endfor
  let s .= '%#TabLineFill#'
  return s
endfunction

" Load freebsd style functions, mapped to <leader>f
source $HOME/.vim/scripts/freebsd.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" LaTeX Suite
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat = "pdf"
let g:Tex_ViewRule_pdf = "zathura --debug=error"
let g:Tex_CompileRule_pdf = "latexmk -pdf -shell-escape"
let g:Tex_Leader = '/'
let g:Imap_FreezeImap = 1
let g:tex_conceal = ""

" Indentline
let g:indentLine_char = '┆'
let g:indentLine_color_term = 238

" Tabular
" http://vimcasts.org/episodes/aligning-text-with-tabular-vim/

" UltiSnips
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/snippets']
let g:UltiSnipsExpandTrigger="<c-\\>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" Deoplete
let g:deoplete#enable_at_startup = 1
" Use tab for suggestion selection
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
"let g:python2_host_prog = '/home/leaf/.pyenv/neovim2/bin/python'
let g:python3_host_prog = '/home/leaf/.vim/.venv/bin/python'

" vim-terraform
let g:terraform_align=1
let g:terraform_fmt_on_save=1
