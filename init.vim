filetype plugin on
syntax enable

set guifont=mononoki-Regular\ Nerd\ Font\ Complete:h11
set guioptions-=e
set ttyfast
" set lazyredraw
" if system('echo $TERM_PROGRAM') =~ 'iTerm.app'
"     " iTerm has a special variable that tells us if it's in dark mode
"     if system('defaults read -g AppleInterfaceStyle') =~ 'Dark'
"         set background=dark
"     else
"         set background=light
"     endif
" else
"     " For other terminals, we'll just default to dark mode
"     set background=dark
" endif
set pumblend=10

" highlight Normal ctermbg=NONE guibg=NONE
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
" set cursorcolumn " highlight the cursors current col
highlight link CursorColumn CursorLine " have them always be the same color
set clipboard=unnamed " copy to system register
set mouse=a " turn on all mouse functionality
set timeoutlen=300 " Time to wait after ESC (default causes an annoying delay)
set list
set listchars=tab:⬝➜
set conceallevel=0
set completeopt=menu,menuone,noselect,noinsert

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

" buffer navigation
nnoremap <leader>n :bnext<CR>
nnoremap <leader>b :bprevious<CR>

" open github copilot chat
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

" indentline
" let g:indentLine_setColors=1
" let g:indentLine_char = '│'
" let g:indentLine_concealcursor='nc'

" conditionally run EnableYtt if file type is yaml without attaching to paste buffer
autocmd FileType yaml EnableYtt

" Enable true color
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" vim ale
let g:ale_linters = {
  \ 'ruby': ['reek', 'brakeman', 'rails_best_practices']
\}

" only lint ruby files


" turn off autocomplete for ale
let g:ale_completion_enabled = 0

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

  -- Bootstrap lazy.nvim
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
      vim.api.nvim_echo({
        { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
        { out, "WarningMsg" },
        { "\nPress any key to exit..." },
      }, true, {})
      vim.fn.getchar()
      os.exit(1)
    end
  end
  vim.opt.rtp:prepend(lazypath)

  -- Setup lazy.nvim
  require("lazy").setup({
    'kchmck/vim-coffee-script',
    'pangloss/vim-javascript',
    'jelera/vim-javascript-syntax',
    'mxw/vim-jsx',
    'cakebaker/scss-syntax.vim',
    'vim-ruby/vim-ruby',
    'mustache/vim-mustache-handlebars',
    'othree/javascript-libraries-syntax.vim',
    'briancollins/vim-jst',
    'tmux-plugins/vim-tmux',
    'chrisbra/csv.vim',
    'elixir-editors/vim-elixir',
    'slashmili/alchemist.vim',
    'slim-template/vim-slim',
    'fatih/vim-go',
    'leafgarland/typescript-vim',
    'peitalin/vim-jsx-typescript',
    'jparise/vim-graphql',
    'martinda/Jenkinsfile-vim-syntax',
    'cappyzawa/starlark.vim',
    'carvel-dev/ytt.vim',
    'https://github.com/apple/pkl-neovim.git',

    -- tools
    'dense-analysis/ale',
    'mattn/emmet-vim',
    'jszakmeister/vim-togglecursor',
    'Raimondi/delimitMate',
    'elzr/vim-json',
    -- { 'junegunn/fzf', dir = '~/.fzf', build = './install --all' },
    "ibhagwan/fzf-lua",
    'itchyny/vim-cursorword',
    'levouh/tint.nvim',
    'lukas-reineke/indent-blankline.nvim',
    'sotte/presenting.nvim',
    'sbdchd/neoformat',
    'zbirenbaum/copilot.lua',
    'nvim-lua/plenary.nvim',
    'nvim-pack/nvim-spectre',
    { 'CopilotC-Nvim/CopilotChat.nvim', branch = 'main' },
    'MunifTanjim/nui.nvim',
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
    {
      "telescope.nvim",
      dependencies = {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
    },
    'nvim-telescope/telescope.nvim',
    'nvim-tree/nvim-web-devicons',
    'nvim-lualine/lualine.nvim',
    {'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons'},
    'lewis6991/gitsigns.nvim',
    'NeogitOrg/neogit',
    'sindrets/diffview.nvim',
    'neovim/nvim-lspconfig',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/nvim-cmp',
    'zbirenbaum/copilot-cmp',
    'onsails/lspkind.nvim',

    -- all that tpope!
    'tpope/vim-repeat',
    'tpope/vim-vinegar',
    'tpope/vim-surround',
    'tpope/vim-commentary',
    'tpope/vim-endwise',

    { 'ojroques/vim-oscyank', branch = 'main', },
    {
      'maxmx03/solarized.nvim',
      lazy = false,
      priority = 1000,
      ---@type solarized.config
      opts = {},
      config = function(_, opts)
        vim.o.termguicolors = true
        vim.o.background = 'dark'
        require('solarized').setup({
          transparent = {
            enabled = true,         -- Master switch to enable transparency
            pmenu = true,           -- Popup menu (e.g., autocomplete suggestions)
            normal = true,          -- Main editor window background
            normalfloat = true,     -- Floating windows
            whichkey = true,        -- Which-key popup
            telescope = true,       -- Telescope fuzzy finder
          },
        })
        vim.cmd.colorscheme 'solarized'
      end,
    },
  })

  -- END lazy.nvim

  -- lsp custom diagnostics symbols
  local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  require('lualine').setup{
    theme = "solarized",
    sections = {
      lualine_a = {
        {
          function()
            local mode_map = {
              ['n'] = '',
              ['i'] = '',
              ['v'] = '󰸱',
              ['V'] = '󰸱 󰘤',
              [''] = '󰸱 󱓻',
              ['c'] = '󰘳',
              ['s'] = '󰒅',
              ['S'] = '󰒅 󰘤',
              [''] = '󰒅 󱓻',
              ['r'] = '',
              ['R'] = ' 󰘤',
              ['!'] = '',
              ['t'] = ''
            }
            local mode = vim.api.nvim_get_mode().mode
            if mode_map[mode] == nil then return '?' end
            return mode_map[mode]
          end,
          icon = nil,
        },
      },
      lualine_b = {
        {'filename', path = 1},
      },
      lualine_c = { 'diff' },
      lualine_x = {'filetype'},
      lualine_y = {{
        'diagnostics',
        sources = { 'nvim_lsp' },
        sections = { 'error', 'warn', 'info', 'hint' },
        symbols = {error = '󰅚 ', warn = '󰀪 ', info = ' ', hint = '󰌶 '},
        always_visible = false,
      }},
    },
    inactive_sections = {
      lualine_c = {{'filename', path = 1}, { 'diff', colored = false}},
      lualine_x = {'location'},
    },
  }

  require("bufferline").setup{
    highlights = {
      fill = {
        fg = '#dce0e8',
        bg = '#002b36',
      },
    },
    options = {
      mode = "tabs",
      diagnostics = "nvim_lsp",
      indicator = {
        style = "underline"
      },
      numbers = "none",
      show_buffer_close_icons = false,
      show_close_icon = false,
      diagnostics = "nvim_lsp",
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        local s = " "
        for e, n in pairs(diagnostics_dict) do
          local sym = e == "error" and " "
            or (e == "warning" and " " or "" )
          s = s .. n .. sym
        end
        return s
      end
    }
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
      auto_install = true,
      sync_install = false,
      ensure_installed = "all",
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
        additional_vim_regex_highlighting = false,
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

  require("copilot").setup({
    suggestion = {
      auto_trigger = true,
      keymap = {
        accept = "<C-j>",
      },
    }
  })
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

  -- Set up lspconfig. --------------------------------
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  local lspconfig = require('lspconfig')
  vim.keymap.set('n', 'K', vim.lsp.buf.hover)
  local root_pattern = lspconfig.util.root_pattern('.git')
--  local function add_ruby_deps_command(client, bufnr)
--    vim.api.nvim_buf_create_user_command(bufnr, "ShowRubyDeps", function(opts)
--      local params = vim.lsp.util.make_text_document_params()
--      local showAll = opts.args == "all"
--
--      client.request("rubyLsp/workspace/dependencies", params, function(error, result)
--        if error then
--          print("Error showing deps: " .. error)
--          return
--        end
--
--        local qf_list = {}
--        for _, item in ipairs(result) do
--          if showAll or item.dependency then
--            table.insert(qf_list, {
--              text = string.format("%s (%s) - %s", item.name, item.version, item.dependency),
--              filename = item.path
--            })
--          end
--        end
--
--        vim.fn.setqflist(qf_list)
--        vim.cmd('copen')
--      end, bufnr)
--    end,
--    {nargs = "?", complete = function() return {"all"} end})
--  end

--   lspconfig.ruby_lsp.setup({
--     cmd = (function()
--       vim.lsp.log.warn("ruby_lsp setup----------------------------------------------")
--       local bufname = vim.api.nvim_buf_get_name(0)
-- 
--       -- Turned into a filename
--       local filename = lspconfig.util.path.is_absolute(bufname) and bufname or lspconfig.util.path.join(vim.loop.cwd(), bufname)
-- 
-- 
--       -- Then the directory of the project
--       local project_dirname = root_pattern(filename) or lspconfig.util.path.dirname(filename)
--       vim.lsp.log.warn('project_dirname: ' .. project_dirname)
--       local last_directory = vim.fn.fnamemodify(project_dirname, ':t')
--       vim.lsp.log.warn('last_directory: ' .. last_directory)
-- 
--       -- If the basename is in the list of afdc projects, prefix with afdc- and suffix with -1
--       local container_name = ''
--       if vim.tbl_contains({ 'sponge', 'stations', 'vehicles' }, last_directory) then
--         vim.lsp.log.warn(last_directory)
--         container_name = 'afdc-' .. last_directory .. '-1'
--       end
-- 
--       -- If the basename is epact, return epact-web-1
--       if vim.tbl_contains({ 'epact' }, last_directory) then
--         vim.lsp.log.warn('epact')
--         container_name = 'epact-web-1'
--       end
--       vim.lsp.log.warn('container_name: ' .. container_name)
-- 
--       if container_name == '' or container_name == 'epact-web-1' then
--         -- there's no container for this so start from current location
--         return {
--           'ruby-lsp',
--           'stdio'
--         }
--       else
--         return {
--           'ruby-lsp',
--           'stdio'
--         }
--       --   return {
--       --     'docker',
--       --     'exec',
--       --     '-i',
--       --     container_name,
--       --     'ruby-lsp',
--       --     'stdio'
--       --   }
--       end
--     end)(),
--     on_attach = function(client, buffer)
--       add_ruby_deps_command(client, buffer)
--     end,
--     -- I don't think this does what I want it to do.
--     -- I haven't found a way to get rewrite these paths, and I don't think it's possible.
--     before_init = function(initialize_params, config)
--       initialize_params.rootUri = initialize_params.rootUri:gsub('/app', '/Users/jkrueger/Code')
--     end,
--   })

  -- lspconfig.solargraph.setup {
  --   cmd = {
  --     'docker',
  --     'exec',
  --     'afdc-sponge-1',
  --     'solargraph',
  --     'stdio'
  --   },
  --   flags = {
  --     allow_incremental_sync = true,
  --   },
  -- }
  lspconfig.ruby_lsp.setup {
    init_options = {
      formatter = 'standard',
      linters = { 'standard' },
    },
  }
  lspconfig.standardrb.setup {
    flags = {
      allow_incremental_sync = true,
      debounce_text_changes = 150,
    },
    handlers = {
      ["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
          update_in_insert = true,
        }
      ),
    },
  }
  lspconfig.ts_ls.setup {
    init_options = {
      plugins = {
        {
          name = '@vue/typescript-plugin',
          languages = { 'vue' },
        },
      },
    },
    filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
  }

  lspconfig.volar.setup {}
  -- END lspconfig --------------------------------

  -- alias gd to find definition of word under cursor in normal mode
  function PeekDefinition()
    local params = vim.lsp.util.make_position_params()
    vim.lsp.buf_request(0, 'textDocument/definition', params, function(err, result)
      if err or not result then return end
      if vim.tbl_isempty(result) then print("No definition found") return end
      local target = result[1]
      if target == nil then return end
      local filename = target.uri and vim.fn.fnamemodify(vim.uri_to_fname(target.uri), ":p:.") or ""
      local opts = {
        border = "single",
        title = filename,
        focusable = true,
        focus = true,
      }
      local preview_win_id = vim.lsp.util.preview_location(target, opts)
      vim.schedule(function()
        local win_ids = vim.api.nvim_list_wins()
        local preview_win_id = win_ids[#win_ids]
        vim.api.nvim_set_current_win(preview_win_id)
      end)
    end)
  end
  vim.api.nvim_set_keymap('n', 'gp', '<cmd>lua PeekDefinition()<CR>', {noremap = true, silent = true})
  local function on_list(options)
    vim.fn.setqflist({}, ' ', options)
    vim.cmd.cfirst()
  end
vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition({ on_list = on_list })<CR>', {noremap = true, silent = true})

  -- indentation
  require("ibl").setup({
    indent = { char = "│" },
  })

  -- neogit
  local neogit = require('neogit')
  neogit.setup {}
  vim.api.nvim_set_keymap('n', '<C-d>', ':DiffviewOpen', {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<C-g>', ':Neogit<CR>', {noremap = true, silent = true})

  -- colorscheme
  -- require("catppuccin").setup({
  --   transparent_background = true,
  --   dim_inactive = {
  --       enabled = true,
  --       shade = "dark",
  --       percentage = 0.25,
  --   },
  --   integrations = {
  --     native_lsp = {
  --       enabled = true,
  --       virtual_text = {
  --         errors = { "italic" },
  --         hints = { "italic" },
  --         warnings = { "italic" },
  --         information = { "italic" },
  --       },
  --       underlines = {
  --         errors = { "undercurl" },
  --         hints = { "undercurl" },
  --         warnings = { "undercurl" },
  --         information = { "undercurl" },
  --       },
  --     },
  --   },
  -- })
  vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', {desc = "Toggle Spectre"})
END
