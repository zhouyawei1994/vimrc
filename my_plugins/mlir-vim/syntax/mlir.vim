" Vim syntax file
" Language: MLIR
" Based on LLVM's MLIR Vim syntax, with grammar-oriented dialect coverage.

if version < 600
  syntax clear
elseif exists('b:current_syntax')
  finish
endif

syntax case match

" Comments, strings, and test directives.
syntax match mlirEscape /\\\%([\\"nrt]\|x[0-9A-Fa-f]\{2}\|[0-9A-Fa-f]\{2}\)/ contained
syntax region mlirString start=/"/ skip=/\\\\\|\\"/ end=/"/ contains=mlirEscape
syntax match mlirComment /\/\/.*$/ contains=@Spell,mlirTodo
syntax keyword mlirTodo TODO FIXME XXX NOTE contained
syntax match mlirSpecialComment /\/\/\s*\%(RUN\|DEFINE\|REDEFINE\|CHECK\|COM\|PREFIX\|UNSUPPORTED\|REQUIRES\|XFAIL\):.*$/
syntax match mlirSpecialComment /\/\/\s*CHECK-\%(NEXT\|NOT\|DAG\|SAME\|EMPTY\|LABEL\|COUNT-[0-9]\+\):.*$/
syntax match mlirSpecialComment /\/\/\s*expected-\%(error\|warning\|remark\|note\)\>.*$/

" Builtin scalar and aggregate types.
syntax match mlirType /\<\%(index\|none\|bf16\|tf32\|f[0-9]\+[A-Za-z0-9]*\|[us]\?i[0-9]\+\)\>/
syntax match mlirType /\<\%(complex\|memref\|tensor\|tuple\|vector\)\ze\s*</
syntax match mlirType /x\s*\zs\%(memref\|tensor\|vector\)\ze\s*</
syntax match mlirTypeAlias /![A-Za-z$._-][A-Za-z0-9$._-]*/
syntax match mlirTypeAlias /![0-9]\+\>/

" SSA values, symbols, blocks, type aliases, and attribute aliases.
syntax match mlirIdentifier /%[A-Za-z$._-][A-Za-z0-9$._-]*\%(#[0-9]\+\)\?/
syntax match mlirIdentifier /%[0-9]\+\%([#][0-9]\+\)\?\>/
syntax match mlirSymbol /@[A-Za-z$._-][A-Za-z0-9$._-]*/
syntax match mlirSymbol /@"\%([^"\\]\|\\.\)*"/
syntax match mlirBlockIdentifier /\^[A-Za-z$._-][A-Za-z0-9$._-]*/
syntax match mlirBlockIdentifier /\^[0-9]\+\>/
syntax match mlirAttrAlias /#[A-Za-z$._-][A-Za-z0-9$._-]*/
syntax match mlirAttrAlias /#[0-9]\+\>/

" Literals. Put the more specific float forms after integers.
syntax match mlirNumber /[-+]\?\<\d\+\>/
syntax match mlirNumber /[-+]\?\<0x[0-9A-Fa-f]\+\>/
syntax match mlirNumber /[-+]\?\<0b[01]\+\>/
syntax match mlirFloat /[-+]\?\<\%([0-9]\+\.[0-9]*\|[0-9]*\.[0-9]\+\)\%([eE][-+]\?[0-9]\+\)\?\>/
syntax match mlirFloat /[-+]\?\<[0-9]\+[eE][-+]\?[0-9]\+\>/
syntax match mlirFloat /[-+]\?\<\%(inf\|nan\)\>/
syntax keyword mlirBoolean true false

" Assembly-format words shared by builtin and common dialect operations.
syntax keyword mlirKeyword attributes callee else in ins iter_args module
syntax keyword mlirKeyword of out outs reduction step to until while
syntax keyword mlirAttribute affine_map affine_set array dense dense_resource
syntax keyword mlirAttribute distinct sparse strided symbol unit
syntax keyword mlirAffineExpr ceildiv floordiv mod
syntax match mlirAffineExpr /\<[ds][0-9]\+\>/
syntax match mlirAttributeName /\<[A-Za-z_][A-Za-z0-9_$.-]*\ze\s*=/
syntax match mlirLocation /\<loc\ze\s*(/
syntax match mlirDiagnostic /\<\%(error\|warning\|remark\|note\):/

call mlir#syntax#DefineDialectOperations()

" Unqualified words used by custom assembly forms.
syntax keyword mlirKeyword return yield condition switch case default
syntax match mlirOperator /->\|=>\|[=:+*?]/
syntax match mlirDelimiter /[][(){}<>,]/

highlight default link mlirComment Comment
highlight default link mlirSpecialComment SpecialComment
highlight default link mlirTodo Todo
highlight default link mlirString String
highlight default link mlirEscape SpecialChar
highlight default link mlirNumber Number
highlight default link mlirFloat Float
highlight default link mlirBoolean Boolean
highlight default link mlirType Type
highlight default link mlirTypeAlias Type
highlight default link mlirIdentifier Identifier
highlight default link mlirSymbol Function
highlight default link mlirBlockIdentifier Label
highlight default link mlirAttrAlias PreProc
highlight default link mlirAttribute Constant
highlight default link mlirAttributeName PreProc
highlight default link mlirAffineExpr Number
highlight default link mlirKeyword Keyword
highlight default link mlirLocation SpecialComment
highlight default link mlirDiagnostic Error
highlight default link mlirOperation Statement
highlight default link mlirCoreOperation Keyword
highlight default link mlirArithmeticOperation Function
highlight default link mlirMemoryOperation Type
highlight default link mlirStructuredOperation Structure
highlight default link mlirTargetOperation Special
highlight default link mlirTransformOperation Macro
highlight default link mlirMLUIROperation Function
highlight default link mlirOperator Operator
highlight default link mlirDelimiter Delimiter

syntax sync minlines=100
let b:current_syntax = 'mlir'
