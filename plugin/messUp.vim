" File: messUp.vim
" Author: Adrien Fabre (statox)

" reverse the order of the letters in the parameter string
" params:   string:     the string to reverse
" returns:  the reversed string
function! ReverseString(string)
    let res=""
    let i=0

    while i < strlen(a:string)
        let res=strpart(a:string, i, 1) . res
        let i=i+1
    endwhile

    return res
endfunction

" generate a random number between 0 and a max bound
" params:   max:    the maximum bound
" returns:  the random number
function! s:randnum(max) abort
  return str2nr(matchstr(reltimestr(reltime()), '\v\.@<=\d+')[1:]) % a:max
endfunction

" shuflles the letters in the parameter string
" params:   string:     the string to shuffle
" returns:  the shuffled string
function! RandomizeString(string)
    let res=a:string
    let i=0

    while i < strlen(res)
        let rand=s:randnum(strlen(res)) 

        let char1=strpart(res, rand, 1)
        let char2=strpart(res, i, 1)
        
        let res=substitute(res, char1, "XXX", "")
        let res=substitute(res, char2, char1, "")
        let res=substitute(res, "XXX", char2, "")

        let i=i+1
    endwhile

    return res
endfunction


function! RotateString(string)
    let res=""
    let offset=5
    let i=0

    while i < strlen(a:string)
        if (i+offset) >= strlen(a:string)
            let offset=offset-strlen(a:string)
        endif

        let res=res . strpart(a:string, i+offset, 1)

        let i=i+1
    endwhile
    
    return res
endfunction

" returns the last text selected
function! GetSelectedText()
    normal gv"xy
    return getreg("x")
endfunc

" wrapper function: apply a transformation on the selected text
" param: functionToExecute name of the function to apply on the selection
function! ProcessSelectedText(functionToExecute)
    " get the function to use for the arguments
    let s:processingFunction = function(a:functionToExecute)

    " Get the string to insert
    call setreg('x', s:processingFunction(GetSelectedText()), getregtype(GetSelectedText()))

    " replace the selection with the new string
    normal gv
    normal "xp

endfunction

" Let the users override the default mapping if they want
if !exists('g:messUpVim_map_keys')
    let g:messUpVim_map_keys = 1
endif

" create the mappings of the plugin
if g:messUpVim_map_keys
    vnoremap <Leader>er <Esc>:call ProcessSelectedText('ReverseString')<CR>
    vnoremap <Leader>es <Esc>:call ProcessSelectedText('RandomizeString')<CR>
    vnoremap <Leader>eo <Esc>:call ProcessSelectedText('RotateString')<CR>
endif
