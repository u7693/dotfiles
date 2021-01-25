{ config, lib, pkgs, ... }:

with lib; with builtins;
let
  cfg = config.u7693.home.git;

  user = fromJSON (readFile ../user.json);

  aliases = {
    lg = "log --oneline --graph";
    st = "status --short --branch";
  };

  extraConfig = {
    init.defaultBranch = "main";
  };

  ignores = import ./git-ignores.nix;

in {
  options = {
    u7693.home.git = {
      enable = mkEnableOption "git";
    };
  };

  config = mkIf cfg.enable {
    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.git.enable
    programs.git = {
      enable = true;
      inherit aliases extraConfig ignores;
      signing.key = user.gpg;
      userEmail = user.email;
      userName = user.name;
    };

    home.packages = [ pkgs.gitAndTools.gitflow ];
  };
}
