{
  description = "Nix Darwin Configuration";

  inputs = {
    # package repos
    stable.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    devenv = {
      url = "github:cachix/devenv/v1.0.7";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # system management
    nixos-hardware.url = "github:nixos/nixos-hardware";
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # shell stuff
    flake-utils.url = "github:numtide/flake-utils";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs = {
    self,
    darwin,
    home-manager,
    nixpkgs,
    ...
  } @ inputs: {
    darwinConfigurations."Curiouss-MacBook-Pro" = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        home-manager.darwinModules.home-manager
        ./modules/darwin
        ./profiles/main.nix
      ];
      specialArgs = {inherit self inputs nixpkgs;};
    };

    homeConfigurations."Curiouss-MacBook-Pro" = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        system = "aarch64-darwin";
      };
      modules = [
        ./modules/home-manager
        {
          home = {
            username = "curiouscorrelation";
            homeDirectory = "/Users/curiouscorrelation";
            sessionVariables = {
              NIX_PATH = "nixpkgs=${nixpkgs}";
            };
          };
        }
        ./profiles/home-manager/main.nix
      ];
      extraSpecialArgs = {inherit self inputs nixpkgs;};
    };
  };
}
