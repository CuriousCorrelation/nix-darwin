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

          # PROJECT/SEARCH (SPC s)
          (silentNMap "<leader>sp" "Search project" "<cmd>lua require('fzf-lua').live_grep()<CR>")
          (silentNMap "<leader>ss" "Search buffer" "<cmd>lua require('fzf-lua').blines()<CR>")
          (silentNMap "<leader>si" "Search symbols (imenu)" "<cmd>lua require('fzf-lua').lsp_document_symbols()<CR>")
          (silentNMap "<leader>sI" "Search symbols workspace" "<cmd>lua require('fzf-lua').lsp_workspace_symbols()<CR>")
          (silentNMap "<leader>sl" "Search lines" "<cmd>lua require('fzf-lua').lines()<CR>")
          (silentNMap "<leader>sr" "Search and replace" "<cmd>lua require('fzf-lua').live_grep()<CR>")

          # OPEN/TOGGLE (SPC o)
          (silentNMap "<leader>op" "Toggle file tree" "<cmd>Neotree toggle<CR>")
          (silentNMap "<leader>oP" "Find in file tree" "<cmd>Neotree reveal<CR>")
          (silentNMap "<leader>oe" "Open file tree" "<cmd>Neotree reveal<CR>")
          (silentNMap "<leader>ot" "Open terminal" "<cmd>terminal<CR>")
          (silentNMap "<leader>oT" "Open terminal (split)" "<cmd>split | terminal<CR>")

          # GIT (SPC g)
          (silentNMap "<leader>gs" "Git status" "<cmd>lua require('fzf-lua').git_status()<CR>")
          (silentNMap "<leader>gc" "Git commits (buffer)" "<cmd>lua require('fzf-lua').git_bcommits()<CR>")
          (silentNMap "<leader>gC" "Git commits (project)" "<cmd>lua require('fzf-lua').git_commits()<CR>")
          (silentNMap "<leader>gb" "Git blame" "<cmd>lua require('gitblame').toggle()<CR>")
          (silentNMap "<leader>gd" "Git diff" "<cmd>Gitsigns diffthis<CR>")
          (silentNMap "]c" "Next git hunk" "<cmd>Gitsigns next_hunk<CR>")
          (silentNMap "[c" "Previous git hunk" "<cmd>Gitsigns prev_hunk<CR>")
          (silentNMap "<leader>gr" "Reset git hunk" "<cmd>Gitsigns reset_hunk<CR>")
          (silentNMap "<leader>gS" "Stage git hunk" "<cmd>Gitsigns stage_hunk<CR>")
          (silentVMap "<leader>gS" "Stage git hunk (visual)" "<cmd>Gitsigns stage_hunk<CR>")

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
  home.packages = [ nvim ];
}
