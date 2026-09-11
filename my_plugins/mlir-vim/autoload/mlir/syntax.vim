function! mlir#syntax#DefineDialectOperations() abort
  " Match every bare or quoted dialect operation, including downstream dialects.
  " Re-running these definitions from after/syntax gives them final priority.
  syntax match mlirOperation /\<\h[A-Za-z0-9_$-]*\.[A-Za-z_][A-Za-z0-9_$.-]*\>/
  syntax match mlirOperation /"\h[A-Za-z0-9_$-]*\.[A-Za-z_][A-Za-z0-9_$.-]*"\ze\s*(/

  syntax match mlirCoreOperation /\<\%(builtin\|func\|cf\|scf\|affine\|async\|ub\)\.[A-Za-z_][A-Za-z0-9_$.-]*\>/
  syntax match mlirCoreOperation /"\%(builtin\|func\|cf\|scf\|affine\|async\|ub\)\.[A-Za-z_][A-Za-z0-9_$.-]*"\ze\s*(/
  syntax match mlirArithmeticOperation /\<\%(arith\|math\|complex\|index\|polynomial\)\.[A-Za-z_][A-Za-z0-9_$.-]*\>/
  syntax match mlirArithmeticOperation /"\%(arith\|math\|complex\|index\|polynomial\)\.[A-Za-z_][A-Za-z0-9_$.-]*"\ze\s*(/
  syntax match mlirMemoryOperation /\<\%(memref\|tensor\|vector\|bufferization\|sparse_tensor\|ptr\)\.[A-Za-z_][A-Za-z0-9_$.-]*\>/
  syntax match mlirMemoryOperation /"\%(memref\|tensor\|vector\|bufferization\|sparse_tensor\|ptr\)\.[A-Za-z_][A-Za-z0-9_$.-]*"\ze\s*(/
  syntax match mlirStructuredOperation /\<\%(linalg\|shape\|tosa\|mhlo\|stablehlo\|quant\|mesh\|ml_program\)\.[A-Za-z_][A-Za-z0-9_$.-]*\>/
  syntax match mlirStructuredOperation /"\%(linalg\|shape\|tosa\|mhlo\|stablehlo\|quant\|mesh\|ml_program\)\.[A-Za-z_][A-Za-z0-9_$.-]*"\ze\s*(/
  syntax match mlirTargetOperation /\<\%(llvm\|gpu\|nvgpu\|nvvm\|amdgpu\|rocdl\|spirv\|arm_neon\|arm_sme\|arm_sve\|amx\|x86vector\|omp\|mpi\|emitc\|dlti\)\.[A-Za-z_][A-Za-z0-9_$.-]*\>/
  syntax match mlirTargetOperation /"\%(llvm\|gpu\|nvgpu\|nvvm\|amdgpu\|rocdl\|spirv\|arm_neon\|arm_sme\|arm_sve\|amx\|x86vector\|omp\|mpi\|emitc\|dlti\)\.[A-Za-z_][A-Za-z0-9_$.-]*"\ze\s*(/
  syntax match mlirTransformOperation /\<\%(transform\|pdl\|pdl_interp\|irdl\)\.[A-Za-z_][A-Za-z0-9_$.-]*\>/
  syntax match mlirTransformOperation /"\%(transform\|pdl\|pdl_interp\|irdl\)\.[A-Za-z_][A-Za-z0-9_$.-]*"\ze\s*(/
  syntax match mlirMLUIROperation /\<\%(mluir\|mlir\)\.[A-Za-z_][A-Za-z0-9_$.-]*\>/
  syntax match mlirMLUIROperation /"\%(mluir\|mlir\)\.[A-Za-z_][A-Za-z0-9_$.-]*"\ze\s*(/
endfunction
