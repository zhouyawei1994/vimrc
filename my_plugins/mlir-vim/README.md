# MLIR Vim support

This local plugin provides file detection, syntax highlighting, indentation,
and buffer settings for `*.mlir` files. It is loaded automatically through the
repository's `my_plugins` Pathogen path.

Operation highlighting is grammar-oriented: any bare or quoted
`dialect.operation` is recognized, so downstream operations do not require an
exhaustive list. Common families receive distinct highlight groups:

- builtin, func, cf, scf, affine, async, and UB
- arith, math, complex, index, and polynomial
- memref, tensor, vector, bufferization, sparse_tensor, and ptr
- linalg, shape, TOSA, MHLO, StableHLO, quant, mesh, and ml_program
- LLVM, SPIR-V, GPU, NVVM, ROCDL, AMDGPU, OpenMP, and target dialects
- transform, PDL, PDL interpreter, and IRDL
- the downstream `mluir` and `mlir` namespaces

TableGen (`*.td`) is deliberately not detected as MLIR.

Run the self-test from the repository root with:

```sh
vim -Nu NONE -n -es -S my_plugins/mlir-vim/test/syntax.vim
```
