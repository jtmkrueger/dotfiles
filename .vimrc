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
Plug 'https://codeberg.org/esensar/nvim-dev-container.git'

" " colorschemes
Plug 'altercation/vim-colors-solarized'
Plug 'jtmkrueger/grb256'
Plug 'projekt0n/github-nvim-theme'

" " tools
Plug 'github/copilot.vim'
Plug 'mattn/emmet-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'
Plug 'jszakmeister/vim-togglecursor'
Plug 'Raimondi/delimitMate'
Plug 'elzr/vim-json'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'itchyny/vim-cursorword'
Plug 'Yggdroot/indentLine'

" nvim specific
Plug 'nvim-lua/plenary.nvim'
Plug 'MunifTanjim/nui.nvim'
" Plug 'jackMort/ChatGPT.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
" Plug 'dir-telescope.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-lualine/lualine.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'neovim/nvim-lspconfig'

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
set regexpengine=1

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
nnoremap <leader>c :bp\|bd #<CR>
nnoremap <leader>o :Bonly<CR>

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

" FZF
" nnoremap <c-f> :FZF<Enter>
" let g:fzf_action = {
"   \ 'ctrl-t': 'tab split',
"   \ 'ctrl-s': 'split',
"   \ 'ctrl-v': 'vsplit' }

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

" COC
inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use h to show documentation in preview window.
nnoremap <silent> <leader>h :call <SID>show_documentation()<CR>

" for ChatGPT
" map <leader>c :ChatGPT<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" ale
" Available language servers:
"   ruby (solargraph)
let g:ale_sign_error = '✘'
let g:ale_echo_msg_error_str = '✘' " FIXME: not doing anything
let g:ale_sign_warning = ''
let g:ale_echo_msg_warning_str = '' " FIXME: not doing anything
let g:ale_completion_enabled = 0
let g:ale_virtualtext_prefix = ': '
highlight ALEErrorSign ctermfg=red
highlight ALEWarningSign ctermfg=red
let g:ale_linters = {
\   'javascript': ['eslint', 'prettier'],
\   'scss': ['prettier'],
\   'ruby': ['rubocop', 'standardrb', 'reek', 'rails_best_practices', 'brakeman', 'debride']
\}
let g:ale_fixers = {
\   'javascript': ['eslint', 'prettier'],
\   'ruby': ['rubocop', 'standardrb']
\}
let g:ale_fix_on_save = 1
let g:ale_lint_on_text_changed = 1
let g:ale_disable_lsp = 1
nmap <C-g> :ALEGoToDefinitionInTab<CR>

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
    \   ':%d ✘:%d',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

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
augroup Tmux "{{{2
  au!
  " autocmd VimEnter,BufNewFile,BufReadPost * call system('tmux rename-window "vim-' . split(substitute(getcwd(), $HOME, '~', ''), '/')[-1] . '"')
  autocmd VimEnter,BufNewFile,BufReadPost * call system('tmux rename-window "nvim"')
  autocmd VimLeave * call system('tmux rename-window ' . split(substitute(getcwd(), $HOME, '~', ''), '/')[-1])
augroup END

lua << END
  vim.cmd('colorscheme github_dark_high_contrast')

  require('lualine').setup{
    sections = {
      lualine_b = {
        {'filename', path = 1}
      },
      lualine_c = {},
      lualine_x = {'filetype'},
      lualine_y = {'LinterStatus'},
    },
    tabline = {
      lualine_a = {
        {
            'tabs',
            mode = 3,
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
      -- Default configuration for telescope goes here:
      -- config_key = value,
      -- ..
      wrap_results = true,
      vimgrep_arguments = vimgrep_arguments,
    },
    pickers = {
      -- Default configuration for builtin pickers goes here:
      -- picker_name = {
      --   picker_config_key = value,
      --   ...
      -- }
      -- Now the picker_config_key will be applied every time you call this
      -- builtin picker
      find_files = {
        -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
        find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
      },
    },
    extensions = {
      -- Your extension configuration goes here:
      -- extension_name = {
      --   extension_config_key = value,
      -- }
      -- please take a look at the readme of the extension you want to configure
    }
  }
  require("devcontainer").setup{
    container_runtime = "docker",
    compose_command = "docker-compose",
    nvim_installation_commands_provider = function(_, version_string)
      return {
        { "apt-get", "update" },
        { "apt-get", "install", "-y", "ninja-build", "gettext", "cmake", "unzip", "curl" },
        { "sh", "-c", "cd /root && git clone --depth=1 https://github.com/neovim/neovim" },
        { "sh", "-c", "cd /root/neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo && make install" },
      }
    end,
    attach_mounts = {
      neovim_config = {
        -- enables mounting local config to /root/.config/nvim in container
        enabled = true,
        -- no options
        options = {}
      },
      neovim_data = {
        -- enables mounting local data to /root/.local/share/nvim in container
        enabled = true,
        -- no options
        options = {}
      },
      -- Only useful if using neovim 0.8.0+
      neovim_state = {
        -- enables mounting local state to /root/.local/state/nvim in container
        enabled = true,
        -- no options
        options = {}
      },
    },
  }
  -- require("chatgpt").setup({
  --   popup_input = {
  --     submit = "<C-s>"
  --   },
  --   openai_edit_params = {
  --     model = "gpt-3.5-turbo"
  --   }
  -- })
  -- textDocument/diagnostic support until 0.10.0 is released

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

  require("lspconfig").ruby_ls.setup({
    cmd = { "nc", "localhost", "7201" },
    filetypes = {"ruby"},
    root_dir = function(fname)
      return require'lspconfig'.util.find_git_ancestor(fname) or vim.loop.os_homedir()
    end,
    settings = {},
  })

  vim.api.nvim_create_user_command('NN', function()
    local timestamp = os.date('%Y%m%d-%H%M%S')
    local bufferDir = vim.fn.expand('%:p:h')
    local filename = vim.fn.input('Enter file name: ', timestamp .. '-')
    local fullPath = bufferDir .. '/' .. filename .. '.md'
    vim.api.nvim_command('edit ' .. fullPath)
  end, {})
END
