" START plug ----------------------------
call plug#begin('~/.vim/plugged')

" " syntaxes
Plug 'kchmck/vim-coffee-script'
Plug 'pangloss/vim-javascript'
Plug 'jelera/vim-javascript-syntax'
Plug 'mxw/vim-jsx'
Plug 'cakebaker/scss-syntax.vim'
Plug 'vim-ruby/vim-ruby'
Plug 'mustache/vim-mustache-handlebars'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'briancollins/vim-jst'
Plug 'tmux-plugins/vim-tmux'
Plug 'chrisbra/csv.vim'
Plug 'elixir-editors/vim-elixir'
Plug 'slashmili/alchemist.vim'
Plug 'slim-template/vim-slim'
Plug 'fatih/vim-go'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'jparise/vim-graphql'
Plug 'posva/vim-vue'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'cappyzawa/starlark.vim'
Plug 'carvel-dev/ytt.vim'
Plug 'https://github.com/apple/pkl-neovim.git'

" " colorschemes
Plug 'altercation/vim-colors-solarized'
Plug 'jtmkrueger/grb256'
Plug 'dracula/vim'

" " tools
Plug 'ojroques/vim-oscyank', {'branch': 'main'}
Plug 'github/copilot.vim'
Plug 'mattn/emmet-vim'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'dense-analysis/ale'
Plug 'jszakmeister/vim-togglecursor'
Plug 'Raimondi/delimitMate'
Plug 'elzr/vim-json'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'itchyny/vim-cursorword'
Plug 'Yggdroot/indentLine'
Plug 'sotte/presenting.nvim'
Plug 'sbdchd/neoformat'

" nvim specific
Plug 'zbirenbaum/copilot.lua'
Plug 'nvim-lua/plenary.nvim'
Plug 'CopilotC-Nvim/CopilotChat.nvim', { 'branch': 'canary' }
Plug 'MunifTanjim/nui.nvim'
" Plug 'jackMort/ChatGPT.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
" Plug 'dir-telescope.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-lualine/lualine.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'onsails/lspkind.nvim'

" all that tpope!
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-surround'
" Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
call plug#end()
" END plug ------------------------

filetype plugin on
syntax enable

set guifont=mononoki-Regular\ Nerd\ Font\ Complete:h11
set guioptions-=e
set ttyfast
" set lazyredraw
" set shell=/bin/bash
set background=dark
colorscheme dracula
highlight Normal ctermbg=NONE guibg=NONE

set t_ZH=^[[3m
set t_ZR=^[[23m
highlight Comment cterm=italic gui=italic

" tab styles
set showtabline=2 " always show tabs

set t_ZH=[3m
set t_ZR=[23m
set encoding=UTF-8
set fileencoding=utf-8
" set t_Co=256
set magic "for regular epressions turn magic on

set noerrorbells " no errorbells!
set vb t_vb= " seriously, no errorbells!!

set tabstop=2 softtabstop=2 shiftwidth=2
set expandtab " use spaces instead of tab characters
autocmd FileType go setlocal tabstop=2 softtabstop=2 shiftwidth=2 noexpandtab
autocmd FileType mod setlocal tabstop=2 softtabstop=2 shiftwidth=2 noexpandtab
set smarttab " start tabbed in
set backspace=start,eol,indent " always allow backspaces
set wildmenu " trick out command mode
set incsearch " highlight search pattern as it's typed
set ignorecase " searches are case insensitive...
set smartcase " ... unless they contain at least one capital letter
set wrap " textwrap
" set to no show for speed
hi NonText cterm=NONE ctermfg=NONE
set linebreak " wrap lines at spaces
set wrapmargin=0 " wrap at last column
set autoindent
set autoread " automatically reads file in
set cmdheight=1
set smartindent
set textwidth=0 " disable auto line breaking on paste
set number " line numbers
" set laststatus=0 " no status line
" hi StatusLine   ctermfg=gray      ctermbg=16  gui=none  term=none      cterm=none
" hi StatusLineNC ctermfg=darkgray  ctermbg=16  gui=none  term=none      cterm=none

" set statusline=%f

" just save when I change tabs or leave the vim
" set autowriteall
" autocmd TextChanged,TextChangedI,FocusLost,InsertLeave *
"     \ if &buftype ==# '' || &buftype == 'acwrite' |
"     \     update |
"     \ endif

set scrolloff=5 " 5 line buffer below cursor when scrolling
set hlsearch " highlight search results
set cursorline " highlight line cursor is on
set cursorcolumn " highlight the cursors current col
set clipboard=unnamed " copy to system register
set mouse=a " turn on all mouse functionality
set timeoutlen=300 " Time to wait after ESC (default causes an annoying delay)
set list
set listchars=tab:⬝➜
set conceallevel=0
set completeopt=menu,menuone,noselect,noinsert
" let g:netrw_bufsettings = 'noma nomod nu nowrap ro nobl'
" let g:netrw_banner = 1

" HOLY SHIT the new engine just kills ruby files. This drastically improves performance!
" set regexpengine=1

" Normally, Vim messes with iskeyword when you open a shell file. This can
" leak out, polluting other file types even after a 'set ft=' change. This
" variable prevents the iskeyword change so it can't hurt anyone.
let g:sh_noisk=1

" " Resize splits when the window is resized
au VimResized * :wincmd =

" Store swap files in a central spot
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set nobackup
set nowritebackup
set shortmess+=c

" you can undo even when you close a buffer/VIM
try
    set undodir=~/.vim_runtime/temp_dirs/undodir
    set undofile
catch
endtry

" additional filetype detection
autocmd BufRead,BufNewFile *.axlsx set filetype=ruby
autocmd BufRead,BufNewFile *.inky set filetype=slim

" map leader to space
let mapleader = "\<Space>"

" neovim needs to be like vim
nnoremap Y Y

" leader mappings
nnoremap <leader>v :vs<space>
nnoremap <leader>s :sp<space>
nnoremap <leader>t :tabe<space>
nnoremap <leader>V :Vex<CR>
nnoremap <leader>S :Sex<CR>
nnoremap <leader>T :Tex<CR>

" buffer navigation
nnoremap <leader>n :bnext<CR>
nnoremap <leader>b :bprevious<CR>

" open github copilot
nnoremap <leader>c :CopilotChatOpen<CR>

" Open new splits to the right/bottom
set splitright splitbelow

" I want my custom commands!
imap <C-t> <%= %><Left><Left><Left>

" up/down on wrapped lines
nnoremap j gj
nnoremap k gk

" Reselect visual block after indent
vnoremap < <gv
vnoremap > >gv

" make . work in visual mode
:vnoremap . :norm.<cr>

" clear search highlights with enter
nnoremap <CR> :nohlsearch<CR>/<BS>

" make resizing windows a bit easier
noremap <left> <C-w>>
noremap <right> <C-w><
noremap <up> <C-w>-
noremap <down> <C-w>+

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv


" Easier to type, and I never use the default behavior.
noremap H ^
noremap L $
vnoremap L g_

noremap <TAB> % " easer to hit

" neoformat
let g:neoformat_try_node_exe = 1
" prettier on save
autocmd BufWritePre *.js,*.css,*.vue Neoformat

" telescope
nnoremap <c-f> <cmd>Telescope find_files<cr>
nnoremap <c-a> <cmd>Telescope live_grep<cr>

" togglecursor
let g:togglecursor_force = 'xterm'
let g:togglecursor_default = 'blinking_block'

" vim-json
let g:vim_json_syntax_conceal = 0

" emmet expansions
let g:user_emmet_leader_key = '<c-e>'

" gitgutter
set signcolumn=yes

" indentline
let g:indentLine_setColors=1
let g:indentLine_char = '│'
let g:indentLine_concealcursor='nc'

" function! LinterStatus() abort
"     let l:counts = ale#statusline#Count(bufnr(''))

"     let l:all_errors = l:counts.error + l:counts.style_error
"     let l:all_non_errors = l:counts.total - l:all_errors

"     return l:counts.total == 0 ? 'OK' : printf(
"     \   ':%d ✘:%d',
"     \   all_non_errors,
"     \   all_errors
"     \)
" endfunction

" copilot
imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

" conditionally run EnableYtt if file type is yaml without attaching to paste buffer
autocmd FileType yaml EnableYtt

" Enable true color
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" set tmux window name automatically
" augroup Tmux "{{{2
"   au!
"   " autocmd VimEnter,BufNewFile,BufReadPost * call system('tmux rename-window "vim-' . split(substitute(getcwd(), $HOME, '~', ''), '/')[-1] . '"')
"   autocmd VimEnter,BufNewFile,BufReadPost * call system('tmux rename-window "nvim"')
"   autocmd VimLeave * call system('tmux rename-window ' . split(substitute(getcwd(), $HOME, '~', ''), '/')[-1])
" augroup END

" if (!has('nvim') && !has('clipboard_working'))
" In the event that the clipboard isn't working, it's quite likely that
" the + and * registers will not be distinct from the unnamed register. In
" this case, a:event.regname will always be '' (empty string). However, it
" can be the case that `has('clipboard_working')` is false, yet `+` is
" still distinct, so we want to check them all.
let s:VimOSCYankPostRegisters = ['', '+', '*']
function! s:VimOSCYankPostCallback(event)
    if a:event.operator == 'y' && index(s:VimOSCYankPostRegisters, a:event.regname) != -1
        call OSCYankRegister(a:event.regname)
    endif
endfunction
augroup VimOSCYankPost
    autocmd!
    autocmd TextYankPost * call s:VimOSCYankPostCallback(v:event)
augroup END
" endif

lua << END
  -- lsp custom diagnostics symbols
  local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end
  require('lualine').setup{
    sections = {
      lualine_b = {
        {'filename', path = 1}
      },
      lualine_c = {},
      lualine_x = {'filetype'},
      lualine_y = {{
        'diagnostics',
        sources = { 'nvim_lsp' },
        sections = { 'error', 'warn', 'info', 'hint' },
        symbols = {error = '󰅚 ', warn = '󰀪 ', info = ' ', hint = '󰌶 '},
        colored = true,
        update_in_insert = false,
        always_visible = false,
      },
    }},
    inactive_sections = {
      lualine_c = {{'filename', path = 1}},
      lualine_x = {'location'},
    },
    tabline = {
      lualine_a = {
        {
            'tabs',
            mode = 2,
            max_length = vim.o.columns,
        }
      },
      lualine_x = {'nvim_treesitter#statusline'},
    }
  }

  require'nvim-treesitter.configs'.setup {
    ensure_installed = "all",
  }

  require('gitsigns').setup {
    current_line_blame = true,
  }

  local telescope = require("telescope")
  local telescopeConfig = require("telescope.config")
  -- Clone the default Telescope configuration
  local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
  -- I want to search in hidden/dot files.
  table.insert(vimgrep_arguments, "--hidden")
  -- I don't want to search in the `.git` directory.
  table.insert(vimgrep_arguments, "--glob")
  table.insert(vimgrep_arguments, "!**/.git/*")
  require('telescope').setup{
    defaults = {
      wrap_results = true,
      vimgrep_arguments = vimgrep_arguments,
    },
    pickers = {
      find_files = {
        find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
      },
    },
    extensions = {
    }
  }

  -- this is all code to get ruby-lsp working
  _timers = {}
  local function setup_diagnostics(client, buffer)
    if require("vim.lsp.diagnostic")._enable then
      return
    end

    local diagnostic_handler = function()
      local params = vim.lsp.util.make_text_document_params(buffer)
      client.request("textDocument/diagnostic", { textDocument = params }, function(err, result)
        if err then
          local err_msg = string.format("diagnostics error - %s", vim.inspect(err))
          vim.lsp.log.error(err_msg)
        end
        local diagnostic_items = {}
        if result then
          diagnostic_items = result.items
        end
        vim.lsp.diagnostic.on_publish_diagnostics(
          nil,
          vim.tbl_extend("keep", params, { diagnostics = diagnostic_items }),
          { client_id = client.id }
        )
      end)
    end

    diagnostic_handler() -- to request diagnostics on buffer when first attaching

    vim.api.nvim_buf_attach(buffer, false, {
      on_lines = function()
        if _timers[buffer] then
          vim.fn.timer_stop(_timers[buffer])
        end
        _timers[buffer] = vim.fn.timer_start(200, diagnostic_handler)
      end,
      on_detach = function()
        if _timers[buffer] then
          vim.fn.timer_stop(_timers[buffer])
        end
      end,
    })
  end

  local hasConfigs, configs = pcall(require, "nvim-treesitter.configs")
  if hasConfigs then
    configs.setup {
      ensure_installed = "pkl",
      highlight = {
        enable = true,              -- false will disable the whole extension
      },
      indent = {
        enable = true
      }
    }
  end

  vim.api.nvim_create_user_command('NN', function()
    local timestamp = os.date('%Y%m%d-%H%M%S')
    local bufferDir = vim.fn.expand('%:p:h')
    local filename = vim.fn.input('Enter file name: ', timestamp .. '-')
    local fullPath = bufferDir .. '/' .. filename .. '.md'
    vim.api.nvim_command('edit ' .. fullPath)
  end, {})

  require("CopilotChat").setup {
    debug = true, -- Enable debugging
    show_help = false,
  }

  local cmp = require'cmp'
  cmp.setup({
    snippet = {
      expand = function(args)
        vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
      end,
    },
    completion = {
      completeopt = table.concat(vim.opt.completeopt:get(), ","),
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ["<Tab>"] = cmp.mapping.select_next_item({behavior=cmp.SelectBehavior.Insert}),
      ["<S-Tab>"] = cmp.mapping.select_prev_item({behavior=cmp.SelectBehavior.Insert}),
    }),
    formatting = {
      format = function(entry, vim_item)
        if vim.tbl_contains({ 'path' }, entry.source.name) then
          local icon, hl_group = require('nvim-web-devicons').get_icon(entry:get_completion_item().label)
          if icon then
            vim_item.kind = icon
            vim_item.kind_hl_group = hl_group
            return vim_item
          end
        end
        return require('lspkind').cmp_format({ with_text = false })(entry, vim_item)
      end
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
    }, {
      { name = 'buffer' },
    })
  })
   -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['solargraph'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['standardrb'].setup {
    capabilities = capabilities
  }

  vim.opt.signcolumn = "yes" -- otherwise it bounces in and out, not strictly needed though
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "ruby",
    -- group = vim.api.nvim_create_augroup("RubyLSP", { clear = true }), -- also this is not /needed/ but it's good practice 
    callback = function()
      vim.lsp.start {
        name = "standardrb",
        cmd = { "standardrb", "--lsp" },
      }
    end,
  })

  require('lspconfig').vls.setup{}
END
