" fairlyfloss.vim -- Vim color scheme.
" Author:      Kyle Kneitinger (kyle[at]kneit.in)
" Webpage:     https://github.com/kneitinger/dotfiles
" Description: A colorscheme lovingly derived from @sailorhg's fairyfloss theme https://sailorhg.github.io/fairyfloss/

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "fairlyfloss"

if ($TERM =~ '256' || &t_Co >= 256) || has("gui_running")
    hi Normal ctermbg=NONE ctermfg=15 cterm=NONE guibg=NONE guifg=#ffffff gui=NONE

    set background=dark

    hi NonText ctermbg=NONE ctermfg=15 cterm=NONE guibg=NONE guifg=#ffffff gui=NONE
    hi Comment ctermbg=NONE ctermfg=3 cterm=italic guibg=NONE guifg=#dfb508 gui=italic
    hi Constant ctermbg=NONE ctermfg=15 cterm=NONE guibg=NONE guifg=#ffffff gui=NONE
    hi Operator ctermbg=NONE ctermfg=13 cterm=NONE guibg=NONE guifg=#fda6c7 gui=NONE
    hi Error ctermbg=NONE ctermfg=13 cterm=italic guibg=NONE guifg=#fda6c7 gui=italic
    hi Identifier ctermbg=NONE ctermfg=14 cterm=NONE guibg=NONE guifg=#b7ffd7 gui=NONE
    hi Ignore ctermbg=NONE ctermfg=15 cterm=NONE guibg=NONE guifg=#ffffff gui=NONE
    hi PreProc ctermbg=NONE ctermfg=13 cterm=NONE guibg=NONE guifg=#fda6c7 gui=NONE
    hi Special ctermbg=NONE ctermfg=14 cterm=NONE guibg=NONE guifg=#b7ffd7 gui=NONE
    hi Statement ctermbg=NONE ctermfg=11 cterm=NONE guibg=NONE guifg=#ffe90a gui=NONE
    hi String ctermbg=NONE ctermfg=11 cterm=NONE guibg=NONE guifg=#ffe90a gui=NONE
    hi Todo ctermbg=NONE ctermfg=1 cterm=bold guibg=NONE guifg=#eb5d5c gui=bold
    hi Type ctermbg=NONE ctermfg=13 cterm=NONE guibg=NONE guifg=#fda6c7 gui=NONE
    hi Underlined ctermbg=NONE ctermfg=15 cterm=underline guibg=NONE guifg=#ffffff gui=underline
    hi StatusLine ctermbg=NONE ctermfg=15 cterm=NONE guibg=NONE guifg=#ffffff gui=NONE
    hi StatusLineNC ctermbg=NONE ctermfg=15 cterm=NONE guibg=NONE guifg=#ffffff gui=NONE
    hi VertSplit ctermbg=NONE ctermfg=15 cterm=NONE guibg=NONE guifg=#ffffff gui=NONE
    hi TabLine ctermbg=NONE ctermfg=15 cterm=NONE guibg=NONE guifg=#ffffff gui=NONE
    hi TabLineFill ctermbg=NONE ctermfg=15 cterm=NONE guibg=NONE guifg=#ffffff gui=NONE
    hi TabLineSel ctermbg=NONE ctermfg=15 cterm=NONE guibg=NONE guifg=#ffffff gui=NONE
    hi Title ctermbg=NONE ctermfg=15 cterm=NONE guibg=NONE guifg=#ffffff gui=NONE
    hi CursorLine ctermbg=8 ctermfg=NONE cterm=NONE guibg=#555555 guifg=NONE gui=NONE
    hi LineNr ctermbg=NONE ctermfg=12 cterm=NONE guibg=NONE guifg=#b78cff gui=NONE
    hi CursorLineNr ctermbg=NONE ctermfg=13 cterm=NONE guibg=NONE guifg=#fda6c7 gui=NONE
    hi helpLeadBlank ctermbg=NONE ctermfg=15 cterm=NONE guibg=NONE guifg=#ffffff gui=NONE
    hi helpNormal ctermbg=NONE ctermfg=15 cterm=NONE guibg=NONE guifg=#ffffff gui=NONE
    hi Visual ctermbg=0 ctermfg=NONE cterm=NONE guibg=#000000 guifg=NONE gui=NONE
    hi VisualNOS ctermbg=NONE ctermfg=15 cterm=NONE guibg=NONE guifg=#ffffff gui=NONE
    hi Pmenu ctermbg=NONE ctermfg=15 cterm=NONE guibg=NONE guifg=#ffffff gui=NONE
    hi PmenuSbar ctermbg=NONE ctermfg=15 cterm=NONE guibg=NONE guifg=#ffffff gui=NONE
    hi PmenuSel ctermbg=NONE ctermfg=15 cterm=NONE guibg=NONE guifg=#ffffff gui=NONE
    hi PmenuThumb ctermbg=NONE ctermfg=15 cterm=NONE guibg=NONE guifg=#ffffff gui=NONE
    hi FoldColumn ctermbg=NONE ctermfg=15 cterm=NONE guibg=NONE guifg=#ffffff gui=NONE
    hi Folded ctermbg=NONE ctermfg=15 cterm=NONE guibg=NONE guifg=#ffffff gui=NONE
    hi WildMenu ctermbg=NONE ctermfg=15 cterm=NONE guibg=NONE guifg=#ffffff gui=NONE
    hi SpecialKey ctermbg=NONE ctermfg=15 cterm=NONE guibg=NONE guifg=#ffffff gui=NONE
    hi DiffAdd ctermbg=NONE ctermfg=15 cterm=NONE guibg=NONE guifg=#ffffff gui=NONE
    hi DiffChange ctermbg=NONE ctermfg=15 cterm=NONE guibg=NONE guifg=#ffffff gui=NONE
    hi DiffDelete ctermbg=NONE ctermfg=15 cterm=NONE guibg=NONE guifg=#ffffff gui=NONE
    hi DiffText ctermbg=NONE ctermfg=15 cterm=NONE guibg=NONE guifg=#ffffff gui=NONE
    hi IncSearch ctermbg=NONE ctermfg=10 cterm=bold guibg=NONE guifg=#6dff6f gui=bold
    hi Search ctermbg=NONE ctermfg=10 cterm=NONE guibg=NONE guifg=#6dff6f gui=NONE
    hi Directory ctermbg=NONE ctermfg=15 cterm=NONE guibg=NONE guifg=#ffffff gui=NONE
    hi MatchParen ctermbg=NONE ctermfg=15 cterm=NONE guibg=NONE guifg=#ffffff gui=NONE
    hi SpellBad ctermbg=NONE ctermfg=15 cterm=underline guibg=NONE guifg=#ffffff gui=underline guisp=#fd8b89
    hi SpellCap ctermbg=NONE ctermfg=15 cterm=NONE guibg=NONE guifg=#ffffff gui=NONE guisp=#b78cff
    hi SpellLocal ctermbg=NONE ctermfg=15 cterm=NONE guibg=NONE guifg=#ffffff gui=NONE guisp=#fda6c7
    hi SpellRare ctermbg=NONE ctermfg=15 cterm=NONE guibg=NONE guifg=#ffffff gui=NONE guisp=#b7ffd7
    hi ColorColumn ctermbg=NONE ctermfg=15 cterm=NONE guibg=NONE guifg=#ffffff gui=NONE
    hi SignColumn ctermbg=NONE ctermfg=15 cterm=NONE guibg=NONE guifg=#ffffff gui=NONE
    hi ErrorMsg ctermbg=NONE ctermfg=15 cterm=NONE guibg=NONE guifg=#ffffff gui=NONE
    hi ModeMsg ctermbg=NONE ctermfg=15 cterm=NONE guibg=NONE guifg=#ffffff gui=NONE
    hi MoreMsg ctermbg=NONE ctermfg=15 cterm=NONE guibg=NONE guifg=#ffffff gui=NONE
    hi Question ctermbg=NONE ctermfg=15 cterm=NONE guibg=NONE guifg=#ffffff gui=NONE
    hi Cursor ctermbg=NONE ctermfg=15 cterm=NONE guibg=NONE guifg=#ffffff gui=NONE
    hi CursorColumn ctermbg=NONE ctermfg=15 cterm=NONE guibg=NONE guifg=#ffffff gui=NONE
    hi QuickFixLine ctermbg=NONE ctermfg=15 cterm=NONE guibg=NONE guifg=#ffffff gui=NONE
    hi StatusLine ctermbg=4 ctermfg=15 cterm=bold guibg=#9d65ff guifg=#ffffff gui=bold
    hi StatusLineTerm ctermbg=4 ctermfg=15 cterm=NONE guibg=#9d65ff guifg=#ffffff gui=NONE
    hi StatusLineTermNC ctermbg=NONE ctermfg=15 cterm=NONE guibg=NONE guifg=#ffffff gui=NONE
    hi rustFuncName ctermbg=NONE ctermfg=14 cterm=italic guibg=NONE guifg=#b7ffd7 gui=italic
    hi rustFuncCall ctermbg=NONE ctermfg=14 cterm=italic guibg=NONE guifg=#b7ffd7 gui=italic
    hi rustCommentLineDoc ctermbg=NONE ctermfg=14 cterm=italic guibg=NONE guifg=#b7ffd7 gui=italic
    hi PMenu ctermbg=4 ctermfg=15 cterm=NONE guibg=#9d65ff guifg=#ffffff gui=NONE
    hi CocErrorFloat ctermbg=8 ctermfg=13 cterm=NONE guibg=#555555 guifg=#fda6c7 gui=NONE
    hi CocWarningFloat ctermbg=4 ctermfg=11 cterm=NONE guibg=#9d65ff guifg=#ffe90a gui=NONE

    let g:terminal_ansi_colors = [
        \ '#000000',
        \ '#eb5d5c',
        \ '#5fe861',
        \ '#dfb508',
        \ '#9d65ff',
        \ '#fc6ea2',
        \ '#70f7aa',
        \ '#bbbbbb',
        \ '#555555',
        \ '#fd8b89',
        \ '#6dff6f',
        \ '#ffe90a',
        \ '#b78cff',
        \ '#fda6c7',
        \ '#b7ffd7',
        \ '#ffffff',
        \ ]

elseif &t_Co == 8 || $TERM !~# '^linux' || &t_Co == 16
    set t_Co=16

    hi Normal ctermbg=NONE ctermfg=white cterm=NONE

    set background=dark

    hi NonText ctermbg=NONE ctermfg=white cterm=NONE
    hi Comment ctermbg=NONE ctermfg=darkyellow cterm=italic
    hi Constant ctermbg=NONE ctermfg=white cterm=NONE
    hi Operator ctermbg=NONE ctermfg=magenta cterm=NONE
    hi Error ctermbg=NONE ctermfg=magenta cterm=italic
    hi Identifier ctermbg=NONE ctermfg=cyan cterm=NONE
    hi Ignore ctermbg=NONE ctermfg=white cterm=NONE
    hi PreProc ctermbg=NONE ctermfg=magenta cterm=NONE
    hi Special ctermbg=NONE ctermfg=cyan cterm=NONE
    hi Statement ctermbg=NONE ctermfg=yellow cterm=NONE
    hi String ctermbg=NONE ctermfg=yellow cterm=NONE
    hi Todo ctermbg=NONE ctermfg=darkred cterm=bold
    hi Type ctermbg=NONE ctermfg=magenta cterm=NONE
    hi Underlined ctermbg=NONE ctermfg=white cterm=underline
    hi StatusLine ctermbg=NONE ctermfg=white cterm=NONE
    hi StatusLineNC ctermbg=NONE ctermfg=white cterm=NONE
    hi VertSplit ctermbg=NONE ctermfg=white cterm=NONE
    hi TabLine ctermbg=NONE ctermfg=white cterm=NONE
    hi TabLineFill ctermbg=NONE ctermfg=white cterm=NONE
    hi TabLineSel ctermbg=NONE ctermfg=white cterm=NONE
    hi Title ctermbg=NONE ctermfg=white cterm=NONE
    hi CursorLine ctermbg=darkgray ctermfg=NONE cterm=NONE
    hi LineNr ctermbg=NONE ctermfg=blue cterm=NONE
    hi CursorLineNr ctermbg=NONE ctermfg=magenta cterm=NONE
    hi helpLeadBlank ctermbg=NONE ctermfg=white cterm=NONE
    hi helpNormal ctermbg=NONE ctermfg=white cterm=NONE
    hi Visual ctermbg=black ctermfg=NONE cterm=NONE
    hi VisualNOS ctermbg=NONE ctermfg=white cterm=NONE
    hi Pmenu ctermbg=NONE ctermfg=white cterm=NONE
    hi PmenuSbar ctermbg=NONE ctermfg=white cterm=NONE
    hi PmenuSel ctermbg=NONE ctermfg=white cterm=NONE
    hi PmenuThumb ctermbg=NONE ctermfg=white cterm=NONE
    hi FoldColumn ctermbg=NONE ctermfg=white cterm=NONE
    hi Folded ctermbg=NONE ctermfg=white cterm=NONE
    hi WildMenu ctermbg=NONE ctermfg=white cterm=NONE
    hi SpecialKey ctermbg=NONE ctermfg=white cterm=NONE
    hi DiffAdd ctermbg=NONE ctermfg=white cterm=NONE
    hi DiffChange ctermbg=NONE ctermfg=white cterm=NONE
    hi DiffDelete ctermbg=NONE ctermfg=white cterm=NONE
    hi DiffText ctermbg=NONE ctermfg=white cterm=NONE
    hi IncSearch ctermbg=NONE ctermfg=green cterm=bold
    hi Search ctermbg=NONE ctermfg=green cterm=NONE
    hi Directory ctermbg=NONE ctermfg=white cterm=NONE
    hi MatchParen ctermbg=NONE ctermfg=white cterm=NONE
    hi SpellBad ctermbg=NONE ctermfg=white cterm=underline
    hi SpellCap ctermbg=NONE ctermfg=white cterm=NONE
    hi SpellLocal ctermbg=NONE ctermfg=white cterm=NONE
    hi SpellRare ctermbg=NONE ctermfg=white cterm=NONE
    hi ColorColumn ctermbg=NONE ctermfg=white cterm=NONE
    hi SignColumn ctermbg=NONE ctermfg=white cterm=NONE
    hi ErrorMsg ctermbg=NONE ctermfg=white cterm=NONE
    hi ModeMsg ctermbg=NONE ctermfg=white cterm=NONE
    hi MoreMsg ctermbg=NONE ctermfg=white cterm=NONE
    hi Question ctermbg=NONE ctermfg=white cterm=NONE
    hi Cursor ctermbg=NONE ctermfg=white cterm=NONE
    hi CursorColumn ctermbg=NONE ctermfg=white cterm=NONE
    hi QuickFixLine ctermbg=NONE ctermfg=white cterm=NONE
    hi StatusLine ctermbg=darkblue ctermfg=white cterm=bold
    hi StatusLineTerm ctermbg=darkblue ctermfg=white cterm=NONE
    hi StatusLineTermNC ctermbg=NONE ctermfg=white cterm=NONE
    hi rustFuncName ctermbg=NONE ctermfg=cyan cterm=italic
    hi rustFuncCall ctermbg=NONE ctermfg=cyan cterm=italic
    hi rustCommentLineDoc ctermbg=NONE ctermfg=cyan cterm=italic
    hi PMenu ctermbg=darkblue ctermfg=white cterm=NONE
    hi CocErrorFloat ctermbg=darkgray ctermfg=magenta cterm=NONE
    hi CocWarningFloat ctermbg=darkblue ctermfg=yellow cterm=NONE
endif

let links = [
    \ ['Number', 'Constant'],
    \ ['Function', 'Normal'],
    \ ['WarningMsg', 'Error'],
    \ ]

augroup fairlyfloss
    autocmd!
    autocmd ColorScheme * if expand("<amatch>") == "fairlyfloss" | for link in links | execute 'hi link' link[0] link[1] | endfor | else | for link in links | execute 'hi link' link[0] 'NONE' | endfor | endif
augroup END

" Generated with RNB (https://gist.github.com/romainl/5cd2f4ec222805f49eca)

