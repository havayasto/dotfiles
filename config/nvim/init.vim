" show the name of currently editing file on term titlebar
" the screen's title can automatically be renewed to the name of the currently 
" opened file, or whatever you like.
set title

" put buffer to the background without writing
" I tend to use single vim instances in tmux session for weeks or even months.
" I can accumulate hundreds of buffers. I use the command-t plugin to open files
" so I tend not to care if the file is open yet or not.
set hidden

" :help 'autoread' does not include a lot of info on how it acts, but vim 
" checks if an open file is changed in some events,
" and will reload it automatically if autoread is enabled.
" "autoread" is a must if you use git to change files in the background.
set autoread

" essentially, "termguicolors" just use your colorscheme and init.vim's 
" GUI values to set the color highlighting rather than the cterm* values.
set termguicolors

" set a nice color scheme
" there is a wide variety of color schemes that may
" suit your needs better than the locally-given choices. you can find and
" download them from GitHub or websites such as www.vimcolors.com
" add a new theme to your repository by downloading it from a remote source.
" once you install a new color scheme on your local machine, make sure to move
" it to the $HOME/.config/nvim/colors or $HOME/.vim/colors.
colorscheme base16-default-dark

" on the linux systems, you basically have two clipboards:
" one is pretty much the same as in the other OSes (Ctrl-C and Ctrl-V in other 
" programs, mapped to register + in Vim), the other is the "selection" 
" clipboard (mapped to register * in Vim). using only "unnamedplus" on Linux, 
" Windows, and Mac OS X allows you to:
"
" Ctrl-C in other programs and put in Vim with p on all three platforms,
" yank in Vim with y and CtrlV in other programs on all three platforms.
set clipboard=unnamedplus

" disable persistent netrw history
" .netrwhist is a history file that keeps all the dirs that were modified.
" so whenever you modify the contents of ~/.vim it adds one entry in .netrwhist
" netrw_dirhistmax indicates the maximum number of modified directories it 
" stores in the history file. set it to 0 = no records at all.
let g:netrw_dirhistmax=0

" 80 characters per line is a standard worth sticking to even today.
set colorcolumn=80
set wrap
set linebreak
set showbreak=+++
let &colorcolumn="80,".join(range(80,999),",")

" always display the status line.
" the advantage of having the status line displayed always is, you can see the 
" current mode, file name, file status, ruler, etc.
set laststatus=2
" the default command height is 1. enlarging cmdheight will provide more place 
" for commands, although it will take some space away from editing.
set cmdheight=3

" “Hybrid” line numbers
" since Vim 7.4, enabling number and relativenumber at the same time produces
" hybrid line number mode. all lines will show their relative number, except
" for current line, which will show its absolute line number
set number relativenumber
set nu rnu

" <Leader> key is mapped to \ by default but "," is much better
let mapleader = ","

" replace tabs with spaces
" NOTE: after the 'expandtab' option is set, all the new
" tab characters entered will be changed to spaces. This option will not
" affect the existing tab characters!!! To change all the existing tab
" characters to match the current tab settings, you can use:
" :retab
" NOTE: if you want to enter a real tab character use Ctrl-V<Tab> key sequence. 
set expandtab

" 1 tab = 2 spaces
set tabstop=2 shiftwidth=2

" when deleting whitespace at the beginning of a line, delete
" 1 tab worth of spaces (for us this is 2 spaces)
set smarttab

" when creating a new line, copy the indentation from the line above
" i find this to be very convenient especially if you're doing a quick code 
" editing or even on a long session of coding.
set smartindent
set autoindent

" ignore case when searching
" by default, vim/neovim search is case sensitive. This is the correct unix-like
" mindset, however, I think i will do a case insensitive search
" for productivity reasons.
" when 'ignorecase' and 'smartcase' are both on, if a pattern contains
" an uppercase letter, it is case sensitive, otherwise, it is not. for example,
" /The would find only "The", while /the would find "the" or "The" etc.
" NOTE: the 'smartcase' option only applies to search patterns that you type; 
" it does not apply to * or # or gd
set ignorecase
set smartcase

" show the matching brackets
" I prefer to use ":set showmatch". this setting lets vim to move the cursor 
" to the previous matching bracket for half a second, and quickly pressing
" a key will effectively cancel this animation so it doesn't get in the way of
" rapid typing. the duration for this animation is set by ":set matchtime=10",
" where 10 is in tenths of a second.
set showmatch
set matchtime=10

" highlight current line
set cursorline

" use syntax highlight only in the current window split.
" I usually use more than one tmux panes. I need a visual indication 
" of the current active tmux pane. I made a copy of my favorite color scheme, 
" and I turned off almost all color syntax highlights.
augroup syntaxtoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * colorscheme base16-default-dark
  " autocmd BufLeave,FocusLost,InsertEnter   * colorscheme base16-default-dark-syntax_off
  autocmd BufLeave,FocusLost  * colorscheme base16-default-dark-syntax_off
augroup END

" the relative line numbers only makе sense when editing code. Outside of this
" context, they do not provide any valuable information. When the buffer
" doesn’t have focus, it’d also be more useful to show absolute line numbers.
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" custom statusline
set laststatus=2
set statusline=
set statusline+=\ 
set statusline+=\ 
set statusline+=\ 
set statusline+=\ 
set statusline+=%{StatuslineMode()}
set statusline+=%=
set statusline+=%f
set statusline+=\ 
set statusline+=»
set statusline+=\ 
set statusline+=%y
set statusline+=\ 
set statusline+=§
set statusline+=\ 
set statusline+=%{&ff}
set statusline+=\ 
set statusline+=҂
set statusline+=\ 
set statusline+=%{strlen(&fenc)?&fenc:'none'}
set statusline+=\ 
set statusline+=%m

function! StatuslineMode()
  let l:mode=mode()
  if l:mode==#"n"
    return "(nor)"
  elseif l:mode==?"v"
    return "(vis)"
  elseif l:mode==#"i"
    return "(ins)"
  elseif l:mode==#"R"
    return "(rep)"
  elseif l:mode==?"s"
    return "(sel)"
  elseif l:mode==#"t"
    return "(ter)"
  elseif l:mode==#"c"
    return "(cmd)"
  elseif l:mode==#"!"
    return "(shl)"
  endif
endfunction

" bulgarian phonetic keyboard layout in command mode
source $HOME/.config/nvim/usr/bg_keymaps.vim

" download, install and load 3r party plugins
call plug#begin('~/.vim/plugged')
  Plug 'wincent/command-t'
  Plug 'wincent/ferret'
  Plug 'ap/vim-css-color'
call plug#end()

" command-t options and tweaks
let g:CommandTHighlightColor="Bold"
