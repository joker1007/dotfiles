-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {'Shougo/vimproc', run = 'make'}
  use 'tyru/eskk.vim'
  use 'tyru/skkdict.vim'

  use 'scrooloose/nerdcommenter'

  use 'thinca/vim-prettyprint'
  use 'mhinz/vim-startify'
  use 'hecal3/vim-leader-guide'
  use 'kyazdani42/nvim-web-devicons'
  use 'junegunn/vim-emoji'

  use 'moro/vim-review'
  use 'cespare/vim-toml'

  use 'kana/vim-submode'

  use 'simeji/winresizer'

  use 'plasticboy/vim-markdown'

  use {'mattn/vim-maketable', ft = 'markdown'}

  use {'joker1007/vim-ruby-heredoc-syntax', ft = {'ruby', 'eruby'}}

  use {'joker1007/vim-markdown-quote-syntax', ft = 'markdown'}

  -- colorschemes plugin {{{
  use 'glepnir/zephyr-nvim'
  use 'projekt0n/github-nvim-theme'
  use 'shaunsingh/nord.nvim'
  -- }}}

  -- ruby rails develop {{{
  use 'tpope/vim-rails'
  use 'vim-ruby/vim-ruby'
  use 'thinca/vim-quickrun'

  use 'leafgarland/typescript-vim'
  -- }}}

  -- vim-scripts {{{
  use 'vim-scripts/surround.vim'
  use 'vim-scripts/errormarker.vim'
  -- }}}

  -- smartchr textobj {{{
  use 'kana/vim-smartchr'
  use 'kana/vim-textobj-user'
  use 'kana/vim-niceblock'
  use {'nelstrom/vim-textobj-rubyblock', ft = 'ruby'}
  use 'kana/vim-textobj-indent'
  -- }}}


  -- html template {{{
  use 'mattn/emmet-vim'
  use 'slim-template/vim-slim'
  use 'tpope/vim-haml'
  use 'nono/vim-handlebars'
  use 'juvenn/mustache.vim'
  -- }}}

  -- visibility {{{
  use 'lukas-reineke/indent-blankline.nvim'
  use 'LeafCage/foldCC'
  use 'nvim-lualine/lualine.nvim'
  use 'nanozuki/tabby.nvim'
  use 'NvChad/nvim-colorizer.lua'
  use 'osyo-manga/vim-over'
-- }}}

  -- haskell develop {{{
  use 'dag/vim2hs'
  -- }}}

  -- web browse, api {{{
  use 'tyru/open-browser.vim'
  use 'mattn/webapi-vim'
  use {'kannokanno/previm', ft = 'markdown'}
  -- }}}

  -- other programinng {{{
  use 'nvim-treesitter/nvim-treesitter'
  use 'andymass/vim-matchup'
  use 'godlygeek/tabular'
  use 'dense-analysis/ale'
  use 'rhysd/github-complete.vim'
  use 'rhysd/ghpr-blame.vim'
  use 'hashivim/vim-terraform'
  use 'Shougo/vinarise.vim'
  use {'autozimu/LanguageClient-neovim', branch = 'next', run = 'bash install.sh'}

  use 'rking/ag.vim'
  use {'thinca/vim-qfreplace', cmd = {'Qfreplace'}}
  use 'octol/vim-cpp-enhanced-highlight'
  use 'derekwyatt/vim-scala'
  use 'rust-lang/rust.vim'
  use 'derekwyatt/vim-sbt'
  use 'elixir-lang/vim-elixir'
  use 'fatih/vim-go'
  use 'rhysd/devdocs.vim'
  use 'othree/html5.vim'
  use 'moskytw/nginx-contrib-vim'
  use 'osyo-manga/shabadou.vim'
  use 'mattn/httpstatus-vim'
  use 'tmux-plugins/vim-tmux'
  use 'haya14busa/incsearch.vim'
  use 'eugen0329/vim-esearch'

  use 'vim-scripts/SQLUtilities'
  use 'exu/pgsql.vim'

  use 'AndrewRadev/switch.vim'

  use 'kana/vim-altr'

  use 'osyo-manga/vim-anzu'

  -- tweetvim {{{
  use 'basyura/bitly.vim'
  use 'basyura/twibill.vim'
  use 'basyura/TweetVim'
  -- }}}

  -- cursor move {{{
  use 'thinca/vim-visualstar'

  use 'Lokaltog/vim-easymotion'
  use 't9md/vim-choosewin'
  use 'sunjon/shade.nvim'
  -- }}}

  -- git {{{
  use 'tpope/vim-fugitive'
  use 'rbong/vim-flog'
  use 'lewis6991/gitsigns.nvim'
  use 'ldelossa/litee.nvim'
  use 'ldelossa/gh.nvim'

  use {'lambdalisue/vim-gista', cmd = {"Gista"}}
  -- }}}

  -- denite {{{
  use 'Shougo/neomru.vim'

  use 'Shougo/denite.nvim'
  use 'liuchengxu/vista.vim'
  -- }}}

  -- completion {{{
  -- use 'Shougo/deoplete.nvim'
  -- }}}

  use 'mattn/vim-sonots'

  -- }}}

  -- neovim {{{
  use 'equalsraf/neovim-gui-shim'
  use 'kassio/neoterm'
  use 'janko-m/vim-test'
  use 'brettanomyces/nvim-editcommand'
  use {'euclio/vim-markdown-composer', run = 'cargo build --release'}
  use 'subnut/nvim-ghost.nvim'
  use 'kyazdani42/nvim-tree.lua'
end)
