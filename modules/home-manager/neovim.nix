{
  inputs,
  nixvim,
  pkgs,
  ...
}: let
  nvim = nixvim.legacyPackages.${pkgs.system}.makeNixvim {
    colorschemes.gruvbox = {
      enable = true;
      settings = {
        contrast = "medium";
        transparent_mode = false;
      };
    };

    opts = {
      confirm = true;
      number = true;
      relativenumber = true;

      shiftwidth = 2;
      shiftround = true;
      tabstop = 2;
      splitright = true;
      expandtab = true;
      wrap = false;

      hidden = true;
      ignorecase = true;
      smartcase = true;
      incsearch = true;
      hlsearch = true;
      scrolloff = 8;
      sidescrolloff = 8;
      cmdheight = 1;
      updatetime = 300;
      timeoutlen = 500;

      # System clipboard integration
      clipboard = "unnamedplus";
    };

    plugins = {
      web-devicons.enable = true;
      lualine.enable = true;
      fzf-lua.enable = true;
      neo-tree.enable = true;
      noice.enable = true;
      gitsigns.enable = true;
      nvim-surround.enable = true;
      neoconf.enable = true;
      blink-cmp-copilot.enable = true;

      # project.nvim with projectile-like management
      project-nvim = {
        enable = true;
        enableTelescope = false;  # Using fzf-lua instead
        settings = {
          manual_mode = false;
          detection_methods = [ "lsp" "pattern" ];
          patterns = [ ".git" "_darcs" ".hg" ".bzr" ".svn" "Makefile" "package.json" "Cargo.toml" "flake.nix" "pyproject.toml" ];
          ignore_lsp = [];
          exclude_dirs = [ "~/.cargo/*" "*/node_modules/*" ];
          show_hidden = false;
          silent_chdir = true;
          scope_chdir = "global";
          datapath = "~/.local/share/nvim";
        };
      };

      # neogit with magit-like interface
      neogit = {
        enable = true;
        settings = {
          disable_hint = false;
          disable_context_highlighting = false;
          disable_signs = false;
          graph_style = "ascii";
          git_services = {
            "github.com" = "https://github.com/\${owner}/\${repository}/compare/\${branch_name}?\${upstream_url}";
            "bitbucket.org" = "https://bitbucket.org/\${owner}/\${repository}/branches/compare/\${branch_name}%0D\${upstream_url}";
            "gitlab.com" = "https://gitlab.com/\${owner}/\${repository}/-/merge_requests/new?\${branch_name}?\${upstream_url}";
          };
          use_per_project_settings = true;
          remember_settings = false;
          fetch_after_checkout = false;
          sort_branches = "-committerdate";
          kind = "tab";
          status = {
            recent_commit_count = 10;
          };
          commit_editor = {
            kind = "tab";
          };
          commit_select_view = {
            kind = "tab";
          };
          commit_view = {
            kind = "vsplit";
            verify_commit = true;
          };
          log_view = {
            kind = "tab";
          };
          rebase_editor = {
            kind = "auto";
          };
          reflog_view = {
            kind = "tab";
          };
          merge_editor = {
            kind = "auto";
          };
          tag_editor = {
            kind = "auto";
          };
          preview_buffer = {
            kind = "split";
          };
          popup = {
            kind = "split";
          };
          signs = {
            hunk = ["" ""];
            item = ["" ""];
            section = ["" ""];
          };
          integrations = {
            telescope = false;
            diffview = false;
            fzf_lua = true;
          };
        };
      };

      diffview.enable = true;

      which-key = {
        enable = true;
        settings = {
          delay = 300;
          preset = "modern";
          spec = [
            { __unkeyed-1 = "<leader>f"; group = "File"; }
            { __unkeyed-1 = "<leader>b"; group = "Buffer"; }
            { __unkeyed-1 = "<leader>w"; group = "Window"; }
            { __unkeyed-1 = "<leader>s"; group = "Search"; }
            { __unkeyed-1 = "<leader>g"; group = "Git"; }
            { __unkeyed-1 = "<leader>c"; group = "Code"; }
            { __unkeyed-1 = "<leader>o"; group = "Open/Toggle"; }
            { __unkeyed-1 = "<leader>a"; group = "AI/Assistant"; }
            { __unkeyed-1 = "<leader>h"; group = "Help"; }
            { __unkeyed-1 = "<leader>q"; group = "Quit"; }
            { __unkeyed-1 = "<leader>x"; group = "Errors/Diagnostics"; }
            { __unkeyed-1 = "<leader>n"; group = "Notes"; }
            { __unkeyed-1 = "<leader>p"; group = "Project"; }
          ];
        };
      };

      blink-cmp = {
        enable = true;
        settings = {
          sources = {
            providers = {
              copilot = {
                async = true;
                module = "blink-cmp-copilot";
                name = "copilot";
                score_offset = 100;
              };
            };
            default = [
              "lsp"
              "buffer"
              "path"
              "copilot"
            ];
          };
          appearance.kind_icons = {
            Copilot = "";
            Class = "󱡠";
            Color = "󰏘";
            Constant = "󰏿";
            Constructor = "󰒓";
            Enum = "󰦨";
            EnumMember = "󰦨";
            Event = "󱐋";
            Field = "󰜢";
            File = "󰈔";
            Folder = "󰉋";
            Function = "󰊕";
            Interface = "󱡠";
            Keyword = "󰻾";
            Method = "󰊕";
            Module = "󰅩";
            Operator = "󰪚";
            Property = "󰖷";
            Reference = "󰬲";
            Snippet = "󱄽";
            Struct = "󱡠";
            Text = "󰉿";
            TypeParameter = "󰬛";
            Unit = "󰪚";
            Value = "󰦨";
            Variable = "󰆦";
          };
        };
      };

      codecompanion = {
        enable = true;
        settings = {
          adapters = {
            anthropic = {
              __raw = /* lua */ ''
                function ()
                  return require("codecompanion.adapters").extend("anthropic", {
                    env = {
                      api_key = "cmd:cat ~/.config/andrewvim/anthropic_api_key"
                    }
                  })
                end
              '';
            };
          };
          strategies = {
            inline.adapter = "anthropic";
            chat.adapter = "anthropic";
            agent.adapter = "anthropic";
          };
        };
      };

      gitblame = {
        enable = true;
        settings = {
          delay = 0;
          virtual_text_column = 70;
        };
      };

      dashboard = {
        enable = true;
        settings = {
          theme = "hyper";
          config = {
            header = [
              "  ██████╗  ██████╗  ██████╗ ███╗   ███╗"
              "  ██╔══██╗██╔═══██╗██╔═══██╗████╗ ████║"
              "  ██║  ██║██║   ██║██║   ██║██╔████╔██║"
              "  ██║  ██║██║   ██║██║   ██║██║╚██╔╝██║"
              "  ██████╔╝╚██████╔╝╚██████╔╝██║ ╚═╝ ██║"
              "  ╚═════╝  ╚═════╝  ╚═════╝ ╚═╝     ╚═╝"
            ];
            shortcut = [
              { desc = "_"; }
            ];
            footer.__raw = "{}";
            packages.enable = false;
            project.enable = false;
            mru = {
              cwd_only = true;
            };
          };
        };
      };

      mini = {
        enable = true;
        modules = {
          hipatterns = {
            fixme = {
              pattern = "%f[%w]()FIXME()%f[%W]";
              group = "MiniHipatternsFixme";
            };
            hack = {
              pattern = "%f[%w]()HACK()%f[%W]";
              group = "MiniHipatternsHack";
            };
            todo = {
              pattern = "%f[%w]()TODO()%f[%W]";
              group = "MiniHipatternsTodo";
            };
            note = {
              pattern = "%f[%w]()NOTE()%f[%W]";
              group = "MiniHipatternsNote";
            };
            hex_color.__raw = "require('mini.hipatterns').gen_highlighter.hex_color()";
          };

          indentscope = {};
          cursorword = {};

          animate = {
            cursor.enable = false;
          };

          comment = {};

          bracketed = {
            comment    = { suffix = "c"; options = {}; };
            conflict   = { suffix = "mc"; options = {}; };
            diagnostic = { suffix = "d"; options = {}; };
            indent     = { suffix = "i"; options = {}; };
            quickfix   = { suffix = "q"; options = {}; };
            treesitter = { suffix = "t"; options = {}; };
          };

          jump = {
            mappings = {
              forward = "f";
              backward = "F";
              forward_till = "t";
              backward_till = "T";
              repeat_jump = ";";
            };
          };

          jump2d = {
            mappings = {
              start_jumping = "\\";
            };
          };
        };
      };

      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          auto_install = true;
        };
      };

      copilot-lua.enable = true;

      lsp = {
        enable = true;
        servers = {
          rust_analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
          };
          ts_ls.enable = true;
          nixd.enable = true;
          gopls.enable = true;
          elixirls.enable = true;
          jsonls.enable = true;
          pyright.enable = true;
          dockerls.enable = true;
          docker_compose_language_service.enable = true;
          bashls.enable = true;
        };

        keymaps = {
          lspBuf = {
            "K" = "hover";
            "gd" = "definition";
            "gD" = "references";
            "gi" = "implementation";
            "gt" = "type_definition";
            "<c-k>" = "signature_help";
          };
          diagnostic = {
            "]d" = "goto_next";
            "[d" = "goto_prev";
          };
        };
      };
    };

    globals.mapleader = " ";

    keymaps =
      let
        silentNMap =
          key: description: action:
          {
            mode = "n";
            key = key;
            options.silent = true;
            options.desc = description;
            action = action;
          };

        silentVMap =
          key: description: action:
          {
            mode = "v";
            key = key;
            options.silent = true;
            options.desc = description;
            action = action;
          };

        silentMap =
          modes: key: description: action:
          {
            mode = modes;
            key = key;
            options.silent = true;
            options.desc = description;
            action = action;
          };
      in
        [
          # ESCAPE SEQUENCES
          (silentMap ["i" "v"] "<C-g>" "Escape" "<Esc>")
          (silentNMap "<Esc>" "Clear search highlight" "<cmd>nohlsearch<CR>")

          # FILE OPERATIONS (SPC f)
          (silentNMap "<leader>ff" "Find file" "<cmd>lua require('fzf-lua').files()<CR>")
          (silentNMap "<leader>fr" "Recent files" "<cmd>lua require('fzf-lua').oldfiles()<CR>")
          (silentNMap "<leader>fs" "Save file" "<cmd>w<CR>")
          (silentNMap "<leader>fS" "Save all files" "<cmd>wa<CR>")
          (silentNMap "<leader>fd" "Find file in project" "<cmd>lua require('fzf-lua').git_files()<CR>")
          (silentNMap "<leader>fD" "Delete file" "<cmd>!rm %<CR><cmd>bdelete<CR>")
          (silentNMap "<leader>fy" "Yank filename" "<cmd>let @+ = expand('%:p')<CR>")
          (silentNMap "<leader>fw" "Delete trailing whitespace" "<cmd>%s/\\s\\+$//e<CR>")
          (silentMap ["n" "v"] "<D-\\>" "Delete trailing whitespace" "<cmd>%s/\\s\\+$//e<CR>")
          (silentMap ["n" "v"] "<C-\\>" "Delete trailing whitespace" "<cmd>%s/\\s\\+$//e<CR>")

          # BUFFER OPERATIONS (SPC b)
          (silentNMap "<leader>bb" "Switch buffer" "<cmd>lua require('fzf-lua').buffers()<CR>")
          (silentNMap "<leader>bd" "Kill buffer" "<cmd>bdelete<CR>")
          (silentNMap "<leader>bk" "Kill buffer" "<cmd>bdelete<CR>")
          (silentNMap "<leader>bD" "Kill other buffers" "<cmd>%bdelete|edit #|normal `\"<CR>")
          (silentNMap "<leader>bn" "Next buffer" "<cmd>bnext<CR>")
          (silentNMap "<leader>bp" "Previous buffer" "<cmd>bprevious<CR>")
          (silentNMap "<leader>br" "Revert buffer" "<cmd>edit!<CR>")
          (silentNMap "<leader>bs" "Save buffer" "<cmd>w<CR>")
          (silentNMap "<leader>bS" "Save all buffers" "<cmd>wa<CR>")
          (silentNMap "<leader>by" "Yank buffer" "<cmd>%y+<CR>")
          (silentNMap "<leader>bY" "Yank buffer path" "<cmd>let @+ = expand('%:p')<CR>")

          # WINDOW OPERATIONS (SPC w)
          (silentNMap "<leader>wv" "Split window vertically" "<cmd>vsplit<CR>")
          (silentNMap "<leader>ws" "Split window horizontally" "<cmd>split<CR>")
          (silentNMap "<leader>wd" "Delete window" "<cmd>close<CR>")
          (silentNMap "<leader>wD" "Delete other windows" "<cmd>only<CR>")
          (silentNMap "<leader>wo" "Delete other windows" "<cmd>only<CR>")
          (silentNMap "<leader>wh" "Focus left window" "<C-w>h")
          (silentNMap "<leader>wj" "Focus down window" "<C-w>j")
          (silentNMap "<leader>wk" "Focus up window" "<C-w>k")
          (silentNMap "<leader>wl" "Focus right window" "<C-w>l")
          (silentNMap "<leader>wH" "Move window left" "<C-w>H")
          (silentNMap "<leader>wJ" "Move window down" "<C-w>J")
          (silentNMap "<leader>wK" "Move window up" "<C-w>K")
          (silentNMap "<leader>wL" "Move window right" "<C-w>L")
          (silentNMap "<leader>w=" "Balance windows" "<C-w>=")

          # SEARCH (SPC s) - Doom Emacs style search commands
          (silentNMap "<leader>sp" "Search project" "<cmd>lua require('fzf-lua').live_grep()<CR>")
          (silentNMap "<leader>sd" "Search directory" "<cmd>lua require('fzf-lua').live_grep({cwd=vim.fn.expand('%:p:h')})<CR>")
          (silentNMap "<leader>ss" "Search buffer" "<cmd>lua require('fzf-lua').blines()<CR>")
          (silentNMap "<leader>si" "Search symbols (imenu)" "<cmd>lua require('fzf-lua').lsp_document_symbols()<CR>")
          (silentNMap "<leader>sI" "Search symbols workspace" "<cmd>lua require('fzf-lua').lsp_workspace_symbols()<CR>")
          (silentNMap "<leader>sl" "Search lines" "<cmd>lua require('fzf-lua').lines()<CR>")
          (silentNMap "<leader>sr" "Search and replace" "<cmd>lua require('fzf-lua').live_grep()<CR>")
          (silentNMap "<leader>sf" "Search files" "<cmd>lua require('fzf-lua').files()<CR>")
          (silentNMap "<leader>sF" "Search files (directory)" "<cmd>lua require('fzf-lua').files({cwd=vim.fn.expand('%:p:h')})<CR>")

          # PROJECT OPERATIONS (SPC p) - Projectile-like functionality
          (silentNMap "<leader>pp" "Switch project" "<cmd>lua require('fzf-lua').files({cwd='~/'})<CR>")
          (silentNMap "<leader>pf" "Find file in project" "<cmd>lua require('fzf-lua').git_files()<CR>")
          (silentNMap "<leader>pF" "Find file in project (all)" "<cmd>lua require('fzf-lua').files()<CR>")
          (silentNMap "<leader>ps" "Search in project" "<cmd>lua require('fzf-lua').live_grep()<CR>")
          (silentNMap "<leader>pr" "Recent project files" "<cmd>lua require('fzf-lua').oldfiles({cwd_only=true})<CR>")
          (silentNMap "<leader>pb" "Project buffers" "<cmd>lua require('fzf-lua').buffers({cwd_only=true})<CR>")
          (silentNMap "<leader>pd" "Find directory in project" "<cmd>lua require('fzf-lua').files({fd_opts='--type d'})<CR>")
          (silentNMap "<leader>pk" "Kill project buffers" "<cmd>%bdelete|edit #|normal `\"<CR>")
          (silentNMap "<leader>pR" "Replace in project" "<cmd>lua require('fzf-lua').live_grep()<CR>")

          # OPEN/TOGGLE (SPC o)
          (silentNMap "<leader>op" "Toggle file tree" "<cmd>Neotree toggle<CR>")
          (silentNMap "<leader>oP" "Find in file tree" "<cmd>Neotree reveal<CR>")
          (silentNMap "<leader>oe" "Open file tree" "<cmd>Neotree reveal<CR>")
          (silentNMap "<leader>ot" "Open terminal" "<cmd>terminal<CR>")
          (silentNMap "<leader>oT" "Open terminal (split)" "<cmd>split | terminal<CR>")

          # GIT (SPC g) - Enhanced with neogit mappings
          (silentNMap "<leader>gg" "Neogit (magit)" "<cmd>Neogit<CR>")
          (silentNMap "<leader>gs" "Git status (neogit)" "<cmd>Neogit<CR>")
          (silentNMap "<leader>gS" "Git status (fzf)" "<cmd>lua require('fzf-lua').git_status()<CR>")
          (silentNMap "<leader>gc" "Git commits (buffer)" "<cmd>lua require('fzf-lua').git_bcommits()<CR>")
          (silentNMap "<leader>gC" "Git commits (project)" "<cmd>lua require('fzf-lua').git_commits()<CR>")
          (silentNMap "<leader>gb" "Git blame" "<cmd>lua require('gitblame').toggle()<CR>")
          (silentNMap "<leader>gd" "Git diff" "<cmd>DiffviewOpen<CR>")
          (silentNMap "<leader>gD" "Git diff (close)" "<cmd>DiffviewClose<CR>")
          (silentNMap "<leader>gh" "Git file history" "<cmd>DiffviewFileHistory<CR>")
          (silentNMap "<leader>gH" "Git file history (current file)" "<cmd>DiffviewFileHistory %<CR>")
          (silentNMap "<leader>gl" "Neogit log" "<cmd>Neogit log<CR>")
          (silentNMap "<leader>gL" "Neogit log (current file)" "<cmd>Neogit log -- %<CR>")
          (silentNMap "<leader>gp" "Git push" "<cmd>Neogit push<CR>")
          (silentNMap "<leader>gP" "Git pull" "<cmd>Neogit pull<CR>")
          (silentNMap "<leader>gf" "Git fetch" "<cmd>Neogit fetch<CR>")
          (silentNMap "<leader>gr" "Git rebase" "<cmd>Neogit rebase<CR>")
          (silentNMap "<leader>gm" "Git merge" "<cmd>Neogit merge<CR>")
          (silentNMap "<leader>gt" "Git tag" "<cmd>Neogit tag<CR>")
          (silentNMap "<leader>gw" "Git worktree" "<cmd>Neogit worktree<CR>")
          (silentNMap "<leader>gz" "Git stash" "<cmd>Neogit stash<CR>")
          (silentNMap "]c" "Next git hunk" "<cmd>Gitsigns next_hunk<CR>")
          (silentNMap "[c" "Previous git hunk" "<cmd>Gitsigns prev_hunk<CR>")
          (silentNMap "<leader>ghr" "Reset git hunk" "<cmd>Gitsigns reset_hunk<CR>")
          (silentNMap "<leader>ghs" "Stage git hunk" "<cmd>Gitsigns stage_hunk<CR>")
          (silentVMap "<leader>ghs" "Stage git hunk (visual)" "<cmd>Gitsigns stage_hunk<CR>")

          # CODE (SPC c)
          (silentNMap "<leader>ca" "Code actions" "<cmd>lua require('fzf-lua').lsp_code_actions()<CR>")
          (silentNMap "<leader>cd" "Jump to definition" "<cmd>lua vim.lsp.buf.definition()<CR>")
          (silentNMap "<leader>cD" "Jump to declaration" "<cmd>lua vim.lsp.buf.declaration()<CR>")
          (silentNMap "<leader>ci" "Jump to implementation" "<cmd>lua vim.lsp.buf.implementation()<CR>")
          (silentNMap "<leader>cr" "Rename symbol" "<cmd>lua vim.lsp.buf.rename()<CR>")
          (silentNMap "<leader>cR" "Find references" "<cmd>lua vim.lsp.buf.references()<CR>")
          (silentNMap "<leader>cf" "Format buffer" "<cmd>lua vim.lsp.buf.format()<CR>")
          (silentNMap "<leader>ct" "Jump to type definition" "<cmd>lua vim.lsp.buf.type_definition()<CR>")

          # AI/ASSISTANT (SPC a)
          (silentNMap "<leader>aa" "Toggle AI chat" "<cmd>CodeCompanionChat Toggle<CR>")
          (silentNMap "<leader>ac" "AI chat" "<cmd>CodeCompanionChat<CR>")
          (silentNMap "<leader>ai" "AI inline" "<cmd>CodeCompanionActions<CR>")

          # HELP/DOCUMENTATION (SPC h)
          (silentNMap "<leader>hh" "Help tags" "<cmd>lua require('fzf-lua').help_tags()<CR>")
          (silentNMap "<leader>hk" "Describe key" "<cmd>lua require('fzf-lua').keymaps()<CR>")
          (silentNMap "<leader>hm" "Man pages" "<cmd>lua require('fzf-lua').man_pages()<CR>")
          (silentNMap "<leader>hf" "Describe function" "<cmd>lua require('fzf-lua').help_tags()<CR>")

          # QUIT (SPC q)
          (silentNMap "<leader>qq" "Quit" "<cmd>qa<CR>")
          (silentNMap "<leader>qQ" "Quit without saving" "<cmd>qa!<CR>")
          (silentNMap "<leader>qr" "Restart" "<cmd>qa<CR>")
          (silentNMap "<leader>qs" "Save and quit" "<cmd>wqa<CR>")

          # ERRORS/DIAGNOSTICS (SPC x)
          (silentNMap "<leader>xx" "Show diagnostics" "<cmd>lua require('fzf-lua').diagnostics_document()<CR>")
          (silentNMap "<leader>xX" "Show workspace diagnostics" "<cmd>lua require('fzf-lua').diagnostics_workspace()<CR>")
          (silentNMap "]d" "Next diagnostic" "<cmd>lua vim.diagnostic.goto_next()<CR>")
          (silentNMap "[d" "Previous diagnostic" "<cmd>lua vim.diagnostic.goto_prev()<CR>")

          # NOTES (SPC n)
          (silentNMap "<leader>nf" "Find notes" "<cmd>lua require('fzf-lua').files({cwd='~/notes'})<CR>")
          (silentNMap "<leader>ng" "Search notes" "<cmd>lua require('fzf-lua').live_grep({cwd='~/notes'})<CR>")

          # DOOM EMACS UNIVERSAL COMMANDS
          (silentNMap "<leader><leader>" "M-x (command palette)" "<cmd>lua require('fzf-lua').commands()<CR>")
          (silentNMap "<leader>:" "Execute command" ":")
          (silentNMap "<leader>;" "Eval expression" "<cmd>lua require('fzf-lua').commands()<CR>")

          # EVIL-LIKE MOTIONS AND COMMANDS
          (silentNMap "C-u" "Scroll up half page" "<C-u>")
          (silentNMap "C-d" "Scroll down half page" "<C-d>")
          (silentNMap "C-o" "Jump back" "<C-o>")
          (silentNMap "C-i" "Jump forward" "<C-i>")

          # COMMENTING (gcc for line, gc for visual)
          (silentNMap "gcc" "Comment line" "<cmd>lua require('mini.comment').toggle_lines(vim.fn.line('.'), vim.fn.line('.'))<CR>")
          (silentVMap "gc" "Comment selection" "<cmd>lua require('mini.comment').toggle_lines(vim.fn.line(\"'<\"), vim.fn.line(\"'>\"))<CR>")

          # WINDOW NAVIGATION (Doom style)
          (silentMap ["n" "t"] "<C-h>" "Focus left window" "<C-w>h")
          (silentMap ["n" "t"] "<C-j>" "Focus down window" "<C-w>j")
          (silentMap ["n" "t"] "<C-k>" "Focus up window" "<C-w>k")
          (silentMap ["n" "t"] "<C-l>" "Focus right window" "<C-w>l")

          # TERMINAL MODE ESCAPES
          (silentMap ["t"] "<Esc>" "Exit terminal mode" "<C-\\><C-n>")
          (silentMap ["t"] "<C-g>" "Exit terminal mode" "<C-\\><C-n>")
        ];
  };
in {
  home.packages = [ 
    nvim 
    pkgs.xclip         # X11 clipboard support
    pkgs.wl-clipboard  # Wayland clipboard support
  ];
}
