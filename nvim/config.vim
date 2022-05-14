" Compile function
noremap <leader><cr> :call CompileRunGcc()<CR>
func! CompileRunGcc()
  if &filetype == 'markdown'
    exec "MarkdownPreview"
  endif
endfunc
