set autoindent
set noexpandtab

set tabstop=4
set shiftwidth=4
set smarttab
set wrap
set ai

set showmatch
set hlsearch
set incsearch
set ignorecase

set lz

set listchars=tab:··
set list
set nu

execute pathogen#infect()

autocmd VimEnter * NERDTree
nmap <silent> <F3> :NERDTreeToggle<CR>

