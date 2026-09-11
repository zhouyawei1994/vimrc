" Colorscheme
set background=dark
"set background=light
colorscheme peaksea
colorscheme papercolor

set signcolumn=no
set nu
set hls
set ic

" Use two spaces for indentation in user-specific settings.
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2

" Disable automatic insertion of matching brackets and quotes.
let g:AutoPairs = {}

 " C/C++ 括号内换行时，与左括号后的第一个字符对齐。
 autocmd FileType c,cpp setlocal cinoptions+=(0
