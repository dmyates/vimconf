" My .vimrc
" Compiled by David Yates
" with thanks to Brain Moolenar and Steve Losh

" Automatic vim-plug installation
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

" Core
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

" Display
Plug 'mhartington/oceanic-next'
Plug 'vim-airline/vim-airline'
Plug 'machakann/vim-highlightedyank'
Plug 'lambdalisue/vim-fern'

" Programming languages
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-rails'
Plug 'wlangstroth/vim-racket'
Plug 'chaimleib/vim-renpy'
Plug 'nessss/vim-gml'
Plug 'dmyates/vim-gruescript'

" Git
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-rhubarb'

" Prose
Plug 'junegunn/goyo.vim'
Plug 'vimwiki/vimwiki'

" Fuzzy find
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" LSP
Plug 'dense-analysis/ale'
Plug 'liuchengxu/vista.vim'

call plug#end()

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

"Lose vi compatibility
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=1000	" keep 1000 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Use the mouse
if has('mouse')
  set mouse=a
endif

" Syntax colours and search highlighting
syntax on
set hlsearch

" Colors
if (has("termguicolors"))
    set termguicolors
endif

" Autocommands
if has("autocmd")

	" Enable file type detection.
	" Use the default filetype settings, so that mail gets 'tw' set to 72,
	" 'cindent' is on in C files, etc.
	" Also load indent files, to automatically do language-dependent indenting.
	filetype plugin indent on

	" Put these in an autocmd group, so that we can delete them easily.
	augroup vimrcEx
	  au!

	  " When editing a file, always jump to the last known cursor position.
	  " Don't do it when the position is invalid or when inside an event handler
	  " (happens when dropping a file on gvim).
	  " Also don't do it when the mark is in the first line, that is the default
	  " position when opening a file.
	  autocmd BufReadPost *
	    \ if line("'\"") > 1 && line("'\"") <= line("$") |
	    \   exe "normal! g`\"" |
	    \ endif

	augroup END

	" Set filetype local settings
	augroup filetypes
		"Indentation for various languages
		autocmd FileType python setlocal tabstop=4 shiftwidth=4 expandtab
		autocmd FileType haskell setlocal tabstop=4 shiftwidth=4 expandtab
		autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 expandtab
		autocmd FileType css setlocal tabstop=2 shiftwidth=2 expandtab
		autocmd FileType html setlocal tabstop=2 shiftwidth=2 expandtab
		"Spellcheck for various writing formats
		autocmd FileType tex setlocal spell spelllang=en_gb
		autocmd FileType wiki setlocal spell spelllang=en_gb
		autocmd FileType markdown setlocal spell spelllang=en_gb
		autocmd FileType text setlocal spell spelllang=en_gb
	augroup END

	" Autosave on lose focus
	augroup Save
		autocmd FocusLost * :wa
	augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Show line numbers
set number
set numberwidth=3

" Allow clipboard in register +
set clipboard+=unnamed

" Misc
set encoding=utf-8
set scrolloff=3
set sidescrolloff=5
set showmode
set hidden
set wildmenu
set wildmode=list:longest
set ttyfast
set laststatus=2
set undofile
set complete-=i
set smarttab
set display+=lastline
set autoread
set tabpagemax=50
set sessionoptions-=options

" Prevent beeping/flashing
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" Remove octal from C-a and C-x
set nrformats-=octal

" sensible.vim
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j " Delete comment character when joining commented lines
endif

if has('path_extra')
  setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

if !empty(&viminfo)
  set viminfo^=!
endif

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

" Remap Escape to jk in insert mode
inoremap jk <ESC>
inoremap kj <ESC>

" Leader
let mapleader = ","
noremap \ ,
" Select all
nnoremap <leader>v V`]

" Searching
nnoremap / /\v
vnoremap / /\v
set incsearch
set ignorecase
set smartcase
set gdefault
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>

" Split windows
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <leader>z <C-w>s<C-w>j
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Buffer switching
nnoremap <leader>ls :ls<CR>
nnoremap <leader>, :bp<CR>
nnoremap <leader>. :bn<CR>
nnoremap <leader>g :e#<CR>
nnoremap <leader>1 :1b<CR>
nnoremap <leader>2 :2b<CR>
nnoremap <leader>3 :3b<CR>
nnoremap <leader>4 :4b<CR>
nnoremap <leader>5 :5b<CR>
nnoremap <leader>6 :6b<CR>
nnoremap <leader>7 :7b<CR>
nnoremap <leader>8 :8b<CR>
nnoremap <leader>9 :9b<CR>
nnoremap <leader>0 :10b<CR>

" Reselect after indent
vnoremap < <gv
vnoremap > >gv

" Easy vimrc editing and reloading
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" NerdTree
nnoremap <leader>f :Fern . -drawer<cr>

" Automatically change working directory to current file place
set autochdir

" Colorscheme
colorscheme OceanicNext
let g:airline_theme='oceanicnext'

" Wordcount
:map <F3> :w !wc -w<CR>

" Indentation defines folds, also default to open folds
set foldmethod=indent
set foldlevelstart=20

" Split line here
nnoremap K i<CR><Esc>

" Autocorrect
iabbrev adn and
iabbrev seperate separate

" Airline tabs
let g:airline#extensions#tabline#enabled = 1

" F8 disables autoindent
nnoremap <F8> :setl noai nocin nosi inde=<CR>

" Select last pasted text
nnoremap gp `[v`]

" Turn line numbers off in goyo
function! s:goyo_enter()
	set nonumber
	set norelativenumber
	augroup InsertNumbers
		:autocmd!
	augroup END
endfunction

function! s:goyo_leave()
	set number
	set relativenumber
	augroup InsertNumbers
		:autocmd InsertEnter * :setlocal number
		:autocmd InsertLeave * :setlocal relativenumber
	augroup END
endfunction

autocmd User GoyoEnter nested call <SID>goyo_enter()
autocmd User GoyoLeave nested call <SID>goyo_leave()

" Fix comma splices
nnoremap <leader>tr f,r.wvU

" Linewrapping
set wrap
set linebreak
set nolist

" Vimwiki embedded syntax highlight
let wiki = {}
let wiki.path = '~/vimwiki/'
let wiki.nested_syntaxes = {'python': 'python', 'c++': 'cpp', 'sh': 'sh', 'racket': 'racket'}
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.wiki'}]
let g:vimwiki_hl_headers = 1
let g:vimwiki_hl_cb_checked = 1
let g:vimwiki_ext2syntax = {'.wiki': 'markdown'}

" Pollen
inoremap <C-L> ◊

" Visual @
" Select a line and then press @ to run macro on all matching lines
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

" Global indentation
set tabstop=2 shiftwidth=2 expandtab

" Put special files elsewhere
set backupdir=.backup/,~/.backup//,/tmp//
set directory=.swap/,~/.swap//,/tmp//
set undodir=.undo/,~/.undo//,/tmp//

" Hide ~ files
set wildignore=*~

" Reload syntax highlighting
noremap <F12> <Esc>:syntax sync fromstart<CR>
inoremap <F12> <C-o>:syntax sync fromstart<CR>

" Autocomplete
let g:ale_completion_enabled=1
