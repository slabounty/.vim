" Vim
" Scott's VIM rc file.
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"             for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc

set nocompatible	" Use Vim defaults (much better!)
set bs=2		" allow backspacing over everything in insert mode
set ai			" always set autoindenting on
" set si          " always set smart indent on. Removed to make Ruby code (and
" possibly Bash code indent properly when a # is typed.
set backup		" keep a backup file
set viminfo='20,\"50,!	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
            "
" Necessary to get matchit add in for matching do/end etc. in vim.
set rtp+=/usr/share/vim/addons/

set lines=60 columns=140
set shell=bash\ --norc 	" Use the bash shell without reading a .bashrc file
" set shellslash		" Use the forward slash for expansion.
" set shellcmdflag=-c	" Use the forward slash for expansion.
" set shellxquote=\"	" Use the forward slash for expansion.
set tabstop=2		" set the tabstop to 2
set shiftwidth=2	" set the shiftwidth to 2
set nowrapscan		" Don't wrap past the bottom of the screen

" Turn on plugin and indent support
filetype plugin indent on

colorscheme scott

" Set the mapleader to be used at the
" start of mappings.
let mapleader = ","

set shellpipe=2>&1\|\ tee
set expandtab       " Use spaces for tabs
set wildignore=*.class,*.obj,*.o,*.exe,*.jar,*.dsp,*.dsw,*.ncb,*.opt,*.plg,*.*~ " Ignore these files in command completion

" Clears search highlighting by just hitting a return. The <BS> clears the
" command line. From Zdenek Sekera [zdenek.sekera@cern.ch] on the vim list.
:nnoremap <CR> :noh<CR>/<BS>

" Use ,v to convert horizontally
" split windows to vertically split.
nmap <Leader>v :windo wincmd H<cr>
nmap <Leader>h :windo wincmd K<cr>

" Use v to move between windows
map v <C-w><C-w>

" Use ,cd to change to the directory of the 
" current file.
nmap <Leader>cd :cd %:p:h<cr><cr>

"
" Press <,> and then <l> to show a list of open files
" then press the number of the buffer you want to edit, followed by <Enter>
"
map <Leader>l :buffers<cr>:b
map <Leader>s :buffers<cr>:sb

" ,nt gives us NERDTree in the current directory
nmap <Leader>nt :NERDTree<cr>

" In text files, always limit the width of text to 78 characters
autocmd BufRead *.txt set tw=78	

" Don't use Ex mode, use Q for formatting
map Q gq

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Switch the font to courier if we are running under
" the gui (i.e. gvim).
if has("gui_running")
  set guifont=courier
endif


augroup sprog
  " Remove all sprog autocommands
  au!
  autocmd BufRead *.scm,*.ss set lisp
  autocmd BufRead *.scm,*.ss set showmatch
augroup END

imap <Leader>li Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed varius nunc tristique elit congue tristique. Suspendisse sapien ligula, gravida a pharetra eget, commodo ac nisl. Praesent auctor imperdiet luctus. Mauris rutrum, dui ut posuere malesuada, nibh mi aliquam lacus, quis adipiscing sapien felis bibendum tellus. Curabitur convallis augue ut enim faucibus sed iaculis mauris scelerisque. Aliquam in dolor eget tellus egestas ultrices eget ac enim. Etiam volutpat, lorem molestie eleifend accumsan, urna augue luctus felis, id volutpat lectus orci sed odio. Vestibulum diam justo, mollis at dictum et, tristique ac justo. Morbi laoreet nisi eget lacus vehicula molestie. Nullam est lectus, placerat at egestas dignissim, adipiscing eu sapien. Duis sagittis lectus vitae nulla porta molestie. Fusce dui ligula, sollicitudin nec ornare non, dictum et tellus. Maecenas feugiat lacus nec erat vehicula mollis. Nam ut turpis eu ipsum ornare lacinia. Suspendisse potenti. Nam aliquet enim vel ipsum ornare sed convallis augue luctus. Vestibulum in diam ut metus luctus accumsan ut nec tellus. Integer tortor ligula, tempus eu tincidunt sit amet, eleifend id nibh. Vivamus gravida leo quis elit vestibulum tempus gravida orci semper. Quisque aliquet rhoncus molestie.<cr>


