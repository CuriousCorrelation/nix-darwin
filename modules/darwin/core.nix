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
  security.pam.services.sudo_local.touchIdAuth = true;

  # System state version
  system.stateVersion = 5;
}
