" Prints white text on all of the bg colors and bolded text in every
" color on a white background (since bold will sometimes oddly change)
"
" To use:
"   :so color_name.vim
"
" TODO: Polish up code to also display black text and black bg variations

let num = 255
while num >= 0
    exec 'hi col_'.num.' cterm=bold ctermbg=white ctermfg='.num
    exec 'syn match col_'.num.' "ctermfg='.num.':...." containedIn=ALL'
    exec 'hi colb_'.num.' ctermbg='.num.' ctermfg=white'
    exec 'syn match colb_'.num.' "ctermbg='.num.':...." containedIn=ALL'
    call append(0, 'ctermbg='.num.':....'.'     ctermfg='.num.':....')
    let num = num - 1
endwhile
