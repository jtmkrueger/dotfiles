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


-- map leader to space
vim.g.mapleader = " "

local opts = { noremap=true, silent=true }

local function quickfix()
  vim.lsp.buf.code_action({
    filter = function(a) return a.isPreferred end,
    apply = true
  })
end
vim.keymap.set('n', '<leader>qf', quickfix, opts) -- apply preferred code action
-- background/flavour are set by apply_appearance() in the catppuccin config below

-- Setup lazy.nvim
require("lazy").setup({
  {
    "rmagatti/goto-preview",
    dependencies = { "rmagatti/logger.nvim" },
    -- load on first keypress instead of BufEnter so startup stays fast
    keys = { "gp", "gr" },
    config = function()
      require('goto-preview').setup({})

      vim.keymap.set(
        "n",
        "gp",
        "<cmd>lua require('goto-preview').goto_preview_definition()<CR>",
        { noremap = true }
      )
      vim.keymap.set(
        "n",
        "gr",
        "<cmd>lua require('goto-preview').goto_preview_references()<CR>",
        { noremap = true }
      )
    end,
  },
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
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
    keys = {
      { "<leader>cc", "<cmd>CodeCompanionChat Toggle<CR>", mode = { "n", "v" }, desc = "CodeCompanion chat" },
      { "<leader>ca", "<cmd>CodeCompanionActions<CR>", mode = { "n", "v" }, desc = "CodeCompanion actions" },
    },
    config = function()
      require("codecompanion").setup({
        -- Local llama.cpp server (`llama serve`) as an OpenAI-compatible backend.
        -- Start it first: ~/Code/claude-scripts/llama serve  (or `llama ensure`)
        -- Custom HTTP adapters must live under adapters.http.<name> (v19+ API).
        -- All point at the same local server (:8080); the `model` field is the
        -- HF ref of the model you've loaded via `llama serve`. llama.cpp serves
        -- whatever is loaded, so the practical switch is which model you serve —
        -- but matching names keeps /adapter selection honest.
        -- Helper to build an openai_compatible adapter for a given model ref.
        adapters = {
          http = {
            -- DEFAULT chat: Qwen3-Coder-30B. Clean stops, just answers (Devstral
            -- mis-behaves in plain chat: it write-and-waits for tools and leaked
            -- <|im_end|> under the chatml workaround — so it's NOT the chat default).
            llama_chat = function()
              return require("codecompanion.adapters").extend("openai_compatible", {
                env = {
                  url = "http://localhost:8080",
                  api_key = "sk-no-key-required",
                  chat_url = "/v1/chat/completions",
                },
                schema = { model = { default = "unsloth/Qwen3-Coder-30B-A3B-Instruct-GGUF:UD-Q4_K_XL" } },
              })
            end,
            -- Fast/light chat (7B) — snappy Q&A when you don't need the 30B.
            llama_fast = function()
              return require("codecompanion.adapters").extend("openai_compatible", {
                env = {
                  url = "http://localhost:8080",
                  api_key = "sk-no-key-required",
                  chat_url = "/v1/chat/completions",
                },
                schema = { model = { default = "bartowski/Qwen2.5-Coder-7B-Instruct-GGUF:Q4_K_M" } },
              })
            end,
            -- Agentic coder (Devstral) — only useful WITH tool execution (agent
            -- mode / Aider), not plain chat. Serve it via `llama serve` first.
            llama_agentic = function()
              return require("codecompanion.adapters").extend("openai_compatible", {
                env = {
                  url = "http://localhost:8080",
                  api_key = "sk-no-key-required",
                  chat_url = "/v1/chat/completions",
                },
                schema = { model = { default = "unsloth/Devstral-Small-2-24B-Instruct-2512-GGUF:Q5_K_M" } },
              })
            end,
          },
        },
        strategies = {
          chat = { adapter = "llama_chat" },
          inline = { adapter = "llama_chat" },
        },
        -- Load project conventions (gitignored AIRULES.md) into chat context when present.
        prompt_library = {
          ["EHS conventions"] = {
            strategy = "chat",
            description = "Open a chat preloaded with the repo's AIRULES.md conventions",
            prompts = {
              {
                role = "system",
                content = function()
                  local f = vim.fn.getcwd() .. "/AIRULES.md"
                  if vim.fn.filereadable(f) == 1 then
                    return "Follow these project conventions:\n\n" .. table.concat(vim.fn.readfile(f), "\n")
                  end
                  return "You are a careful Ruby/Rails pair programmer. Match the surrounding code."
                end,
              },
            },
          },
        },
      })
    end,
  },
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
  'MunifTanjim/nui.nvim',
  -- main branch: full rewrite, required for Neovim 0.12 (master is archived).
  -- Requires the `tree-sitter` CLI on PATH (brew install tree-sitter-cli) to
  -- compile parsers. Does not support lazy-loading; setup lives below.
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate"
  },
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
        path_display = { "smart" },
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
          "--glob=!.git/", -- Exclude .git directory
          "--glob=!docs/",
          "--glob=!.beads/",
        },
      },
      pickers = {
        find_files = {
          hidden = true, -- Show hidden files
        },
        live_grep = {
          additional_args = function()
            return { "--hidden", "--glob=!.git/", "--glob=!docs/", "--glob=!.beads/" }
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

      vim.keymap.set('n', '<c-f>', '<cmd>Telescope find_files<cr>')
      vim.keymap.set('n', '<c-a>', '<cmd>Telescope live_grep<cr>')
      vim.keymap.set('n', '<c-t>', '<cmd>Telescope resume<cr>', { desc = 'Telescope resume' })
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
                      icon = lspkind.symbol_map[ctx.kind] or icon
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
        default = { 'lsp', 'path', 'buffer' },
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
        jsonls = {},
        yamlls = {},
        lua_ls = {},
        herb_ls = {
          settings = {
            languageServerHerb = {
              linter = { enabled = true },
              formatter = { enabled = false },
            },
          },
          on_attach = function(client, _bufnr)
            -- Keep the autoformatting off. If a repo specifically
            -- has it turned on it the .yml file it'll override this
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end,
        },
      },
    },
    config = function(_, opts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover)

      -- Get base capabilities and disable semantic tokens
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      capabilities.textDocument.semanticTokens = nil

      -- Apply capabilities to every server via the wildcard config
      vim.lsp.config('*', { capabilities = capabilities })

      -- Register per-server configs (mason-lspconfig will enable installed ones)
      for server_name, server_opts in pairs(opts.servers) do
        vim.lsp.config(server_name, server_opts)
      end

      -- Setup Mason
      require('mason').setup()
      require('mason-lspconfig').setup({
        ensure_installed = vim.tbl_keys(opts.servers),
        -- Exclude ruby_lsp from automatic setup (managed manually below)
        automatic_enable = {
          exclude = { "ruby_lsp" }
        }
      })

      -- Walk up from the buffer's directory to find a Ruby project root
      -- (directory containing a Gemfile). Returns the dir or nil.
      local function find_ruby_root(bufnr)
        local start = vim.api.nvim_buf_get_name(bufnr)
        if start == "" then start = vim.fn.getcwd() end
        local found = vim.fs.find({ "Gemfile" }, { upward = true, path = start })[1]
        return found and vim.fs.dirname(found) or nil
      end

      -- Configure ruby_lsp with per-buffer root + env. Solves three things:
      --   1. Subdir launches: walk up from the buffer to find Gemfile.
      --   2. Gem activation conflicts (standard vs rubocop, etc.): launch
      --      via `bundle exec` so ruby-lsp resolves against the project's
      --      Gemfile.lock, not the global gemset.
      --   3. Per-project Gemfile.local: when present, scope BUNDLE_GEMFILE
      --      to the spawned ruby-lsp process only via the cmd-fn's env —
      --      does NOT mutate nvim's own env, so :terminal / :! and other
      --      LSPs are unaffected. See rubyup in ~/.zshrc for the shell-
      --      side pattern.
      vim.lsp.config('ruby_lsp', {
        cmd = function(dispatchers, config)
          local root = config.root_dir or vim.fn.getcwd()
          local env = {}
          local local_gemfile = root .. "/Gemfile.local"
          if vim.uv.fs_stat(local_gemfile) then
            env.BUNDLE_GEMFILE = local_gemfile
          end
          -- Ruby LSP has no server-side version-manager option; that lives in
          -- the VS Code extension (rubyVersionManager). For other editors the
          -- docs say to launch via a shell command that activates the right
          -- Ruby (the "custom" / customRubyCommand pattern):
          --   https://shopify.github.io/ruby-lsp/version-managers.html
          -- chruby is a shell function (not on PATH), and nvim's LSP child
          -- never sources it — so a bare `bundle exec` inherits whatever Ruby
          -- launched nvim (manifested here as RubyVersionMismatch: Ruby 3.4.1
          -- + gems from 3.2.2 vs a Gemfile pinned to 3.2.10). Mirror chruby's
          -- documented activation: source chruby.sh, then `chruby` against the
          -- project's .ruby-version, then exec the server. Scoped to this
          -- spawned process only — nvim's own env, :terminal, :! and other
          -- LSPs are untouched. We call chruby explicitly rather than auto.sh
          -- because auto.sh hooks chpwd, which does not fire for a
          -- non-interactive shell's starting directory.
          return vim.lsp.rpc.start(
            {
              "/bin/zsh", "-c",
              "source /opt/homebrew/share/chruby/chruby.sh && "
                .. 'chruby "$(cat .ruby-version)" && '
                .. "exec bundle exec ruby-lsp",
            },
            dispatchers,
            { cwd = root, env = env }
          )
        end,
        root_dir = function(bufnr, on_dir)
          local root = find_ruby_root(bufnr)
          if root then on_dir(root) end
        end,
        init_options = {
          formatter = 'standardrb',
          linters = { 'standardrb' },
          addonSettings = {
            ["Ruby LSP Rails"] = {
              enablePendingMigrationsPrompt = false,
            },
          },
        },
      })
      vim.lsp.enable('ruby_lsp')
    end,
  },
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
    dependencies = { "nvim-tree/nvim-web-devicons" },
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
          index = {           -- staged changes
            ["!"] = "",         -- ignored
            ["?"] = "",         -- untracked
            ["A"] = "",         -- added
            ["C"] = "",         -- copied
            ["D"] = "",         -- deleted
            ["M"] = "",         -- modified
            ["R"] = "",         -- renamed
            ["T"] = "",         -- type changed
            ["U"] = "",         -- unmerged
            [" "] = " ",           -- unmodified
          },
          working_tree = {    -- unstaged changes
            ["!"] = "",         -- ignored
            ["?"] = "",         -- untracked
            ["A"] = "",         -- added
            ["C"] = "",         -- copied
            ["D"] = "",         -- deleted
            ["M"] = "",         -- modified
            ["R"] = "",         -- renamed
            ["T"] = "",         -- type changed
            ["U"] = "",         -- unmerged
            [" "] = " ",           -- unmodified
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
      local function is_dark()
        return vim.fn.system("defaults read -g AppleInterfaceStyle 2>/dev/null"):find("Dark") ~= nil
      end

      local function apply_appearance()
        local dark = is_dark()
        vim.o.background = dark and "dark" or "light"
        vim.g.catppuccin_flavour = dark and "mocha" or "latte"
        require("catppuccin").setup({
          transparent_background = true,
          dim_inactive = {
            enabled = true, -- dims the background color of inactive window
            shade = "dark",
            percentage = 0.01, -- percentage of the shade to apply to the inactive window
          },
          highlight_overrides = {
            all = function(colors)
              return {
                -- inactive-window bg: pure black in dark, Latte crust in light
                NormalNC = { bg = dark and "#000000" or "#dce0e8" },
                -- visible line numbers with tmux pane dimming
                LineNr = { fg = colors.overlay1 },
                -- cursorline/cursorcolumn: surface0 per flavour so they are
                -- visible in BOTH themes (were too dark in Latte). CursorColumn
                -- is `highlight link`ed to CursorLine elsewhere, so this covers both.
                CursorLine = { bg = dark and "#313244" or "#ccd0da" },
              }
            end,
          },
        })
        vim.cmd.colorscheme("catppuccin")
      end

      -- expose for the SIGUSR1 autocmd (see below)
      _G.apply_appearance = apply_appearance

      apply_appearance()

      -- Live re-detect when the iTerm2 AutoLaunch script signals a theme change.
      vim.api.nvim_create_autocmd("Signal", {
        pattern = "SIGUSR1",
        callback = function() _G.apply_appearance() end,
      })
    end,
  },
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
vim.opt.updatetime = 1000 -- fire CursorHold ~1s after idle (drives auto-reload checks; also LSP/gitsigns)
vim.opt.cmdheight = 1

-- Auto-reload buffers changed on disk (git checkout/pull, AI agents, formatters).
--
-- autoread does the actual reload, but only when Neovim *checks* the file's
-- mtime — it does not poll. So we force a :checktime on the events below.
-- CursorHold(+I) covers the "agent rewrites the file while I sit idle in it"
-- case (within ~updatetime); FocusGained/BufEnter cover returning from a tmux
-- pane after a git op. focus-events are already on in ~/.tmux.conf.
--
-- On reload we stamp the buffer so a transient lualine marker (see the
-- ts_reloaded component below) blinks for ~2.5s, then a one-shot uv timer
-- nudges a statusline redraw so the marker clears itself even while idle.
local reload_grp = vim.api.nvim_create_augroup("auto_reload", { clear = true })
local RELOAD_BLINK_MS = 2500

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  group = reload_grp,
  callback = function()
    -- only real, named, listed file buffers — skip terminals/prompts/etc.
    if vim.bo.buftype == "" then
      vim.cmd("checktime")
    end
  end,
})

vim.api.nvim_create_autocmd("FileChangedShellPost", {
  group = reload_grp,
  callback = function(args)
    -- per-buffer stamp: monotonic ms when this buffer reloaded
    vim.b[args.buf].reloaded_at = vim.uv.now()
    vim.cmd("redrawstatus")
    -- clear the blink even if the user never touches the keyboard
    local timer = vim.uv.new_timer()
    timer:start(RELOAD_BLINK_MS + 50, 0, vim.schedule_wrap(function()
      timer:stop()
      timer:close()
      if vim.api.nvim_buf_is_valid(args.buf) then
        vim.cmd("redrawstatus")
      end
    end))
  end,
})

-- lualine component: show 󱄋 briefly when the *current* buffer just reloaded.
function _G.ts_reloaded()
  local at = vim.b.reloaded_at
  if at and (vim.uv.now() - at) < RELOAD_BLINK_MS then
    return "󱄋 "
  end
  return ""
end
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

-- neovim needs to be like vim
vim.keymap.set('n', 'Y', 'Y')

-- leader mappings
vim.keymap.set('n', '<leader>v', ':vs<space>')
vim.keymap.set('n', '<leader>s', ':sp<space>')
vim.keymap.set('n', '<leader>t', ':tabe<space>')

-- buffer navigation
vim.keymap.set('n', '<leader>n', ':bnext<CR>')
vim.keymap.set('n', '<leader>b', ':bprevious<CR>')

-- so oil behaves like vim.vinegar did
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Open new splits to the right/bottom
vim.opt.splitright = true
vim.opt.splitbelow = true

-- I want my custom commands!
vim.keymap.set('i', '<C-t>', '<%= %><Left><Left><Left>')

-- up/down on wrapped lines
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')
vim.keymap.set('x', 'j', 'gj')
vim.keymap.set('x', 'k', 'gk')

-- Reselect visual block after indent
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- make . work in visual mode
vim.keymap.set('v', '.', ':norm.<CR>')

-- clear search highlights with enter
vim.keymap.set('n', '<CR>', ':nohlsearch<CR>/<BS>')

-- make resizing windows a bit easier
vim.keymap.set('n', '<left>', '<C-w>>')
vim.keymap.set('n', '<right>', '<C-w><')
vim.keymap.set('n', '<up>', '<C-w>-')
vim.keymap.set('n', '<down>', '<C-w>+')

-- Keep search matches in the middle of the window.
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Easier to type, and I never use the default behavior.
vim.keymap.set('n', 'H', '^')
vim.keymap.set('n', 'L', '$')
vim.keymap.set('x', 'L', 'g_')
vim.keymap.set('x', 'H', '^')

vim.keymap.set('n', '<TAB>', '%') -- easier to hit

-- neoformat
vim.g.neoformat_try_node_exe = 1
vim.opt.exrc = true -- enable per-project config via .nvim.lua
-- prettier on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = {"*.js", "*.css", "*.vue"},
  callback = function()
    if vim.g.neoformat_enabled == false then return end
    vim.cmd("Neoformat")
  end,
})

-- togglecursor
vim.g.togglecursor_force = 'xterm'
vim.g.togglecursor_default = 'blinking_block'

-- vim-json
vim.g.vim_json_syntax_conceal = 0

-- emmet expansions
-- vim.g.user_emmet_leader_key = '<c-e>'

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
  callback = function()
    VimOSCYankPostCallback(vim.v.event)
  end
})


vim.diagnostic.config({
  virtual_text = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
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
    lualine_z = {}
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
      lualine_x = {
        -- pass the function directly (lua_fun component); a string name would be
        -- treated as a module/expr and render the function address literally.
        { _G.ts_reloaded, color = { fg = '#f9e2af', gui = 'bold' } }, -- transient reload blink
        'filetype',
      },
      lualine_y = {{
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        sections = { 'error', 'warn', 'info', 'hint' },
        symbols = {error = '󰅚 ', warn = '󰀪 ', info = ' ', hint = '󰌶 '},
        always_visible = false,
      }},
      -- lualine fills any unset section with its default (lualine_z defaults to
      -- {'location'}); set unused sections empty explicitly to keep location off.
      lualine_z = {},
    },
    inactive_sections = {
      lualine_c = {{'filename', path = 1}, { 'diff', colored = false}},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
  }

  require("bufferline").setup{
    options = {
      mode = "tabs",
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

-- nvim-treesitter (main branch) setup.
--
-- The main branch is a full rewrite: it only installs parsers + ships queries.
-- Highlighting/indentation are core Neovim features we opt into ourselves,
-- rather than module flags on a configs.setup{} call (that API is gone).
local hasTS, ts = pcall(require, "nvim-treesitter")
if hasTS then
  ts.setup({})

  -- Curated parser list covering the filetypes this config targets. (master's
  -- ensure_installed = "all" is discouraged on main — slow and compiles
  -- grammars you never open.) install() is async and a no-op for parsers
  -- already present, so it's cheap to run on every startup.
  ts.install({
    "ruby", "javascript", "typescript", "tsx",
    "json", "yaml", "lua", "go", "elixir",
    "markdown", "markdown_inline", "html",
    "css", "scss", "bash", "vim", "vimdoc",
    "graphql", "dockerfile", "sql",
  })

  -- Enable treesitter highlighting (and experimental indent) per buffer.
  -- pcall guards filetypes whose parser isn't installed yet so we don't
  -- error during the async install on first launch.
  -- Filetypes that have a tree-sitter parser but no bundled highlight queries,
  -- so starting treesitter would attach an empty highlighter and shadow the
  -- built-in Vim syntax file. tmux ships syntax/tmux.vim in core Neovim but no
  -- queries/tmux/highlights.scm, so let the Vim syntax handle it instead.
  local ts_skip_highlight = { tmux = true }

  local function ts_attach(buf)
    if not vim.api.nvim_buf_is_valid(buf) or vim.bo[buf].buftype ~= "" then return end
    if ts_skip_highlight[vim.bo[buf].filetype] then return end
    local ok = pcall(vim.treesitter.start, buf)
    if ok then
      vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end

  vim.api.nvim_create_autocmd("FileType", {
    callback = function(args) ts_attach(args.buf) end,
  })

  -- This config block runs after startup, so the FileType event for any file
  -- opened on the command line has already fired and won't be caught above.
  -- Retroactively attach to buffers that are already loaded.
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) then
      ts_attach(buf)
    end
  end
end

-- this is for easy note taking
vim.api.nvim_create_user_command('NN', function()
  local timestamp = os.date('%Y%m%d-%H%M%S')
  local bufferDir = vim.fn.expand('%:p:h')
  local filename = vim.fn.input('Enter file name: ', timestamp .. '-')
  local fullPath = bufferDir .. '/' .. filename .. '.md'
  vim.api.nvim_command('edit ' .. fullPath)
end, {})

local function on_list(options)
  vim.fn.setqflist({}, ' ', options)
  vim.cmd.cfirst()
end
-- alias gd to find definition of word under cursor in normal mode
vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition({ on_list = on_list }) end, {silent = true})

-- indentation
require("ibl").setup({
  indent = { char = "│" },
})

vim.keymap.set('n', '<C-g>', ':Neogit<CR>', {silent = true})

vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', {desc = "Toggle Spectre"})
