{...}: {
  # firewall
  networking.applicationFirewall = {
    enable = true;
    enableStealthMode = true;
  };

  system.defaults = {
    # login window settings
    loginwindow = {
      # disable guest account
      GuestEnabled = false;
      # show name instead of username
      SHOWFULLNAME = false;
    };

    NSGlobalDomain = {
      ApplePressAndHoldEnabled = false;
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
      AppleShowAllFiles = true;
      AppleShowAllExtensions = true;
      AppleShowScrollBars = "Automatic";
      NSAutomaticCapitalizationEnabled = true;
      NSAutomaticSpellingCorrectionEnabled = true;
      "com.apple.swipescrolldirection" = false;
      _HIHideMenuBar = false;
    };

    # file viewer settings
    finder = {
      AppleShowAllExtensions = true;
      FXEnableExtensionChangeWarning = true;
      _FXShowPosixPathInTitle = true;
    };

    # trackpad settings
    trackpad = {
      # silent clicking = 0, default = 1
      ActuationStrength = 0;
      # enable tap-to-click
      Clicking = true;
      # enable tap-to-drag
      Dragging = true;
      # firmness level, 0 = lightest, 2 = heaviest
      FirstClickThreshold = 1;
      # firmness level for force touch
      SecondClickThreshold = 1;
      # allow positional right click
      TrackpadRightClick = true;
    };

    # dock settings
    dock = {
      # auto show and hide dock
      autohide = true;
      # remove delay for showing dock
      autohide-delay = 0.0;
      # how fast is the dock showing animation
      autohide-time-modifier = 1.0;
      tilesize = 50;
      static-only = false;
      showhidden = false;
      show-recents = false;
      show-process-indicators = true;
      orientation = "bottom";
      mru-spaces = false;
    };
  };

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };
}
