" colorscheme slate
" sub_lime (https://goo.gl/dWuusJ  )
set background=dark
" Color configuration
set bg=dark
color evening  " Same as :colorscheme evening
hi LineNr cterm=bold ctermfg=DarkGrey ctermbg=NONE
hi CursorLineNr cterm=bold ctermfg=Green ctermbg=NONE
set guifont=DejaVu\ Sans\ Mono\ 16
set nu
set shiftwidth=4 softtabstop=4
set incsearch ignorecase hlsearch
set lines=24 columns=80
set cursorline
set cursorcolumn
set list
let g:indentLine_color_gui = '#A4E57E'
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline
" Press space to clear search highlighting
" and any message already displayed.
nnoremap <silent> <Space> :silent noh<Bar>echo<CR>
filetype plugin on
let Tlist_Ctags_Cmd = "/usr/bin/ctags"
"let Tlist_Ctags_Cmd = "/usr/local/bin/ctags"
let Tlist_WinWidth = 50
map <F4> :TlistToggle<cr>
set smarttab
set autoindent
set number
autocmd BufWritePre * :%s/\s\+$//e
" highlight Normal guifg=white guibg=black
set tags=/usr/include/tags,/usr/include/c++/tags,/home/bryan/Qt/5.12.0/Src;
