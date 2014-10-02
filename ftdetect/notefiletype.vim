au! BufNewFile,BufRead *.note setf note
" Load tag file
au! BufNewFile,BufRead *.note silent exe "set tags+=./.hypernote"
