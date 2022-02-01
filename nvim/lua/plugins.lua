vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'habamax/vim-alchemist'
  use 'powerman/vim-plugin-ruscmd'
  use 'easymotion/vim-easymotion'
  use 'nvim-lua/plenary.nvim'
  use 'jiangmiao/auto-pairs'
  use 'samoshkin/vim-mergetool'
  use 'lewis6991/gitsigns.nvim'
  use 'dense-analysis/ale'
  use 'cocopon/iceberg.vim'
  use 'junegunn/fzf.vim'
  use 'Shougo/echodoc.vim'
  use 'kdheepak/tabline.nvim'
  use 'McAuleyPenney/tidy.nvim'
  use 'karb94/neoscroll.nvim'
  use 'gennaro-tedesco/nvim-jqx'
  use 'junegunn/vim-peekaboo'
  use 'skanehira/preview-uml.vim'
  use 'famiu/nvim-reload'
  use 'solarnz/thrift.vim'
  use 'mhinz/vim-grepper'

  use { 'junegunn/fzf',
        run = ':call fzf#install()',
      }
  use { 'fatih/vim-go',
        run = ':GoUpdateBinaries'
      }
  use { 'autozimu/LanguageClient-neovim',
        branch = 'next',
        run = 'bash install.sh',
      }
  use { 'Shougo/deoplete.nvim',
        run = ':UpdateRemotePlugins',
      }
  use { 'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true},
        config = function()
          require('lualine').setup()
        end,
      }
  use { 'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function() require'nvim-tree'.setup {} end,
      }
end)
