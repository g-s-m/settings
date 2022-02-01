local cmd = vim.cmd             -- execute Vim commands
local exec = vim.api.nvim_exec  -- execute Vimscript
local g = vim.g                 -- global variables
local opt = vim.opt             -- global/buffer/windows-scoped options

require('neoscroll').setup()
require('gitsigns').setup()
require'tabline'.setup {
      enable = true,
      options = {
        section_separators = {'', ''},
        component_separators = {'', ''},
        max_bufferline_percent = 66, -- set to nil by default, and it uses vim.o.columns * 2/3
        show_tabs_always = false, -- this shows tabs only when there are more than one tab or if the first tab is named
        show_devicons = true, -- this shows devicons in buffer section
        show_bufnr = false, -- this appends [bufnr] to buffer section,
        show_filename_only = true, -- shows base filename only instead of relative path in filename
      }
    }
vim.cmd[[
  set guioptions-=e " Use showtabline in gui vim
  set sessionoptions+=tabpages,globals " store tabpages and globals in session
]]
require'nvim-tree'.setup {
  disable_netrw       = true,
  hijack_netrw        = true,
  open_on_setup       = false,
  ignore_ft_on_setup  = {},
  update_to_buf_dir   = {
    enable = true,
    auto_open = true,
  },
  auto_close          = true,
  open_on_tab         = true,
  hijack_cursor       = false,
  update_cwd          = false,
  diagnostics         = {
    enable = false,
    show_on_dirs = false,
  },
  update_focused_file = {
    enable      = false,
    update_cwd  = false,
    ignore_list = {}
  },
  system_open = {
    cmd  = nil,
    args = {}
  },
  git = {
    enable = true,
    ignore = true,
  },
  view = {
    width = 30,
    height = 30,
    side = 'left',
    auto_resize = false,
    number = false,
    relativenumber = false,
    signcolumn = "yes",
    mappings = {
      custom_only = false,
      list = {}
    }
  },
  filters = {
    dotfiles = false,
    custom = {}
  },
  trash = {
    cmd = "trash",
    require_confirm = true,
  }
}

g.AutoPairsShortcutToggle = '<M-m>'
g.AutoPairsShortcutFastWrap = '<M-e>'

opt.termguicolors = true      --  24-bit RGB colors
opt.number = true
opt.undofile = true
opt.cursorline = true
g.preview_uml_url='http://localhost:8888'

cmd 'set pastetoggle=<F2>'
cmd 'autocmd VimEnter * set statusline+=%{&paste?\'PASTE\':\'\'}'
cmd 'set noshowmode'
cmd 'set winbl=10'
cmd 'autocmd Filetype go setlocal tabstop=2 shiftwidth=2 softtabstop=2'
cmd 'autocmd Filetype javascript setlocal tabstop=2 shiftwidth=2 expandtab softtabstop=2'
cmd 'set completeopt-=preview'
cmd 'set noshowmode'
cmd 'set hidden'
cmd 'colorscheme alchemist'
cmd [[
augroup colorscheme_change | au!
  au ColorScheme alchemist hi Comment gui=italic cterm=italic
augroup END
]]

cmd [[
function DelayedSet(timer)
  :TablineTabRename all
  autocmd BufWinEnter * :TablineBuffersBind %
endfunction
let timer=timer_start(500,'DelayedSet')

function CreateNewTab()
  call inputsave()
  let name = input('Enter tab name: ')
  call inputrestore()
  :TablineTabNew
  execute ":TablineTabRename ".name
endfunction

command! -bang -nargs=0 MyNewTab call CreateNewTab()

autocmd BufEnter * let g:grepper.dir = 'repo'
]]

cmd [[autocmd BufNewFile,BufEnter *.rb,*/wheely-core/* let g:ale_ruby_rubocop_options = '--config ~/wheely/wheely-core-apps/wheely-core/.rubocop.yml']]
cmd [[autocmd BufNewFile,BufEnter *.rb,*/wheely-app-singing/* let g:ale_ruby_rubocop_options = '--config ~/wheely/wheely-core-apps/wheely-app-singing/.rubocop.yml']]
cmd [[autocmd BufNewFile,BufEnter *.rb,*/wheely-app-daemon/* let g:ale_ruby_rubocop_options = '--config ~/wheely/wheely-core-apps/wheely-app-daemon/.rubocop.yml']]

cmd 'set fillchars=vert:│'
cmd 'set listchars=eol:¬,tab:>-,trail:~,extends:>,precedes:<,space:·'
cmd 'set nolist'

g.mergetool_layout = 'lmr'
g.mergetool_prefer_revision = 'local'

rbCmd = {}
rbCmd["ruby"] = {'tcp://127.0.0.1:7658'}
g.LanguageClient_serverCommands = rbCmd
g.LanguageClient_autoStop = 0
cmd 'autocmd FileType ruby setlocal omnifunc=LanguageClient#complete'
cmd 'autocmd FileType ruby nnoremap gd :call LanguageClient#textDocument_definition()<CR>'

cmd 'let g:deoplete#enable_at_startup = 1'
cmd 'let g:deoplete#complete_method = "omnifunc"'
cmd 'let g:echodoc#enable_at_startup = 1'
cmd 'let g:echodoc#type = \'virtual\''

cmd 'let g:lua_tree_tab_open=1'

aleLinters = {}
aleLinters["rubocop"] = {"~/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/rubocop-0.46.0/bin/rubocop"}
aleLinters["javascript"] = {"eslint"}
g.ale_ruby_rubocop_executable = '/Users/sgomenyuk/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/rubocop-0.46.0/bin/rubocop'
g.ale_linters = aleLinters
g.ale_set_highlights = 1
g.ale_lint_on_text_changed = 'normal'
g.ale_lint_on_insert_leave = 1

g.ale_sign_error = '❌'
g.ale_sign_warning = '❗'
cmd 'highlight clear ALEWarningSign'

g.go_doc_popup_window = 1
g.go_updatetime = 800
g.go_auto_type_info = 1
g.go_highlight_structs = 1
g.go_highlight_methods = 1
g.go_highlight_functions = 1
g.go_highlight_operators = 1
g.go_highlight_build_constraints = 1
g.go_highlight_function_parameters = 1
g.go_highlight_function_calls = 1
g.go_highlight_types = 1
g.go_highlight_fields = 1
g.go_highlight_generate_tags = 1
g.go_highlight_variable_declarations = 1
g.go_highlight_variable_assignments = 1
g.go_fmt_command = "goimports"
g.go_fmt_options = "-local=github.com/wheely"

fzfLayout = {}
fzfLayout["down"] = "~40%"
g.fzf_layout = fzfLayout

cmd [[
augroup go
  autocmd!
  autocmd Filetype go
  \  command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  \| command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  \| command! -bang AS call go#alternate#Switch(<bang>0, 'split')
augroup END

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
function CloseGoNext()
  :TablineBufferNext
  :bd#
endfunction
command! -bang Bc call CloseGoNext()

"alias for :vimgrep
command! -bang -nargs=+ Vg :vimgrep <args>|:bo copen

"vimgrep in current project
command! -bang -nargs=+ Vgp :vimgrep /<args>/j %:p:.:s?/.*??/**|:bo copen

"vimgrep for project under cursor(in NERDTree)
command! -bang -nargs=+ Vgc :vimgrep /<args>/j <cWORD>/**|:bo copen

"vimgrep for word under cursor in current project
command! -bang -nargs=0 Vgw exec 'vimgrep /'.expand('<cword>').'/j %:p:.:s?/.*??/**|:bo copen'
:nnoremap <C-g> :Vgw<CR>

"vimgrep for whole word under cursor in current project
command! -bang -nargs=0 Vgwh exec 'vimgrep /\<'.expand('<cword>').'\>/j %:p:.:s?/.*??/**|:bo copen'
:nnoremap <C-h> :Vgwh<CR>
:nnoremap <C-h> :GrepperGrep -w <cword><CR>

command Cbt :%bd|e#|NvimTreeToggle

let g:mergetool_layout = 'lmr'
let g:mergetool_prefer_revision = 'local'
nmap <leader>mt <plug>(MergetoolToggle)
nmap <leader>mr <plug>(MergetoolDiffExchangeLeft)
nmap <leader>ml <plug>(MergetoolDiffExchangeRight)
nmap <leader>s <plug>(GrepperOperator)
xmap <leader>s <plug>(GrepperOperator)

hi DiffAdd guibg=bg guifg=Green ctermbg=none
hi DiffChange guibg=bg guifg=#dad085 ctermbg=none
hi DiffDelete guibg=bg guifg=#f0a0c0 ctermbg=none
]]
