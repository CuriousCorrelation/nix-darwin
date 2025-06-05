{
  config,
  pkgs,
  ...
}: let
  homeDir = config.home.homeDirectory;
in {
  imports = [
    ./alacritty.nix
    ./bat.nix
    ./fzf.nix
    ./git.nix
    ./neovim.nix
    ./ssh.nix
    ./wezterm.nix
    ./zsh.nix
  ];

  home = let
    nodePath = "${homeDir}/.node";
  in {
    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "22.05";
    sessionVariables = {
      EDITOR = "emacs";
      VISUAL = "emacs";
      CLICOLOR = 1;
      LSCOLORS = "ExFxBxDxCxegedabagacad";
      NODE_PATH = nodePath;
    };
    sessionPath = [
      "${homeDir}/.rye/shims"
      "${homeDir}/.rd/bin"
      "${homeDir}/.docker/bin"
      "${nodePath}/bin"
    ];

    # define package definitions for current user environment
    packages = with pkgs; [
      devenv
      direnv
      nerd-fonts.iosevka
      nerd-fonts.fira-code
      (aspellWithDicts (dicts: with dicts; [en en-computers en-science]))
      ffmpeg
      mpv
      neofetch
      nix
      rsync
      shellcheck
      tree
      utm
      smartmontools
    ];
  };

  fonts.fontconfig.enable = true;

  programs = {
    home-manager = {
      enable = true;
    };
    dircolors.enable = true;
    htop.enable = true;
    jq.enable = true;
    man.enable = true;
    nix-index.enable = true;
    pandoc.enable = true;
    ripgrep.enable = true;
    starship.enable = true;
    vscode = {
      enable = true;

      mutableExtensionsDir = false;

      profiles.default.enableUpdateCheck = false;
      profiles.default.enableExtensionUpdateCheck = false;

      profiles.default.extensions = with pkgs.vscode-extensions; [
        jdinhlife.gruvbox
        vscodevim.vim
        yzhang.markdown-all-in-one
        ms-vsliveshare.vsliveshare
        rust-lang.rust-analyzer
        ms-azuretools.vscode-docker
        vue.volar
        bbenoist.nix
      ];

      # Settings
      profiles.default.userSettings = {
        "workbench.colorTheme" = "Gruvbox Dark Hard";
        "telemetry.telemetryLevel" = "off";
      };
    };
  };
}
