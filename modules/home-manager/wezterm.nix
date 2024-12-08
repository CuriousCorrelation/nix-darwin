{...}: let
  adventure = {
    ansi = [
      "#040404" # black
      "#d84a33" # red
      "#5da602" # green
      "#eebb6e" # yellow
      "#417ab3" # blue
      "#e5c499" # magenta
      "#bdcfe5" # cyan
      "#dbded8" # white
    ];
    brights = [
      "#685656" # black
      "#d76b42" # red
      "#99b52c" # green
      "#ffb670" # yellow
      "#97d7ef" # blue
      "#aa7900" # magenta
      "#bdcfe5" # cyan
      "#e4d5c7" # white
    ];
    background = "#2b2b2b";
    foreground = "#feffff";
    selection_bg = "#417ab3";
    selection_fg = "#feffff";
  };
  adventure_light = {
    ansi = [
      "#685656" # black
      "#d84a33" # red
      "#5da602" # green
      "#eebb6e" # yellow
      "#417ab3" # blue
      "#e5c499" # magenta
      "#bdcfe5" # cyan
      "#2b2b2b" # white
    ];
    brights = [
      "#685656" # black
      "#d76b42" # red
      "#99b52c" # green
      "#ffb670" # yellow
      "#97d7ef" # blue
      "#aa7900" # magenta
      "#bdcfe5" # cyan
      "#2b2b2b" # white
    ];
    background = "#feffff";
    foreground = "#2b2b2b";
    selection_bg = "#417ab3";
    selection_fg = "#feffff";
  };
  fontFamily = "Iosevka Nerd Font Mono";
in {
  programs.wezterm = {
    enable = true;
    colorSchemes = {
      adventure = adventure;
      adventure_light = adventure;
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
          return 'adventure'
        else
          return 'adventure_light'
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

        { mods = "CMD", key = "c", action = act.CopyTo("Clipboard") },
        { mods = "CMD", key = "v", action = act.PasteFrom("Clipboard") },
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
