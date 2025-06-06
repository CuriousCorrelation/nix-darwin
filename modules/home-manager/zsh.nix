{config, ...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      k = "k -hat";
      e = "emacs";
      v = "neovim";
      dev = "devenv shell";
      ls = "ls --color --group-directories-first";
    };

    history = {
      size = 99999;
      save = 99999;
      path = "${config.home.homeDirectory}/.config/history";
    };

    zplug = {
      enable = true;
      plugins = [
        {name = "supercrabtree/k";}
      ];
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "fzf"
        "history"
        "node"
        "rust"
        "ssh-agent"
        "direnv"
      ];
    };
  };
}
