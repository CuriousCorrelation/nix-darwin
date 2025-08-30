{...}: {
  homebrew = {
    enable = true;
    global = {
      brewfile = true;
    };

    # CLI tools and utilities
    # brews = [
    #   "jnv"
    # ];

    # Taps (Third-party repositories)
    taps = [
      "beeftornado/rmtree"
      "homebrew/bundle"
      "homebrew/services"
    ];

    casks = [
      "firefox"
      "google-chrome"
      "visual-studio-code"
      "signal"
      "slack"
      "steermouse"
    ];

    # Mac App Store apps
    masApps = {
      # Format: "appName" = app-id;
    };

    # Homebrew configuration and cleanup options
    onActivation = {
      autoUpdate = true;
      cleanup = "zap"; # Remove all unmanaged files
      upgrade = true;
    };
  };
}
