" Vim
" Scott's VIM rc file.
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"             for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc

" Pathogen for plugin control (https://github.com/tpope/vim-pathogen)
execute pathogen#infect()

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

" ,tn creates a new tab
nmap <Leader>tn :tabnew<cr>

" ,t goes to the next tab
nmap <Leader>t gt
nmap <Leader>T gT

" ,f does fuzzy matching
nmap <Leader>f :CtrlP<cr>

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
  set guifont=monaco:h12
endif


augroup sprog
  " Remove all sprog autocommands
  au!
  autocmd BufRead *.scm,*.ss set lisp
  autocmd BufRead *.scm,*.ss set showmatch
augroup END

imap <Leader>li Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed varius nunc tristique elit congue tristique. Suspendisse sapien ligula, gravida a pharetra eget, commodo ac nisl. Praesent auctor imperdiet luctus. Mauris rutrum, dui ut posuere malesuada, nibh mi aliquam lacus, quis adipiscing sapien felis bibendum tellus. Curabitur convallis augue ut enim faucibus sed iaculis mauris scelerisque. Aliquam in dolor eget tellus egestas ultrices eget ac enim. Etiam volutpat, lorem molestie eleifend accumsan, urna augue luctus felis, id volutpat lectus orci sed odio. Vestibulum diam justo, mollis at dictum et, tristique ac justo. Morbi laoreet nisi eget lacus vehicula molestie. Nullam est lectus, placerat at egestas dignissim, adipiscing eu sapien. Duis sagittis lectus vitae nulla porta molestie. Fusce dui ligula, sollicitudin nec ornare non, dictum et tellus. Maecenas feugiat lacus nec erat vehicula mollis. Nam ut turpis eu ipsum ornare lacinia. Suspendisse potenti. Nam aliquet enim vel ipsum ornare sed convallis augue luctus. Vestibulum in diam ut metus luctus accumsan ut nec tellus. Integer tortor ligula, tempus eu tincidunt sit amet, eleifend id nibh. Vivamus gravida leo quis elit vestibulum tempus gravida orci semper. Quisque aliquet rhoncus molestie.<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SWITCH BETWEEN TEST AND PRODUCTION CODE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! OpenTestAlternate()
  let new_file = AlternateForCurrentFile()
  exec ':e ' . new_file
endfunction

function! AlternateForCurrentFile()
  let current_file = expand("%")
  let new_file = current_file
  let in_spec = match(current_file, '^spec/') != -1
  let in_feature = match(current_file, '\.feature$') != -1
  let in_step_def = match(current_file, '^features/step_definitions/') != -1
  let going_to_spec = !in_spec
  let in_app = match(current_file, '\<controllers\>') != -1 || match(current_file, '\<models\>') != -1 || match(current_file, '\<views\>') != -1

  if in_feature
    " go to step defs file
    " features/choose_plan.feature
    let new_file = substitute(new_file, '\.feature$', '_steps.rb', '')
    " features/choose_plan_steps.rb
    let new_file = substitute(new_file, 'features/', 'features/step_definitions/', '')
    " features/step_definitions/choose_plan_steps.rb
  elseif in_spec
    " go to implementation file
    let new_file = substitute(new_file, 'erb_spec\.rb$', 'erb', '')
    let new_file = substitute(new_file, '_spec\.rb$', '.rb', '')
    let new_file = substitute(new_file, '^spec/', '', '')
    if in_app
      let new_file = 'app/' . new_file
    end
  elseif in_step_def
    " go to feature file
    " features/step_definitions/choose_plan_steps.rb
    let new_file = substitute(new_file, '_steps\.rb$', '.feature', '')
    " features/step_definitions/choose_plan.feature
    let new_file = substitute(new_file, 'step_definitions/', '', '')
    " features/choose_plan.feature
  else
    " go to spec file
    if in_app
      let new_file = substitute(new_file, '^app/', '', '')
    end
    let new_file = substitute(new_file, '\.rb$', '_spec.rb', '')
    let new_file = substitute(new_file, '\.erb$', '\.erb_spec.rb', '')
    let new_file = 'spec/' . new_file
  endif

  return new_file
endfunction
nnoremap <leader>. :call OpenTestAlternate()<cr>



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RUNNING TESTS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" function! DrewJumpToFile()
"   let cur_line = getline(".")
"   " :echo cur_line
"   let match_line = matchstr(cur_line, "\v\s*Foo\w*")
"   if empty(match_line)
"     :echo "it did NOT matched "
"   else
"     :echo "it matched " . match_line
"   endif
" endfunction

function! DrewRunTests(filename)
    " :w
    let winnr = bufwinnr('^_drew_run_tests_output$')
    if ( winnr >= 0 )
      execute winnr . 'wincmd w'
      setlocal modifiable
      execute 'normal ggdG'
    else
      botright new _drew_run_tests_output
      setlocal modifiable
      setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
      exec ":silent! AnsiEsc"
    endif
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    if match(a:filename, '\.feature') != -1
        exec ":!script/features " . a:filename
    else
        if filereadable("script/test")
            exec ":!script/test " . a:filename
        elseif filereadable("Gemfile")
          " :cexpr system('bundle exec rspec --color '.a:filename.' 2>&1')
            exec ":silent! read !bundle exec rspec --color --tty " . a:filename . " 2>&1"
        else
          " :cexpr system('rspec --color '.a:filename.' 2>&1')
            exec ":silent! read !rspec --color --tty " . a:filename . " 2>&1"
        end
    end
    setlocal nomodifiable
endfunction

function! RunTests(filename)
    " Write the file and run tests for the given filename
    :w
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    if match(a:filename, '\.feature') != -1
        exec ":!script/features " . a:filename
    else
        if filereadable("script/test")
            exec ":!script/test " . a:filename
        elseif filereadable("Gemfile")
            exec ":!bundle exec rspec --color " . a:filename
        else
            exec ":!rspec --color " . a:filename
        end
    end
endfunction

function! SetTestFile()
    " Set the spec file that tests will be run for.
    let t:grb_test_file=@%
endfunction

function! RunTestFile(...)
    if a:0
        let command_suffix = a:1
    else
        let command_suffix = ""
    endif

    " Run the tests for the previously-marked file.
    let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\)$') != -1
    if in_test_file
        call SetTestFile()
    elseif !exists("t:grb_test_file")
        return
    end
    call DrewRunTests(t:grb_test_file . command_suffix)
endfunction

function! RunNearestTest()
    let spec_line_number = line('.')
    call RunTestFile(":" . spec_line_number)
endfunction

map <leader>t :call RunTestFile()<cr>
map <leader>T :call RunNearestTest()<cr>
map <leader>a :call DrewRunTests('')<cr>
map <leader>c :w\|:!script/features<cr>
map <leader>w :w\|:!script/features --profile wip<cr>

