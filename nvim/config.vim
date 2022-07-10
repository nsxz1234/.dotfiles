" Compile function
nnoremap <leader><cr> :call CompileRunGcc()<CR>
func! CompileRunGcc()
  if &filetype == 'markdown'
    exec "MarkdownPreview"
  endif
endfunc
