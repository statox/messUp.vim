" Core file

function! ReverseString(string)
    let res=""

    let i=0

    while i < strlen(a:string)
        let res=strpart(a:string, i, 1) . res
        let i=i+1
    endwhile

    echom ""
    return res
endfunction

echom "Debut"
echom ""
echom ""
echom ""
echom ""

let toto=ReverseString("pouet")
echom toto
let toto=ReverseString("pouet2")
echom toto
let toto=ReverseString("coucou")
echom toto
let toto=ReverseString("blob")
echom toto


echom "Fin"
