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
      wta = ''
        !f() {
          branch="$1"
          upstream="''$'{2:-upstream/patch}"
          [ -z "$branch" ] && { echo "Usage: git wta <branch-name> [upstream-ref]"; return 1; }
          git worktree add -b "$branch" "../$branch" "$upstream"
        }; f
      '';

      wtd = ''
        !f() {
          branch="$1"
          [ -z "$branch" ] && { echo "Usage: git wtd <branch-name>"; return 1; }
          [ -d "../$branch" ] && git worktree remove "../$branch" && git branch -D "$branch" 2>/dev/null || true
        }; f
      '';
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
