{pkgs, ...}: let
  fontFamily = "Iosevka Nerd Font Mono";

  # Theme `adventure`
  adventure = {
    primary = {
      background = "0x040404";
      foreground = "0xfeffff";
    };
    cursor = {
      text = "0x000000";
      cursor = "0xfeffff";
    };
    normal = {
      black = "0x040404";
      red = "0xd84a33";
      green = "0x5da602";
      blue = "0x417ab3";
      magenta = "0xe5c499";
      cyan = "0xbdcfe5";
      white = "0xdbded8";
      yellow = "0xeebb6e";
    };
    bright = {
      black = "0x685656";
      red = "0xd76b42";
      green = "0x99b52c";
      blue = "0x97d7ef";
      magenta = "0xaa7900";
      cyan = "0xbdcfe5";
      white = "0xe4d5c7";
      yellow = "0xffb670";
    };
  };
in {
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        padding = {
          x = 10;
          y = 10;
        };
        option_as_alt = "Both";
        dynamic_title = true;
      };
      scrolling = {
        history = 10000;
      };
      colors = adventure;
      font = {
        normal.family = fontFamily;
        bold.family = fontFamily;
        italic.family = fontFamily;
        bold_italic.family = fontFamily;
        size = 9.0;
      };
      terminal = {
        shell.program = "${pkgs.zsh}/bin/zsh";
      };
    };
  };
}
