{
  inputs,
  config,
  ...
}: {
  # Environment setup
  environment = {
    etc = {
      darwin.source = "${inputs.darwin}";
    };
  };

  # Nix configuration
  nix = {
    configureBuildUsers = false;
    nixPath = [
      "darwin=/etc/${config.environment.etc.darwin.target}"
    ];
    extraOptions = ''
      extra-platforms = x86_64-darwin aarch64-darwin
    '';
  };

  # GUI configurations
  imports = [
    ./aqua.nix
  ];

  # Security settings
  security.pam.enableSudoTouchIdAuth = true;

  # System services
  services = {
    # Nix daemon
    nix-daemon.enable = true;
  };

  # System state version
  system.stateVersion = 4;
}
