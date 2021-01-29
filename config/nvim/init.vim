" show the name of file which I am currently editing on term titlebar
set title

" set a nice color scheme
set termguicolors
colorscheme base16-default-dark

" using the clipboard as the default register
set clipboard=unnamed

" 80 Characters per line is a Standard Worth Sticking to Even Today`
set colorcolumn=80
set wrap
set linebreak
set showbreak=+++
let &colorcolumn="80,".join(range(80,999),",")

" make more room for vim msgs
set laststatus=2
set cmdheight=2

" “Hybrid” line numbers
" Since Vim 7.4, enabling number and relativenumber at the same time produces 
" hybrid line number mode. All lines will show their relative number, except 
" for current line, which will show its absolute line number.
set number relativenumber
set nu rnu

"set cursorline

" TODO check how to move this chunk in extr file
" only highlight applied in the current window
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END
