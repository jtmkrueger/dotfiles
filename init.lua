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


local opts = { noremap=true, silent=true }

local function quickfix()
  vim.lsp.buf.code_action({
    filter = function(a) return a.isPreferred end,
    apply = true
  })
end
vim.keymap.set('n', '<leader>qf', quickfix, opts)

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
  "ibhagwan/fzf-lua",
  'itchyny/vim-cursorword',
  'levouh/tint.nvim',
  'lukas-reineke/indent-blankline.nvim',
  'sotte/presenting.nvim',
  'sbdchd/neoformat',
  'nvim-pack/nvim-spectre',
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          auto_trigger = true,
          keymap = {
            accept = "<C-j>",
          },
        }
      })
    end,
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'main',
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    config = function ()
      require("CopilotChat").setup {
        debug = true, -- Enable debugging
        show_help = false,
      }
    end
  },
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
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",        -- optional - Diff integration

      -- Only one of these is needed.
      "nvim-telescope/telescope.nvim", -- optional
      "ibhagwan/fzf-lua",              -- optional
      "echasnovski/mini.pick",         -- optional
    },
    config = true
  },
  'sindrets/diffview.nvim',
  {
    'adam12/ruby-lsp.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'neovim/nvim-lspconfig',
    },
    config = true,
    opts = {
      lspconfig = {
        init_options = {
          formatter = 'standard',
          linters = { 'standard' },
        },
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/nvim-cmp',
      'onsails/lspkind.nvim',
    },
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require('lspconfig')
      vim.keymap.set('n', 'K', vim.lsp.buf.hover)
      local root_pattern = lspconfig.util.root_pattern('.git')

      lspconfig.ts_ls.setup {
        capabilities = capabilities,
        root_dir = root_pattern,
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

      lspconfig.volar.setup {
        capabilities = capabilities,
        root_dir = root_pattern,
      }
    end,
  },
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
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        transparent_background = true,
        dim_inactive = {
          enabled = true, -- dims the background color of inactive window
          shade = "light",
          percentage = 0.50, -- percentage of the shade to apply to the inactive window
        },
      })
      vim.cmd.colorscheme "catppuccin"
    end,
  },
  --{
  --  'maxmx03/solarized.nvim',
  --  lazy = false,
  --  priority = 1000,
  --  ---@type solarized.config
  --  opts = {},
  --  config = function(_, opts)
  --    vim.o.termguicolors = true
  --    vim.o.background = 'dark'
  --    require('solarized').setup({
  --      transparent = {
  --        enabled = true,         -- Master switch to enable transparency
  --        pmenu = true,           -- Popup menu (e.g., autocomplete suggestions)
  --        normal = true,          -- Main editor window background
  --        normalfloat = true,     -- Floating windows
  --        whichkey = true,        -- Which-key popup
  --        telescope = true,       -- Telescope fuzzy finder
  --      },
  --    })
  --    vim.cmd.colorscheme 'solarized'
  --  end,
  --},
})

-- END lazy.nvim

-- italic comments
vim.cmd('highlight Comment cterm=italic gui=italic')

vim.cmd('filetype plugin on')
vim.cmd('syntax enable')

vim.opt.guifont = "mononoki-Regular Nerd Font Complete:h11"
vim.opt.ttyfast = true
vim.opt.pumblend = 10

-- tab styles
vim.opt.showtabline = 2 -- always show tabs

vim.opt.encoding = 'UTF-8'
-- vim.opt.fileencoding = 'utf-8'
vim.opt.magic = true -- for regular expressions turn magic on

vim.opt.vb = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true -- use spaces instead of tab characters
vim.api.nvim_create_autocmd("FileType", {
  pattern = {"go", "mod"},
  command = "setlocal tabstop=2 softtabstop=2 shiftwidth=2 noexpandtab"
})
vim.opt.smarttab = true -- start tabbed in
vim.opt.backspace = {'start', 'eol', 'indent'} -- always allow backspaces
vim.opt.wildmenu = true -- trick out command mode
vim.opt.incsearch = true -- highlight search pattern as it's typed
vim.opt.ignorecase = true -- searches are case insensitive...
vim.opt.smartcase = true -- ... unless they contain at least one capital letter
vim.opt.wrap = true -- textwrap
-- vim.opt.showmode = false -- set to no show for speed
vim.cmd('hi NonText cterm=NONE ctermfg=NONE')
vim.opt.linebreak = true -- wrap lines at spaces
vim.opt.wrapmargin = 0 -- wrap at last column
vim.opt.autoindent = true
vim.opt.autoread = true -- automatically reads file in
vim.opt.cmdheight = 1
vim.opt.smartindent = true
vim.opt.textwidth = 0 -- disable auto line breaking on paste
vim.opt.number = true -- line numbers

vim.opt.scrolloff = 5 -- 5 line buffer below cursor when scrolling
vim.opt.hlsearch = true -- highlight search results
vim.opt.cursorline = true -- highlight line cursor is on
vim.opt.cursorcolumn = true -- highlight the cursor's current column
vim.cmd('highlight link CursorColumn CursorLine') -- have them always be the same color
vim.opt.clipboard = 'unnamed' -- copy to system register
vim.opt.mouse = 'a' -- turn on all mouse functionality
vim.opt.timeoutlen = 300 -- Time to wait after ESC (default causes an annoying delay)
vim.opt.list = true
vim.opt.listchars = {tab = '⬝➜'}
vim.opt.conceallevel = 0
vim.opt.completeopt = {'menu', 'menuone', 'noselect', 'noinsert'}

-- Normally, Vim messes with iskeyword when you open a shell file. This can
-- leak out, polluting other file types even after a 'set ft=' change. This
-- variable prevents the iskeyword change so it can't hurt anyone.
vim.g.sh_noisk = 1

-- Resize splits when the window is resized
vim.api.nvim_create_autocmd("VimResized", {
  command = "wincmd ="
})

-- Store swap files in a central spot
vim.opt.backup = true
vim.opt.backupdir = {'~/.vim-tmp', '~/.tmp', '~/tmp', '/var/tmp', '/tmp'}
vim.opt.directory = {'~/.vim-tmp', '~/.tmp', '~/tmp', '/var/tmp', '/tmp'}
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.shortmess:append('c')

-- you can undo even when you close a buffer/VIM
vim.cmd([[
try
  set undodir=~/.vim_runtime/temp_dirs/undodir
  set undofile
catch
endtry
]])

-- additional filetype detection
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "*.axlsx",
  command = "set filetype=ruby"
})
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "*.inky",
  command = "set filetype=slim"
})

-- map leader to space
vim.g.mapleader = " "

-- neovim needs to be like vim
vim.api.nvim_set_keymap('n', 'Y', 'Y', {noremap = true})

-- leader mappings
vim.api.nvim_set_keymap('n', '<leader>v', ':vs<space>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>s', ':sp<space>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>t', ':tabe<space>', {noremap = true})

-- buffer navigation
vim.api.nvim_set_keymap('n', '<leader>n', ':bnext<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>b', ':bprevious<CR>', {noremap = true})

-- open github copilot chat
vim.api.nvim_set_keymap('n', '<leader>c', ':CopilotChatOpen<CR>', {noremap = true})

-- Open new splits to the right/bottom
vim.opt.splitright = true
vim.opt.splitbelow = true

-- I want my custom commands!
vim.api.nvim_set_keymap('i', '<C-t>', '<%= %><Left><Left><Left>', {noremap = true})

-- up/down on wrapped lines
vim.api.nvim_set_keymap('n', 'j', 'gj', {noremap = true})
vim.api.nvim_set_keymap('n', 'k', 'gk', {noremap = true})

-- Reselect visual block after indent
vim.api.nvim_set_keymap('v', '<', '<gv', {noremap = true})
vim.api.nvim_set_keymap('v', '>', '>gv', {noremap = true})

-- make . work in visual mode
vim.api.nvim_set_keymap('v', '.', ':norm.<CR>', {noremap = true})

-- clear search highlights with enter
vim.api.nvim_set_keymap('n', '<CR>', ':nohlsearch<CR>/<BS>', {noremap = true})

-- make resizing windows a bit easier
vim.api.nvim_set_keymap('n', '<left>', '<C-w>>', {noremap = true})
vim.api.nvim_set_keymap('n', '<right>', '<C-w><', {noremap = true})
vim.api.nvim_set_keymap('n', '<up>', '<C-w>-', {noremap = true})
vim.api.nvim_set_keymap('n', '<down>', '<C-w>+', {noremap = true})

-- Keep search matches in the middle of the window.
vim.api.nvim_set_keymap('n', 'n', 'nzzzv', {noremap = true})
vim.api.nvim_set_keymap('n', 'N', 'Nzzzv', {noremap = true})

-- Easier to type, and I never use the default behavior.
vim.api.nvim_set_keymap('n', 'H', '^', {noremap = true})
vim.api.nvim_set_keymap('n', 'L', '$', {noremap = true})
vim.api.nvim_set_keymap('v', 'L', 'g_', {noremap = true})

vim.api.nvim_set_keymap('n', '<TAB>', '%', {noremap = true}) -- easier to hit

-- neoformat
vim.g.neoformat_try_node_exe = 1
-- prettier on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = {"*.js", "*.css", "*.vue"},
  command = "Neoformat"
})

-- telescope
vim.api.nvim_set_keymap('n', '<c-f>', '<cmd>Telescope find_files<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<c-a>', '<cmd>Telescope live_grep<cr>', {noremap = true})

-- togglecursor
vim.g.togglecursor_force = 'xterm'
vim.g.togglecursor_default = 'blinking_block'

-- vim-json
vim.g.vim_json_syntax_conceal = 0

-- emmet expansions
vim.g.user_emmet_leader_key = '<c-e>'

-- indentline
-- vim.g.indentLine_setColors = 1
-- vim.g.indentLine_char = '│'
-- vim.g.indentLine_concealcursor = 'nc'

-- conditionally run EnableYtt if file type is yaml without attaching to paste buffer
vim.api.nvim_create_autocmd("FileType", {
  pattern = "yaml",
  command = "EnableYtt"
})

-- Enable true color
if vim.fn.exists('+termguicolors') then
  vim.opt.termguicolors = true
  -- vim.opt.t_8f = "\\<Esc>[38;2;%lu;%lu;%lum"
  -- vim.opt.t_8b = "\\<Esc>[48;2;%lu;%lu;%lum"
end

-- vim ale
vim.g.ale_linters = {
  ruby = {'reek', 'brakeman', 'rails_best_practices'}
}

-- only lint ruby files

-- turn off autocomplete for ale
vim.g.ale_completion_enabled = 0

-- if (!has('nvim') && !has('clipboard_working'))
-- In the event that the clipboard isn't working, it's quite likely that
-- the + and * registers will not be distinct from the unnamed register. In
-- this case, a:event.regname will always be '' (empty string). However, it
-- can be the case that `has('clipboard_working')` is false, yet `+` is
-- still distinct, so we want to check them all.
local VimOSCYankPostRegisters = {'', '+', '*'}
local function VimOSCYankPostCallback(event)
  if event.operator == 'y' and vim.tbl_contains(VimOSCYankPostRegisters, event.regname) then
    vim.fn.OSCYankRegister(event.regname)
  end
end
vim.api.nvim_create_augroup('VimOSCYankPost', {clear = true})
vim.api.nvim_create_autocmd('TextYankPost', {
  group = 'VimOSCYankPost',
  callback = function(event)
    VimOSCYankPostCallback(event)
  end
})

-- lsp custom diagnostics symbols
local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

require('lualine').setup{
  theme = "catppuccin",
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

vim.api.nvim_set_keymap('n', '<C-d>', ':DiffviewOpen<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-g>', ':Neogit<CR>', {noremap = true, silent = true})

vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', {desc = "Toggle Spectre"})
