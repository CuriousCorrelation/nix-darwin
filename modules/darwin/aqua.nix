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
      lcmd - return : open -n -a "Alacritty"

      # Toggle Window
      lalt - t : yabai -m window --toggle float && yabai -m window --grid 4:4:1:1:2:2
      lcmd - q : yabai -m window --close

      # Fullscreen Window
      lcmd + shift - f : yabai -m window --toggle zoom-fullscreen

      # Close Current Window [already set as default]
      # lcmd - q : yabai -m window --close

      # Focus Window
      lcmd - k : yabai -m window --focus north
      lcmd - j : yabai -m window --focus south
      lcmd - h : yabai -m window --focus west
      lcmd - l : yabai -m window --focus east

      # Swap Window
      lcmd + shift - k : yabai -m window --swap north
      lcmd + shift - j : yabai -m window --swap south
      lcmd + shift - h : yabai -m window --swap west
      lcmd + shift - l : yabai -m window --swap east

      # Resize Window
      lcmd + cmd - k : yabai -m window --resize up:-50:0 && yabai -m window --resize down:-50:0
      lcmd + cmd - j : yabai -m window --resize up:-50:0 && yabai -m window --resize down:-50:0
      lcmd + cmd - h : yabai -m window --resize left:-50:0 && yabai -m window --resize right:-50:0
      lcmd + cmd - l : yabai -m window --resize left:50:0 && yabai -m window --resize right:50:0

      # Focus Space
      lcmd - 1 : yabai -m space --focus 1
      lcmd - 2 : yabai -m space --focus 2
      lcmd - 3 : yabai -m space --focus 3
      lcmd - 4 : yabai -m space --focus 4
      lcmd - 5 : yabai -m space --focus 5
      lcmd - j : yabai -m space --focus prev
      lcmd - l : yabai -m space --focus next

      # Send to Space
      lcmd + shift - 1 : yabai -m window --space 1
      lcmd + shift - 2 : yabai -m window --space 2
      lcmd + shift - 3 : yabai -m window --space 3
      lcmd + shift - 4 : yabai -m window --space 4
      lcmd + shift - 5 : yabai -m window --space 5
      lcmd + shift - h : yabai -m window --space prev && yabai -m space --focus prev
      lcmd + shift - l : yabai -m window --space next && yabai -m space --focus next
    '';
  };
}
