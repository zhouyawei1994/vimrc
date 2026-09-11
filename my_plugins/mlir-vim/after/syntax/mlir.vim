if get(b:, 'current_syntax', '') ==# 'mlir'
  " Remove the older per-dialect catch-alls from ~/.vim/after/syntax/mlir.vim.
  silent! syntax clear mlirArithOp mlirAffineOp mlirLinalgOp mlirTosaOp
        \ mlirVectorOp mlirMemrefOp mlirFuncOp mlirGpuOp mlirAsyncOp
        \ mlirCustomOp mlirLoc
  syntax match mlirLocation /\<loc\ze\s*(/
  call mlir#syntax#DefineDialectOperations()
endif
