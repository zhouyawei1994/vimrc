" Detect TableGen files (*.td), e.g. MLIR dialect definitions such as
" MLUOps.td / MLVMOps.td in llvm-project.
augroup tablegen_filetype
  autocmd!
  autocmd BufNewFile,BufRead *.td setfiletype tablegen
augroup END
