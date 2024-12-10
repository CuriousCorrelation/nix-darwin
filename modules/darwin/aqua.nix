{
  config,
  pkgs,
  ...
}: {
  services.yabai = {
    enable = true;
    package = pkgs.yabai;
    config = {
      layout = "bsp";
      auto_balance = "off";
      split_ratio = "0.50";
      window_placement = "second_child";
      window_border = "on";
      window_border_width = "2";
      window_gap = "10";
      top_padding = "10";
      bottom_padding = "10";
      left_padding = "10";
      right_padding = "10";
      focus_follows_mouse = "off";
      mouse_follows_focus = "off";
    };

    extraConfig = ''
      yabai -m rule --add app='^Emacs$' manage=on
      yabai -m rule --add app="^System Settings$" manage=off
      yabai -m rule --add app="^System Preferences$" manage=off
      yabai -m rule --add app="^System Information$" manage=off
      yabai -m rule --add app="^Activity Monitor$" manage=off
      yabai -m rule --add app="^App Store$" manage=off
      yabai -m rule --add app="^Archive Utility$" manage=off
      yabai -m rule --add app="^Calendar$" manage=off
      yabai -m rule --add app="^Calculator$" manage=off
      yabai -m rule --add app="^Console$" manage=off
      yabai -m rule --add app="^Dictionary$" manage=off
      yabai -m rule --add app="^Disk Utility$" manage=off
      yabai -m rule --add app="^Font Book$" manage=off
      yabai -m rule --add app="^FaceTime$" manage=off
      yabai -m rule --add app="^Image Capture$" manage=off
      yabai -m rule --add app="^Installer$" manage=off
      yabai -m rule --add app="^KeePassXC$" manage=off
      yabai -m rule --add app="^Mail$" manage=off
      yabai -m rule --add app="^Maps$" manage=off
      yabai -m rule --add app="^Messages$" manage=off
      yabai -m rule --add app="^Mission Control$" manage=off
      yabai -m rule --add app="^Notes$" manage=off
      yabai -m rule --add app="^Photos$" manage=off
      yabai -m rule --add app="^Preview$" manage=off
      yabai -m rule --add app="^QuickTime Player$" manage=off
      yabai -m rule --add app="^Reminders$" manage=off
      yabai -m rule --add app="^Stickies$" manage=off
      yabai -m rule --add app="^Time Machine$" manage=off
      yabai -m rule --add app="^VLC$" manage=off
      yabai -m rule --add app="^Voice Memos$" manage=off
      yabai -m rule --add app="^Music$" manage=off
      yabai -m rule --add app="^mpv$" manage=off
      yabai -m rule --add app="^macfeh$" manage=off
      yabai -m rule --add app="^Finder$" manage=off
      yabai -m rule --add app="^Safari" manage=off
      yabai -m rule --add label="Software Update" title="Software Update" manage=off
      yabai -m rule --add label="About This Mac" app="System Information" title="About This Mac" manage=off
      yabai -m rule --add subrole="^AXDialog$" manage=off
      yabai -m rule --add subrole="^AXSheet$" manage=off
      yabai -m rule --add subrole="^AXSystemDialog$" manage=off
      yabai -m rule --add role="^AXSystemDialog$" manage=off
    '';
  };

  services.skhd = {
    enable = true;
    skhdConfig = ''
      lcmd - return    : open -n -a "Wezterm"
      lalt - t         : yabai -m window --toggle float && yabai -m window --grid 4:4:1:1:2:2
      lcmd - q         : yabai -m window --close
      lcmd + shift - f : yabai -m window --toggle zoom-fullscreen
      lcmd - k         : yabai -m window --focus north
      lcmd - j         : yabai -m window --focus south
      lcmd - h         : yabai -m window --focus west
      lcmd - l         : yabai -m window --focus east
      lcmd + shift - k : yabai -m window --swap north
      lcmd + shift - j : yabai -m window --swap south
      lcmd + shift - h : yabai -m window --swap west
      lcmd + shift - l : yabai -m window --swap east
      lcmd + cmd - k   : yabai -m window --resize up:-50:0 && yabai -m window --resize down:-50:0
      lcmd + cmd - j   : yabai -m window --resize up:-50:0 && yabai -m window --resize down:-50:0
      lcmd + cmd - h   : yabai -m window --resize left:-50:0 && yabai -m window --resize right:-50:0
      lcmd + cmd - l   : yabai -m window --resize left:50:0 && yabai -m window --resize right:50:0
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
