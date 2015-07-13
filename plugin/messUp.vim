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

" returns the last text selected
function! GetSelectedText()
    normal gv"xy
    let result = getreg("x")
    normal gv
    return result
endfunc

" wrapper function: apply a transformation on the selected text
" param: functionToExecute name of the function to apply on the selection
function! ProcessSelectedText(functionToExecute)
    
    " get the function to use for the arguments
    let s:processingFunction = function(a:functionToExecute)

    " Get the string to insert
    let @x = s:processingFunction(GetSelectedText())
    "setreg('x', s:processingFunction(GetSelectedText()))

    " replace the selection with the new string
    normal "xp

endfunction
