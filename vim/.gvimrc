set guifont=DejaVu\ Sans\ Mono\ 16
set nu
set shiftwidth=8 softtabstop=8
set incsearch ignorecase hlsearch
set lines=24 columns=80
" Press space to clear search highlighting and any message already displayed.
nnoremap <silent> <Space> :silent noh<Bar>echo<CR>
filetype plugin on
let Tlist_Ctags_Cmd = "/usr/bin/ctags"
let Tlist_WinWidth = 50
map <F4> :TlistToggle<cr>
