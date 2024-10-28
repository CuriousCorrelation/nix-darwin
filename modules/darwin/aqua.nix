{
  config,
  pkgs,
  ...
}: {
  # Window manager configuration
  services.yabai = {
    enable = true;
    package = pkgs.yabai;
    config = {
      # Layout
      layout = "bsp";
      auto_balance = "off";
      split_ratio = "0.50";
      window_placement = "second_child";

      # Window appearance
      window_border = "on";
      window_border_width = "2";
      window_gap = "10";

      # Padding
      top_padding = "10";
      bottom_padding = "10";
      left_padding = "10";
      right_padding = "10";

      # Mouse behavior
      focus_follows_mouse = "autoraise";
      mouse_follows_focus = "off";
    };

    extraConfig = ''
      # Application-specific rules
      yabai -m rule --add app='^Emacs$' manage=on
      yabai -m rule --add app="^System Settings$" manage=off
      yabai -m rule --add label="Finder" app="^Finder$" title="(Co(py|nnect)|Move|Info|Pref)" manage=off
      yabai -m rule --add label="Safari" app="^Safari$" title="^(General|(Tab|Password|Website|Extension)s|AutoFill|Se(arch|curity)|Privacy|Advance)$" manage=off
      yabai -m rule --add label="macfeh" app="^macfeh$" manage=off
      yabai -m rule --add label="System Preferences" app="^System Preferences$" title=".*" manage=off
      yabai -m rule --add label="App Store" app="^App Store$" manage=off
      yabai -m rule --add label="Activity Monitor" app="^Activity Monitor$" manage=off
      yabai -m rule --add label="KeePassXC" app="^KeePassXC$" manage=off
      yabai -m rule --add label="Calculator" app="^Calculator$" manage=off
      yabai -m rule --add label="Dictionary" app="^Dictionary$" manage=off
      yabai -m rule --add label="mpv" app="^mpv$" manage=off
      yabai -m rule --add label="Software Update" title="Software Update" manage=off
      yabai -m rule --add label="About This Mac" app="System Information" title="About This Mac" manage=off
    '';
  };

  # Keyboard shortcuts daemon
  services.skhd = {
    enable = true;
    skhdConfig = ''
      # Open Terminal
      lalt - return : open -n -a "Alacritty"

      # Toggle Window
      lalt - t : yabai -m window --toggle float && yabai -m window --grid 4:4:1:1:2:2
      lalt - f : yabai -m window --toggle zoom-fullscreen
      lalt - q : yabai -m window --close

      # Close Current Window
      lalt + shift - q : yabai -m window --close

      # Focus Window
      lalt - k : yabai -m window --focus north
      lalt - j : yabai -m window --focus south
      lalt - h : yabai -m window --focus west
      lalt - l : yabai -m window --focus east

      # Swap Window
      lalt + shift - k : yabai -m window --swap north
      lalt + shift - j : yabai -m window --swap south
      lalt + shift - h : yabai -m window --swap west
      lalt + shift - l : yabai -m window --swap east

      # Resize Window
      lalt + cmd - k : yabai -m window --resize up:-50:0 && yabai -m window --resize down:-50:0
      lalt + cmd - j : yabai -m window --resize up:-50:0 && yabai -m window --resize down:-50:0
      lalt + cmd - h : yabai -m window --resize left:-50:0 && yabai -m window --resize right:-50:0
      lalt + cmd - l : yabai -m window --resize left:50:0 && yabai -m window --resize right:50:0

      # Focus Space
      lalt - 1 : yabai -m space --focus 1
      lalt - 2 : yabai -m space --focus 2
      lalt - 3 : yabai -m space --focus 3
      lalt - 4 : yabai -m space --focus 4
      lalt - 5 : yabai -m space --focus 5
      lalt - j : yabai -m space --focus prev
      lalt - l : yabai -m space --focus next

      # Send to Space
      lalt + shift - 1 : yabai -m window --space 1
      lalt + shift - 2 : yabai -m window --space 2
      lalt + shift - 3 : yabai -m window --space 3
      lalt + shift - 4 : yabai -m window --space 4
      lalt + shift - 5 : yabai -m window --space 5
      lalt + shift - h : yabai -m window --space prev && yabai -m space --focus prev
      lalt + shift - l : yabai -m window --space next && yabai -m space --focus next
    '';
  };
}
