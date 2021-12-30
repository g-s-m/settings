call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'arcticicestudio/nord-vim'
Plug 'cocopon/iceberg.vim'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'sainnhe/everforest'
Plug 'habamax/vim-alchemist'
Plug 'SirVer/ultisnips'
Plug 'jiangmiao/auto-pairs'
Plug 'samoshkin/vim-mergetool'
Plug 'dense-analysis/ale'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'etordera/deoplete-ruby'
Plug 'stamblerre/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }
Plug 'deoplete-plugins/deoplete-go', { 'do': 'make'}
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
Plug 'Shougo/echodoc.vim'
Plug 'easymotion/vim-easymotion'
Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'
call plug#end()

set nu
set shell=sh
set hidden
set background=dark
set encoding=UTF-8
set fileencoding=UTF-8
set undofile " Maintain undo history between sessions
set undodir=~/.vim/undodir
set backspace=indent,eol,start
set completeopt-=preview
set noshowmode
set winbl=10

set fillchars=vert:│
set listchars=eol:¬,tab:>-,trail:~,extends:>,precedes:<,space:·
set nolist
noremap <F4> :set list!<CR>
inoremap <F4> <C-o>:set list!<CR>
cnoremap <F4> <C-c>:set list!<CR>

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors
augroup colorscheme_change | au!
  au ColorScheme alchemist hi Comment gui=italic cterm=italic
augroup END
colorscheme alchemist

let g:ackprg = 'ag --nogroup --nocolor --column'

filetype plugin indent on
syntax on 

set pastetoggle=<F2>

"au filetype go inoremap <buffer> . .<C-x><C-o>
"let g:completor_ruby_omni_trigger = '([$\w]{1,}|\.[\w]*|::[$\w]*)$'
let g:LanguageClient_serverCommands = {'ruby': ['tcp://127.0.0.1:7658']}
let g:LanguageClient_autoStop = 0
autocmd FileType ruby setlocal omnifunc=LanguageClient#complete
autocmd FileType ruby nnoremap gd :call LanguageClient#textDocument_definition()<CR>

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap K :call LanguageClient#textDocument_hover()<CR>

" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <expr><TAB> pumvisible() ? "\<C-n>" : neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

autocmd VimEnter * set cul!
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

let g:mergetool_layout = 'lmr'
let g:mergetool_prefer_revision = 'local'
nmap <leader>mt <plug>(MergetoolToggle)
nmap <leader>mr <plug>(MergetoolDiffExchangeLeft)
nmap <leader>ml <plug>(MergetoolDiffExchangeRight)

let g:deoplete#enable_at_startup = 1
let g:deoplete#complete_method = "omnifunc"
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'virtual'

let g:go_doc_popup_window = 1
let g:go_updatetime = 800
let g:go_auto_type_info = 1
let g:go_highlight_structs = 1
let g:go_highlight_methods = 1
let g:go_highlight_functions = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1

let g:go_fmt_command = "goimports"

let g:UltiSnipsExpandTrigger="<c-w>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

autocmd Filetype go setlocal tabstop=2 shiftwidth=2 softtabstop=2

augroup go
  autocmd!
  autocmd Filetype go
  \  command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  \| command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  \| command! -bang AS call go#alternate#Switch(<bang>0, 'split')
augroup END
    "

function! <SID>StripTrailingWhitespaces()
  if !&binary && &filetype != 'diff'
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
  endif
endfun

autocmd FileType c,cpp,java,php,ruby,python autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

set rtp+=/usr/local/opt/fzf
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }


let g:fzf_layout = { 'down': '~40%' }
" NERDTree plugin specific commands
" autocmd vimenter * NERDTree

:nmap <S-Left> :bp<CR>
:nmap <S-Right> :bn<CR>
:nmap <S-Down> :cn<CR>
:nmap <S-Up> :cp<CR>

:inoremap <C-d> <C-o>diw

" air-line plugin specific commands
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let NERDTreeNodeDelimiter = "\t"

" unicode symbols
"let g:airline_left_sep = '▶'
"let g:airline_right_sep = '◀'
let g:airline_symbols.branch = '⎇'
let g:airline#extensions#ale#enabled = 1

let g:ale_linters = { 'ruby': ['~/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/rubocop-0.46.0/bin/rubocop'] }
let g:ale_set_highlights = 1


autocmd BufNewFile,BufRead wheely-core-apps/wheely-core/* let g:ale_ruby_rubocop_options = '--config ./wheely-core-apps/wheely-core/.rubocop.yml'
autocmd BufNewFile,BufRead wheely-core-apps/wheely-app-singing/* let g:ale_ruby_rubocop_options = '--config ./wheely-core-apps/wheely-app-singing/.rubocop.yml'
autocmd BufNewFile,BufRead wheely-core-apps/wheely-app-daemon/* let g:ale_ruby_rubocop_options = '--config ./wheely-core-apps/wheely-app-daemon/.rubocop.yml'

command! -bang -nargs=+ -complete=dir Rag call fzf#vim#ag_raw(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)
command! -bang -nargs=+ -complete=dir SIA call fzf#vim#ag_raw('^ '.<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)
command! -bang -nargs=0 SP call fzf#vim#ag_raw('^ '.expand("%:p:.:s?/.*??"), fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

command! -bang AFF call fzf#vim#files('~/wheely', fzf#vim#with_preview(), <bang>0)
command! -bang FP call fzf#vim#files(expand("%:p:.:s?/.*??"), fzf#vim#with_preview(), <bang>0)

function Chomp(string)
    return substitute(a:string, '^.', '', '')
endfunction

function SwitchAndRunFZFFiles()
    let proj = expand("<cWORD>")
    execute("normal \<C-w>w")
    call fzf#vim#files(proj, fzf#vim#with_preview())
endfunction
command! -bang FC call SwitchAndRunFZFFiles()

function SwitchAndRunFZFInFiles()
    let proj = expand("<cWORD>")
    execute("normal \<C-w>w")	
    call fzf#vim#ag_raw('^ '.proj, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}))
endfunction
command! -bang SC call SwitchAndRunFZFInFiles()

command! -bang Bd :b#|bd#

"alias for :vimgrep
command! -bang -nargs=+ Vg :vimgrep <args>|:bo copen
"vimgrep in current project
command! -bang -nargs=+ Vgp :vimgrep /<args>/j %:p:.:s?/.*??/**|:bo copen
"vimgrep for project under cursor(in NERDTree)
command! -bang -nargs=+ Vgc :vimgrep /<args>/j <cWORD>/**|:bo copen
"
"vimgrep for word under cursor in current project
command! -bang -nargs=0 Vgw exec 'vimgrep /'.expand('<cword>').'/j %:p:.:s?/.*??/**|:bo copen'
:nnoremap <C-g> :Vgw<CR>

"vimgrep for whole word under cursor in current project
command! -bang -nargs=0 Vgwh exec 'vimgrep /\<'.expand('<cword>').'\>/j %:p:.:s?/.*??/**|:bo copen'
:nnoremap <C-h> :Vgwh<CR>

command -bang -nargs=0 EW exec 'echo "'.shellescape(fnameescape(expand('<cWORD>'))).'"'
command -bang -nargs=0 Ew exec 'echo "'.expand('<cword>').'"'
command Cbt :%bd|e#|NERDTreeTabsToggle

let g:WebDevIconsNerdTreeBeforeGlyphPadding = ''
let g:WebDevIconsUnicodeDecorateFolderNodes = v:true
let g:NERDTreeDirArrowExpandable = " "  
			"\u00a0
let g:NERDTreeDirArrowCollapsible = " " 
			"\u00a0

let g:NERDTreeGitStatusUseNerdFonts = 1
let g:NERDTreeGitStatusConcealBrackets = 1

let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✹',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }

lua require('gitsigns').setup()
"hi DiffAdd guibg=bg guifg=#d2ebbe ctermbg=none
hi DiffAdd guibg=bg guifg=Green ctermbg=none
hi DiffChange guibg=bg guifg=#dad085 ctermbg=none
hi DiffDelete guibg=bg guifg=#f0a0c0 ctermbg=none
