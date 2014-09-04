if exists("b:current_syntax")
  finish
endif

syn match hyperLink "\*[^"*|]\+\*\s"he=e-1 contains=linkStar
syn match hyperLink "\*[^"*|]\+\*$" contains=linkStar

syn match linkStar contained "\*" conceal

hi def link linkStar Ignore
hi def link hyperLink String

let b:current_syntax = "note"

setlocal conceallevel=2
setlocal concealcursor=vin
