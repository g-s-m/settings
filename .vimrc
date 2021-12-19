call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'vim-ruby/vim-ruby'
Plug 'arcticicestudio/nord-vim'
Plug 'cocopon/iceberg.vim'
Plug 'aklt/plantuml-syntax'
Plug 'skanehira/preview-uml.vim'
Plug 'ycm-core/YouCompleteMe'
Plug 'SirVer/ultisnips'
Plug 'jiangmiao/auto-pairs'
Plug 'samoshkin/vim-mergetool'
call plug#end()

set nu

let g:ackprg = 'ag --nogroup --nocolor --column'

filetype plugin indent on

syntax on 

set background=dark
colorscheme iceberg

"set foldmethod=syntax
set hidden

let g:mergetool_layout = 'lmr'
let g:mergetool_prefer_revision = 'local'
nmap <leader>mt <plug>(MergetoolToggle)
nmap <leader>mr <plug>(MergetoolDiffExchangeLeft)
nmap <leader>ml <plug>(MergetoolDiffExchangeRight)

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

let g:UltiSnipsExpandTrigger="<c-w>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
let g:preview_uml_url='http://127.0.0.1:8888'

autocmd Filetype go setlocal tabstop=2 shiftwidth=2 softtabstop=2

au filetype go inoremap <buffer> . .<C-x><C-o>

" Change how vim represents characters on the screen
set encoding=utf-8

" Set the encoding of files written
set fileencoding=utf-8

set undofile " Maintain undo history between sessions
set undodir=~/.vim/undodir
set backspace=indent,eol,start

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

let g:go_fmt_command = "goimports"
let g:go_auto_type_info = 1

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

let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1

let g:ale_linters = { 'ruby': ['rubocop'] }
let g:ale_set_highlights = 1

let g:completor_ruby_omni_trigger = '([$\w]{1,}|\.[\w]*|::[$\w]*)$'

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

