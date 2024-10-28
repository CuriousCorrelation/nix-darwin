{...}: {
  homebrew = {
    enable = true;
    global = {brewfile = true;};
    # brews = [
    #   "jnv"
    # ];

    taps = [
      "beeftornado/rmtree"
      "homebrew/bundle"
      "homebrew/services"
    ];
    casks = [
      "firefox"
      "visual-studio-code"
    ];
  };
}
