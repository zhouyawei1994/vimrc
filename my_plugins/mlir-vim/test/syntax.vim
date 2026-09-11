set nocompatible
let s:plugin = fnamemodify(expand('<sfile>:p'), ':h:h')
if get(g:, 'mlir_test_keep_runtimepath', 0)
  execute 'set runtimepath^=' . fnameescape(s:plugin)
  execute 'set runtimepath+=' . fnameescape(s:plugin . '/after')
else
  execute 'set runtimepath=' . fnameescape(s:plugin) . ',' . fnameescape($VIMRUNTIME)
endif
filetype plugin indent on
syntax enable

enew
file syntax-test.td
doautocmd BufRead syntax-test.td
if !get(g:, 'mlir_test_keep_runtimepath', 0)
  call assert_notequal('mlir', &filetype, 'TableGen files must not use MLIR syntax')
endif

enew
file syntax-test.mlir
doautocmd BufRead syntax-test.mlir
call assert_equal('mlir', &filetype, 'filetype detection')

call setline(1, [
      \ '"builtin.module"() ({',
      \ '  %sum = arith.addi %lhs, %rhs : i32',
      \ '  %root = math.sqrt %arg : f32',
      \ '  %moved = "mluir.smove"(%arg) : (memref<4xf32>) -> memref<4xf32>',
      \ '  %value = memref.load %buffer[%c0] : memref<4xf32>',
      \ '  llvm.return',
      \ '  // CHECK: arith.addi',
      \ '  %flag = arith.constant true : i1',
      \ '  %0 = "downstream.any_new_op"() : () -> tensor<2x?xf32>',
      \ '  ^bb1(%arg0: tensor<4xf32>):',
      \ '}) : () -> ()',
      \ 'loc("source.mlir":12:3)',
      \ ])
syntax sync fromstart

function! s:AssertGroup(line, text, expected) abort
  let l:column = match(getline(a:line), '\V' . escape(a:text, '\')) + 1
  call assert_true(l:column > 0, 'missing test token: ' . a:text)
  let l:actual = synIDattr(synID(a:line, l:column, 1), 'name')
  call assert_equal(a:expected, l:actual, a:text)
endfunction

call s:AssertGroup(1, 'builtin.module', 'mlirCoreOperation')
call s:AssertGroup(2, 'arith.addi', 'mlirArithmeticOperation')
call s:AssertGroup(3, 'math.sqrt', 'mlirArithmeticOperation')
call s:AssertGroup(4, 'mluir.smove', 'mlirMLUIROperation')
call s:AssertGroup(5, 'memref.load', 'mlirMemoryOperation')
call s:AssertGroup(6, 'llvm.return', 'mlirTargetOperation')
call s:AssertGroup(7, '// CHECK:', 'mlirSpecialComment')
call s:AssertGroup(8, 'true', 'mlirBoolean')
call s:AssertGroup(9, 'downstream.any_new_op', 'mlirOperation')
call s:AssertGroup(10, '^bb1', 'mlirBlockIdentifier')
call s:AssertGroup(10, 'tensor', 'mlirType')
call s:AssertGroup(12, 'loc', 'mlirLocation')
call s:AssertGroup(12, '"source.mlir"', 'mlirString')

if !empty(v:errors)
  for s:error in v:errors
    echomsg s:error
  endfor
  cquit
endif
quit!
