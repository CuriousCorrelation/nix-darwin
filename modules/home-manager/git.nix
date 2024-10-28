{pkgs, ...}: {
  home.packages = [pkgs.github-cli pkgs.git-crypt];
  programs.git = {
    userName = "curiouscorrelation";
    enable = true;
    extraConfig = {
      credential.helper =
        if pkgs.stdenvNoCC.isDarwin
        then "osxkeychain"
        else "cache --timeout=1000000000";
      commit.verbose = true;
      fetch.prune = true;
      http.sslVerify = true;
      init.defaultBranch = "main";
      pull.rebase = true;
      push.followTags = true;
      push.autoSetupRemote = true;
    };
    delta = {
      enable = false;
      options = {
        side-by-side = true;
        line-numbers = true;
      };
    };
    difftastic.enable = true;
    lfs.enable = true;
  };
}