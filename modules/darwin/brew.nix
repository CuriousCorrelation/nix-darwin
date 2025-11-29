{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    exiftool
  ];
  
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
      "signal"
      "slack"
      "mac-mouse-fix"
      "stats"
      "caffeine"
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
