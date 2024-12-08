{...}: let
  monokai_pro = {
    ansi = [
      "#403E41" # black
      "#FF6188" # red
      "#A9DC76" # green
      "#FFD866" # yellow
      "#FC9867" # blue (orange)
      "#AB9DF2" # magenta (violet)
      "#78DCE8" # cyan
      "#FCFCFA" # foreground
    ];
    brights = [
      "#727072"
      "#FF6188"
      "#A9DC76"
      "#FFD866"
      "#FC9867"
      "#AB9DF2"
      "#78DCE8"
      "#FCFCFA"
    ];
    background = "#2D2A2E";
    foreground = "#FCFCFA";
    selection_bg = "#69616B";
    selection_fg = "#FCFCFA";
  };
  monokai_pro_light = {
    ansi = [
      "#D3CDCC" # black
      "#E14775" # red
      "#269D69" # green
      "#CC7A0A" # yellow
      "#E16032" # blue
      "#7058BE" # magenta
      "#1C8CA8" # cyan
      "#29242A" # foreground
    ];
    brights = [
      "#A59FA0"
      "#E14775"
      "#269D69"
      "#CC7A0A"
      "#E16032"
      "#7058BE"
      "#1C8CA8"
      "#29242A"
    ];
    background = "#faf4f2";
    foreground = "#29242A";
    selection_bg = "#69616B";
    selection_fg = "#FCFCFA";
  };
  fontFamily = "Iosevka Nerd Font Mono";
in {
  programs.wezterm = {
    enable = true;
    colorSchemes = {
      monokai_pro = monokai_pro;
      monokai_pro_light = monokai_pro;
    };
    extraConfig = ''
      -- This table will hold the configuration.
      local config = {}

      -- In newer versions of wezterm, use the config_builder which will
      -- help provide clearer error messages
      if wezterm.config_builder then
        config = wezterm.config_builder()
      end

      -- workaround rendering bug
      config.front_end = "WebGpu"

      config.font = wezterm.font("${fontFamily}", { weight = 800 })
      config.font_size = 12
      config.window_frame = {
        font_size = 12
      }
      function color_scheme()
        local appearance = wezterm.gui.get_appearance()
        if appearance:find 'Dark' then
          return 'monokai_pro'
        else
          return 'monokai_pro_light'
        end
      end
      config.color_scheme = color_scheme()

      local act = wezterm.action
      config.disable_default_key_bindings = true
      config.keys = {
        { mods = "CMD", key = "1", action = act.ActivateTab(0) },
        { mods = "CMD", key = "2", action = act.ActivateTab(1) },
        { mods = "CMD", key = "3", action = act.ActivateTab(2) },
        { mods = "CMD", key = "4", action = act.ActivateTab(3) },
        { mods = "CMD", key = "5", action = act.ActivateTab(4) },
        { mods = "CMD", key = "6", action = act.ActivateTab(5) },
        { mods = "CMD", key = "7", action = act.ActivateTab(6) },
        { mods = "CMD", key = "8", action = act.ActivateTab(7) },
        { mods = "CMD", key = "9", action = act.ActivateTab(8) },
        { mods = "CMD", key = "0", action = act.ActivateTab(9) },
        { mods = "CMD|SHIFT", key = "LeftArrow", action = act.ActivateTabRelative(-1) },
        { mods = "CMD|SHIFT", key = "RightArrow", action = act.ActivateTabRelative(1) },
        { mods = "CMD|SHIFT", key = "q", action = act.CloseCurrentTab { confirm = true } },

        { mods = "CMD|SHIFT", key = "v", action = act.SplitVertical { domain = "CurrentPaneDomain" } },
        { mods = "CMD|SHIFT", key = "h", action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },
        { mods = "CMD", key = "LeftArrow", action = act.ActivatePaneDirection("Left") },
        { mods = "CMD", key = "RightArrow", action = act.ActivatePaneDirection("Right") },
        { mods = "CMD", key = "UpArrow", action = act.ActivatePaneDirection("Up") },
        { mods = "CMD", key = "DownArrow", action = act.ActivatePaneDirection("Down") },
        { mods = "CMD|SHIFT", key = "w", action = act.CloseCurrentPane { confirm = false } },

        { mods = "CMD|SHIFT", key = "c", action = act.CopyTo("Clipboard") },
        { mods = "CMD|SHIFT", key = "v", action = act.PasteFrom("Clipboard") },
        { mods = "CMD", key = "-", action = act.DecreaseFontSize },
        { mods = "CMD", key = "=", action = act.IncreaseFontSize },
        { mods = "CMD|OPT", key = "k", action = act.ActivateCommandPalette },
        { mods = "CMD|OPT", key = "f", action = act.Search { CaseSensitiveString = ""} },
        { mods = "CMD", key = "t", action = act.SpawnTab("CurrentPaneDomain") },

        { mods = "CMD|SHIFT", key = "l", action = act.ShowDebugOverlay },
      }
      return config
    '';
  };
}
