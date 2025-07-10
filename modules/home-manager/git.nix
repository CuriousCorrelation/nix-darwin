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
      push.default = "current";
      push.useForceIfIncludes = true;

      "branch \"main\"".pushRemote = "PROTECTED_BRANCH_NO_PUSH";
      "branch \"master\"".pushRemote = "PROTECTED_BRANCH_NO_PUSH";
      "branch \"develop\"".pushRemote = "PROTECTED_BRANCH_NO_PUSH";
      "branch \"dev\"".pushRemote = "PROTECTED_BRANCH_NO_PUSH";
      "branch \"next\"".pushRemote = "PROTECTED_BRANCH_NO_PUSH";
      "branch \"staging\"".pushRemote = "PROTECTED_BRANCH_NO_PUSH";
      "branch \"production\"".pushRemote = "PROTECTED_BRANCH_NO_PUSH";
      "branch \"patch\"".pushRemote = "PROTECTED_BRANCH_NO_PUSH";
      "branch \"release\"".pushRemote = "PROTECTED_BRANCH_NO_PUSH";

      receive.denyNonFastForwards = true;
    };

    aliases = {
      wta = ''!f() { git worktree add -b "$1" "../$1" "''${2:-upstream/patch}"; }; f'';
      wtd = ''!f() { if [ -d "../$1" ]; then git worktree remove "../$1" && git branch -D "$1" 2>/dev/null || true; else echo "Worktree ../$1 does not exist"; fi; }; f'';
      wtl = "worktree list";
      wts = ''!f() { echo "cd ../$1"; }; f'';
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
