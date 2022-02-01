local map = vim.api.nvim_set_keymap
local default_opts = {noremap = true, silent = true}

map('n', '<F4>', ':set list!<CR>', {noremap = true})
map('i', '<F4>', '<C-o>:set list!<CR>', {noremap = true})
map('c', '<F4>', '<C-o>:set list!<CR>', {noremap = true})
map('n', '<F5>', ':call LanguageClient_contextMenu()<CR>', {noremap=true})
map('n', 'K', ':call LanguageClient#textDocument_hover()<CR>', {noremap=true})

map('n', '<S-Left>', ':TablineBufferPrevious<CR>', {noremap=true})
map('n', '<S-Right>', ':TablineBufferNext<CR>', {noremap=true})
map('n', '<C-n>', ':MyNewTab<CR>', {noremap=true})
map('n', '<C-S-Left>', 'gT', {noremap=true})
map('n', '<C-S-Right>', 'gt', {noremap=true})
map('n', '<S-Down>', ':cn<CR>', {noremap=true})
map('n', '<S-Up>', ':cp<CR>', {noremap=true})

map('i', '<C-d>', '<C-o>diw', {noremap=true})
map('n', '<S-t>', ':TablineBuffersBind %<CR>', {noremap=true})
map('n', '<C-q>', ':Bd<CR>', {noremap=true})

map('n', '<M-t>', ':NvimTreeToggle<CR>', {noremap=true})
map('n', '<M-a>', ':Files<CR>', {noremap=true})
map('n', '<M-g>', ':NvimTreeFindFile<CR>', {noremap=true})
map('n', '<M-o>', ':Buffers<CR>', {noremap=true})
map('n', '<M-p>', ':FP<CR>', {noremap=false})
map('n', '<M-S-p>', ':SP<CR>', {noremap=true})
