au! BufNewFile,BufRead *.note setf note
" Load tag file
silent exe "set tags+=./.hypernote"
