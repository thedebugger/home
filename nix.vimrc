scriptencoding utf-8
set encoding=utf-8

set rtp+=~/.vim/bundle/Vundle.vim
" set rtp+=$GOROOT/misc/vim
" Vundle config https://github.com/gmarik/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/syntastic'
Plugin 'elzr/vim-json'
Plugin 'vim-scripts/Vim-R-plugin'
Plugin 'LnL7/vim-nix'
call vundle#end()
filetype plugin indent on

"----------------------------------------------------------------------
"" Basic Options
"----------------------------------------------------------------------
"
set nocompatible          " turn off vi shenanigans
let mapleader="\\"        " default
set autoread              " Reload files that have not been modified
set backspace=2           " Makes backspace not behave all retarded-like
set colorcolumn=80        " Highlight 80 character limit
set cursorline            " Highlight the line the cursor is on
set hidden                " Allow buffers to be backgrounded without being saved
set laststatus=2          " Always show the status bar
nmap <leader>l :set list!<CR> " To see invisible chars
set listchars=tab:▸\ ,eol:¬

set relativenumber        " Show relative line numbers
set ruler                 " Show the line number and column in the status bar
set t_Co=256              " Use 256 colors
set scrolloff=999         " Keep the cursor centered in the screen
set showmatch             " Highlight matching braces
set showmode              " Show the current mode on the open buffer
set splitbelow            " Splits show up below by default
set splitright            " Splits go to the right by default
set title                 " Set the title for gvim
set visualbell            " Use a visual bell to notify us


syntax on                 " Enable filetype detection by syntax

" Backup settings
let vimhomepath=$HOME . "/.vim"
execute "set directory=" . vimhomepath . "/swap"
execute "set backupdir=" . vimhomepath . "/backup"
execute "set undodir=" . vimhomepath . "/undo"
set backup
set undofile
set writebackup

"if isdirectory($HOME . '/.vim/swap') == 0
"  :silent !mkdir -p ~/.vim/swap >/dev/null 2>&1
"endif
"set dir=~/.vim/swap
"
"if isdirectory($HOME . '/.vim/undo') == 0
"    :silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
"endif

" search
set hlsearch   " Highlight results
set ignorecase " Ignore casing of searches
set incsearch  " Start showing results as you type
set smartcase  " Be smart about case sensitivity when searching

" tab settings
set expandtab tabstop=4 shiftwidth=4 softtabstop=4

" ruby files
:nmap \m :set expandtab tabstop=2 shiftwidth=2 softtabstop=2<CR>

" Tab completion settings
set wildmode=list:longest     " Wildcard matches show a list, matching the longest first
set wildignore+=.git,.hg,.svn " Ignore version control repos
set wildignore+=*.6           " Ignore Go compiled files
set wildignore+=*.pyc         " Ignore Python compiled files
set wildignore+=*.rbc         " Ignore Rubinius compiled files
set wildignore+=*.swp         " Ignore vim backups

" colors
Plugin 'flazz/vim-colorschemes'
colors zenburn

"----------------------------------------------------------------------
" Key Mappings
"----------------------------------------------------------------------
" Remap a key sequence in insert mode to kick me out to normal
" mode. This makes it so this key sequence can never be typed
" again in insert mode, so it has to be unique.
inoremap jj <esc>
inoremap jJ <esc>
inoremap Jj <esc>
inoremap JJ <esc>
inoremap jk <esc>
inoremap jK <esc>
inoremap Jk <esc>
inoremap JK <esc>

" Make j/k visual down and up instead of whole lines. This makes word
" wrapping a lot more pleasent.
:nmap j gj
:nmap k gk

" Shortcut to yanking to the system clipboard
map <leader>y "*y
map <leader>p "*p

" Toggle paste mode
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>

" Save the file using C-s
command -nargs=0 -bar Update if &modified
                           \|    if empty(bufname('%'))
                           \|        browse confirm write
                           \|    else
                           \|        confirm write
                           \|    endif
                           \|endif
nnoremap <silent> <C-S> :<C-u>Update<CR>
:inoremap <c-s> <c-o>:Update<CR>

" Command to write as root if we dont' have permission
cmap w!! %!sudo tee > /dev/null %

" Get rid of search highlights
noremap <silent><leader>/ :nohlsearch<cr>

" Expand in command mode to the path of the currently open file
cnoremap %% <C-R>=expand('%:h').'/'<CR>

" Buffer management
nnoremap <leader>d   :bd<cr>

" windows management
:nmap <C-e> :e#<CR>

"----------------------------------------------------------------------
" Autocommands
"----------------------------------------------------------------------
" Clear whitespace at the end of lines automatically
autocmd BufWritePre * :%s/\s\+$//e

" CtrlP settings
:nmap <leader>; :CtrlPBuffer<CR>
let g:ctrlp_max_files = 10000
let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend|class)$|(^|[/\\])\.(hg|git|bzr|svn)($|[/\\])|__init__\.py'
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_dotfiles = 0
let g:ctrlp_switch_buffer = 0

" Nerd tree
:nmap <leader>e :NERDTreeTabsToggle<CR>
let NERDTreeIgnore = ['\.pyc$']

" Syntastic
" http://superuser.com/questions/302186/vim-scrolls-very-slow-when-a-line-is-to-long
set synmaxcol=80

"
:nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" JSON
let g:vim_json_syntax_conceal = 0

"TODO's
"https://github.com/Lokaltog/vim-easymotion
"
