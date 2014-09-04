function! LinkToNote()
  " Turn the current word (<cword>) into a link (i.e. embed it in '*' if it
  " isn't *already*) add new tag to tags file, load new tags and create new file
  " if it doesn't exist.

  let extension = ".note"
  let index = "./.hypernote"

  let l = line(".")
  let c = col(".")

  let file = expand("<cword>") . extension
  let note = expand("<cword>")

  " If the current word isn't already a link, make it so
  if !CurentrWordIsLink()
    norm!ciw*
    norm!""pa*
  endif

  call cursor(l, c + 1)

  " Add to index (tags list) - if it isn't already added
  let entry = note . "\\t" . file . "\\t1"
  silent exe "!grep -q \"" . entry . "\" " . index . " || echo -e \"" . entry . "\" >> " . index
  " Make sure tag file is sorted
  silent exe "!sort " . index . " -o " . index
  " Reload tag file
  silent exe "set tags+=" . index

  " Create file if it doesn't exist
  if !filereadable(file)
    silent exe "!touch " . file
    echo file . " created"
  endif
endfunction

function! CurentrWordIsLink()
  " In *order* to determine if *current* word should have '|' pre- and *appended*,
  " this function checks if <cword> is already a link, in which case it returns
  " 0 - otherwise it returns 1.
  let l = line(".")
  let c = col(".")
  " Make sure we start at the end of the word
  norm!viwv
  let char2 = getline(".")[col(".")]
  norm!b
  let char1 = getline(".")[col(".") - 2]
  call cursor(l, c)
  return char1 == "*" && char2 == "*" || char1 == "|" && char2 == "|"
endfunction

nnoremap <leader>l :call LinkToNote()<CR>
