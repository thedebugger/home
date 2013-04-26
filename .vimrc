execute pathogen#infect()
filetype plugin indent on
syntax on
set modelines=0
set nocompatible
set relativenumber
:set hlsearch
:nmap j gj
:nmap k gk
:set ignorecase
:set smartcase
:nmap <C-e> :e#<CR>
:nmap \; :CtrlPBuffer<CR>
:nmap \q :nohlsearch
:let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend|class)$|(^|[/\\])\.(hg|git|bzr|svn)($|[/\\])|__init__\.py'
:let g:ctrlp_match_window_reversed = 0
:let g:ctrlp_working_path_mode = 0
:let g:ctrlp_dotfiles = 0
:let g:ctrlp_switch_buffer = 0
:nmap \e :NERDTreeTabsToggle<CR>
if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
	  set t_Co=256
endif
colors zenburn
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
if isdirectory($HOME . '/.vim/swap') == 0
  :silent !mkdir -p ~/.vim/swap >/dev/null 2>&1
endif
set dir=~/.vim/swap
if isdirectory($HOME . '/.vim/undo') == 0
    :silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
endif
set undodir=~/.vim/undo/
set undofile
:nmap \l :setlocal number!<CR>
command -nargs=0 -bar Update if &modified 
                           \|    if empty(bufname('%'))
                           \|        browse confirm write
                           \|    else
                           \|        confirm write
                           \|    endif
                           \|endif
nnoremap <silent> <C-S> :<C-u>Update<CR>
:inoremap <c-s> <c-o>:Update<CR>
:nmap \t :set expandtab tabstop=4 shiftwidth=4 softtabstop=4<CR>
:nmap \T :set expandtab tabstop=8 shiftwidth=8 softtabstop=4<CR>
:nmap \M :set noexpandtab tabstop=8 softtabstop=4 shiftwidth=4<CR>
:nmap \m :set expandtab tabstop=2 shiftwidth=2 softtabstop=2<CR>
