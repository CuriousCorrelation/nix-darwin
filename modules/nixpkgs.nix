{
  config,
  pkgs,
  ...
}: {
  nixpkgs = {config = import ./config.nix;};

  nix = {
    package = pkgs.nix;
    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
    '';
    settings = {
      experimental-features = "nix-command flakes";
      max-jobs = 8;
      trusted-users = ["${config.user.name}" "root" "@admin" "@wheel"];
      trusted-substituters = [
        "https://cache.nixos.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 14d";
    };

    nixPath =
      builtins.map
      (source: "${source}=/etc/${config.environment.etc.${source}.target}") [
        "home-manager"
      ];
  };
}
