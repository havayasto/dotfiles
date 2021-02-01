" show the name of file which I am currently editing on term titlebar
set title

" set a nice color scheme
set termguicolors
colorscheme base16-default-dark

" using the clipboard as the default register
set clipboard=unnamed

" disable persistent netrw history
let g:netrw_dirhistmax=0

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

" <Leader> key is mapped to \ by default but "," is much better
let mapleader = ","

" TODO check how to move this chunk in extr file
" only highlight applied in the current window

augroup syntaxtoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * colorscheme base16-default-dark
  " autocmd BufLeave,FocusLost,InsertEnter   * colorscheme base16-default-dark-syntax_off
  autocmd BufLeave,FocusLost  * colorscheme base16-default-dark-syntax_off
augroup END

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END


" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
  Plug 'wincent/command-t'
  Plug 'wincent/ferret'
  Plug 'ap/vim-css-color'
call plug#end()

" command-t options and tweaks
let g:CommandTHighlightColor="Bold"
