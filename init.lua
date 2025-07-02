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
  { 'glacambre/firenvim', build = ":call firenvim#install(0)" },


  -- tools
  {
    "mfussenegger/nvim-lint",
    config = function()
      local parser = function(output, bufnr)
        if not output or output == '' then
          return {}
        end

        local ok, decoded = pcall(vim.json.decode, output)
        if not ok or not decoded or not decoded.warnings then
          vim.notify("Failed to parse Brakeman output", vim.log.levels.ERROR)
          return {}
        end

        local diagnostics = {}
        local file_path = vim.api.nvim_buf_get_name(bufnr)
        local rel_file = vim.fn.fnamemodify(file_path, ':.')

        for _, warning in ipairs(decoded.warnings) do

          local normalized_rel_file = vim.fs.normalize(rel_file or "")
          local normalized_warning_file = vim.fs.normalize(warning.file or "")

          if normalized_rel_file:sub(-#normalized_warning_file) == normalized_warning_file then
            table.insert(diagnostics, {
              lnum = (warning.line or 1) - 1,
              col = 0,
              end_lnum = (warning.line or 1) - 1,
              end_col = 1000,
              severity = vim.diagnostic.severity.WARN,
              message = warning.message .. " [" .. warning.confidence .. "]",
              source = "brakeman",
            })
          end
        end

        return diagnostics
      end

      require("lint").linters.brakeman = {
        cmd = "brakeman",
        stdin = false,
        append_fname = false,
        args = {
          "--format", "json",
          "--quiet",
          "--no-pager",
          "-p", vim.fn.getcwd(),
        },
        stream = "stdout",
        ignore_exitcode = true,
        parser = parser,
      }

      require("lint").linters_by_ft = {
        ruby = { "brakeman" },
      }
      vim.api.nvim_create_user_command("BrakemanLint", function()
        require("lint").try_lint("brakeman")
      end, {})

      -- Enable virtual text and run on save
      vim.diagnostic.config({ virtual_text = true })
      vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
        callback = function()
          local ft = vim.bo.filetype
          require("lint").try_lint() -- uses linters_by_ft[ft]

          -- run Brakeman only on Ruby files
          if ft == "ruby" then
            require("lint").try_lint("brakeman")
          end
        end,
      })
    end,
  },
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
  'jidn/vim-dbml',
  {
    "olimorris/codecompanion.nvim",
    opts = {},
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      'echasnovski/mini.diff',
    },
    config = function()
      require("codecompanion").setup({
        display = {
          diff = {
            provider = "mini_diff",
          },
        },
        strategies = {
          chat = {
            adapter = "anthropic",
            system_message = [[
You are M.I.N.S.W.A.N., a friendly software engineer specializing in Ruby, Ruby on Rails, JavaScript, Vite, VueJS, Bash, and Docker. You respond succinctly and accurately, using proper jargon with experts, but clearly with beginners. Your tone is direct but warm. Avoid non-programming topics, legal advice, and unreleased tech. Ruby code should follow `standard` formatting (standrb). You provide clarification for ambiguous questions and balance professionalism with kindness.
]],
          },
          inline = {
            adapter = "anthropic",
            system_message = [[
You are M.I.N.S.W.A.N., a friendly software engineer specializing in Ruby, Ruby on Rails, JavaScript, Vite, VueJS, Bash, and Docker. You respond succinctly and accurately, using proper jargon with experts, but clearly with beginners. Your tone is direct but warm. Avoid non-programming topics, legal advice, and unreleased tech. Ruby code should follow `standard` formatting (standrb). You provide clarification for ambiguous questions and balance professionalism with kindness.
]],
          },
        },
        adapters = {
          openai = function()
            return require("codecompanion.adapters").extend("anthropic", {
              env = {
                api_key = "ANTHROPIC_API_KEY",
              },
              schema = {
                model = {
                default = "claude-sonnet",
                },
              },
            })
          end,
        },
      })
    end
  },
  -- {
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   event = "InsertEnter",
  --   config = function()
  --     require("copilot").setup({
  --       suggestion = {
  --         auto_trigger = true,
  --         keymap = {
  --           accept = "<C-j>",
  --         },
  --       }
  --     })
  --   end,
  -- },
  -- "giuxtaposition/blink-cmp-copilot",
  -- {
  --   'CopilotC-Nvim/CopilotChat.nvim',
  --   branch = 'main',
  --   dependencies = {
  --     { "zbirenbaum/copilot.lua", },
  --     { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
  --   },
  --   build = "make tiktoken", -- Only on MacOS or Linux
  --   config = function ()
  --     require("CopilotChat").setup {
  --       debug = true, -- Enable debugging
  --       show_help = false,
  --       model = 'gpt-4.1',
  --     }
  --   end
  -- },
  'MunifTanjim/nui.nvim',
  {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'princejoogie/dir-telescope.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    opts = {
      defaults = {
        prompt_prefix = "> ",
        selection_caret = ">> ",
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = { preview_width = 0.6 },
        },
        mappings = {
          i = {
          },
        },
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden", -- Include hidden files
          "--glob=!.git/" -- Exclude .git directory
        },
      },
      pickers = {
        find_files = {
          hidden = true, -- Show hidden files
        },
        live_grep = {
          additional_args = function()
            return { "--hidden", "--glob=!.git/" } -- Include hidden files, exclude .git
          end,
        },
      },
      extensions = {
        fzf = {
          fuzzy = true, -- Enable fuzzy matching
          override_generic_sorter = true, -- Override the generic sorter
          override_file_sorter = true, -- Override the file sorter
          case_mode = "smart_case", -- Use smart case matching
        },
      },
    },
    config = function(_, opts)
      local telescope = require('telescope')
      telescope.setup(opts)

      -- Load extensions
      telescope.load_extension('fzf')

      -- Custom key mappings
      local builtin = require('telescope.builtin')
      vim.api.nvim_set_keymap('n', '<c-f>', '<cmd>Telescope find_files<cr>', {noremap = true})
      vim.api.nvim_set_keymap('n', '<c-a>', '<cmd>Telescope live_grep<cr>', {noremap = true})
      -- vim.keymap.set("n", "<c-A>", "<cmd>Telescope dir live_grep<CR>", { noremap = true, silent = true })
    end,
  },
  'nvim-tree/nvim-web-devicons',
  'nvim-lualine/lualine.nvim',
  {'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons'},
  'lewis6991/gitsigns.nvim',
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim", -- optional
    },
    config = true
  },
  {
    'saghen/blink.cmp',
    -- use a release tag to download pre-built binaries
    version = '1.*',
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        -- set to 'none' to disable the 'default' preset
        preset = 'default',

        ['<Tab>'] = { 'select_next', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'fallback' },
      },
      cmdline = {
        keymap = { preset = 'inherit' },
        completion = { menu = { auto_show = true } },
      },
      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono'
      },

      completion = {
        -- Don't select by default, auto insert on selection
        list = { selection = { preselect = false, auto_insert = true } },
        documentation = { auto_show = true },
        menu = {
          draw = {
            components = {
              kind_icon = {
                text = function(ctx)
                  local lspkind = require("lspkind")
                  local icon = ctx.kind_icon
                  if vim.tbl_contains({ "Path" }, ctx.source_name) then
                      local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                      if dev_icon then
                          icon = dev_icon
                      end
                  else
                      icon = require("lspkind").symbolic(ctx.kind, {
                          mode = "symbol",
                      })
                  end

                  return icon .. ctx.icon_gap
                end,

                highlight = function(ctx)
                  local hl = ctx.kind_hl
                  if vim.tbl_contains({ "Path" }, ctx.source_name) then
                    local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                    if dev_icon then
                      hl = dev_hl
                    end
                  end
                  return hl
                end,
              }
            }
          }
        }
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer', 'codecompanion' },
        providers = {
          path = {
            opts = {
              get_cwd = function(_)
                return vim.fn.getcwd()
              end,
            },
          },
        },
      },

      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'saghen/blink.cmp',
    },
    opts = {
      servers = {
        ts_ls = {},
        volar = {},
        jsonls = {},
        yamlls = {},

        ruby_lsp = {
          cmd = { "bundle", "exec", "ruby-lsp" },
          filetypes = { "ruby", "eruby" },
          init_options = {
            formatter = 'standard',
            linters = { 'standard' },
            ["ruby-lsp-rails"] = {
              enablePendingMigrationsPrompt = false
            }
          },
        },
      },
    },
    config = function(_, opts)
      local lspconfig = require('lspconfig')
      local configs = require('lspconfig.configs')
      local util = require('lspconfig.util')

      vim.keymap.set('n', 'K', vim.lsp.buf.hover)

      local root_pattern = util.root_pattern('.git')

      -- Setup Mason
      require('mason').setup()
      require('mason-lspconfig').setup({
        ensure_installed = vim.tbl_keys(opts.servers),
      })

      require('mason-lspconfig').setup_handlers({
        function(server_name)
          local server_opts = opts.servers[server_name] or {}
          server_opts.capabilities = require('blink.cmp').get_lsp_capabilities(server_opts.capabilities)
          lspconfig[server_name].setup(server_opts)
        end,
      })
    end,
  },
  -- 'zbirenbaum/copilot-cmp',
  'onsails/lspkind.nvim',

  -- all that tpope!
  'tpope/vim-repeat',
  'tpope/vim-surround',
  'tpope/vim-commentary',
  'tpope/vim-endwise',
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,

    config = function(_, opts)
      require("oil").setup({
        view_options = {
          show_hidden = true,
        },
        win_options = {
          signcolumn = "yes:2",
        },
      })
    end
  },
  {
    "refractalize/oil-git-status.nvim",

    dependencies = {
      "stevearc/oil.nvim",
    },

    config = function(_, opts)
      require('oil-git-status').setup({
        show_ignored = true, -- show files that match gitignore with !!
        symbols = {
          index = {
            ["!"] = "",
            ["?"] = "",
            ["A"] = "",
            ["C"] = "",
            ["D"] = "",
            ["M"] = "",
            ["R"] = "",
            ["T"] = "",
            ["U"] = "",
            [" "] = " ",
          },
          working_tree = {
            ["!"] = "",
            ["?"] = "",
            ["A"] = "",
            ["C"] = "",
            ["D"] = "",
            ["M"] = "",
            ["R"] = "",
            ["T"] = "",
            ["U"] = "",
            [" "] = " ",
          },
        },
      })
    end
  },
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
        highlight_overrides = {
          all = function(colors)
            return {
              -- visible line numbers with tmux pane dimming
              LineNr = { fg = colors.overlay1 },
            }
          end,
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
if vim.g.started_by_firenvim == true then
  vim.opt.showtabline = 0
else
  vim.opt.showtabline = 2 -- always show tabs
end

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

-- open codecompanion menu
vim.keymap.set({'n', 'v'}, '<leader>c', ':CodeCompanionActions<CR>', {noremap = true})

-- so oil behaves like vim.vinegar did
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Open new splits to the right/bottom
vim.opt.splitright = true
vim.opt.splitbelow = true

-- I want my custom commands!
vim.api.nvim_set_keymap('i', '<C-t>', '<%= %><Left><Left><Left>', {noremap = true})

-- up/down on wrapped lines
vim.api.nvim_set_keymap('n', 'j', 'gj', {noremap = true})
vim.api.nvim_set_keymap('n', 'k', 'gk', {noremap = true})
vim.api.nvim_set_keymap('x', 'j', 'gj', {noremap = true})
vim.api.nvim_set_keymap('x', 'k', 'gk', {noremap = true})

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
vim.api.nvim_set_keymap('x', 'L', 'g_', {noremap = true})
vim.api.nvim_set_keymap('x', 'H', '^', {noremap = true})

vim.api.nvim_set_keymap('n', '<TAB>', '%', {noremap = true}) -- easier to hit

-- neoformat
vim.g.neoformat_try_node_exe = 1
-- prettier on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = {"*.js", "*.css", "*.vue"},
  command = "Neoformat"
})

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


vim.diagnostic.config({
	virtual_text = true, -- show virtual text
	signs = true,        -- enable signs
	underline = true,    -- underline diagnostics
	update_in_insert = false,
	severity_sort = true,
})

-- lsp custom diagnostics symbols
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "󰋼",
      [vim.diagnostic.severity.HINT] = "󰌵",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "",
    },
  },
})

if vim.g.started_by_firenvim == true then
  vim.opt.showtabline = 0 -- Hide the built-in tabline
  vim.g.loaded_bufferline = 1 -- Prevents plugin from loading
  
  require('lualine').setup{
  sections = {
    lualine_a = {'mode'},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {'location'}
  },
  }
else
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
end

require('gitsigns').setup {
  current_line_blame = true,
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

-- local cmp = require'cmp'
-- cmp.setup({
--   snippet = {
--     expand = function(args)
--       vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
--     end,
--   },
--   completion = {
--     completeopt = table.concat(vim.opt.completeopt:get(), ","),
--   },
--   window = {
--     -- completion = cmp.config.window.bordered(),
--     -- documentation = cmp.config.window.bordered(),
--   },
--   mapping = cmp.mapping.preset.insert({
--     ["<Tab>"] = cmp.mapping.select_next_item({behavior=cmp.SelectBehavior.Insert}),
--     ["<S-Tab>"] = cmp.mapping.select_prev_item({behavior=cmp.SelectBehavior.Insert}),
--   }),
--   formatting = {
--     format = function(entry, vim_item)
--       if vim.tbl_contains({ 'path' }, entry.source.name) then
--         local icon, hl_group = require('nvim-web-devicons').get_icon(entry:get_completion_item().label)
--         if icon then
--           vim_item.kind = icon
--           vim_item.kind_hl_group = hl_group
--           return vim_item
--         end
--       end
--       return require('lspkind').cmp_format({ with_text = false })(entry, vim_item)
--     end
--   },
--   sources = cmp.config.sources({
--     { name = 'nvim_lsp' },
--   }, {
--     { name = 'buffer' },
--   })
-- })

-- alias gd to find definition of word under cursor in normal mode
function PeekDefinition()
  local params = vim.lsp.util.make_position_params(0, "utf-16")
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

vim.api.nvim_set_keymap('n', '<C-g>', ':Neogit<CR>', {noremap = true, silent = true})

vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', {desc = "Toggle Spectre"})
