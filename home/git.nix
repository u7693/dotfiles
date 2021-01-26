{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.u7693.home.git;

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
      enable = mkEnableOption "Git";

      userName = mkOption {
        type = types.nullOr types.str;
        default = null;
      };

      userEmail = mkOption {
        type = types.nullOr types.str;
        default = null;
      };

      userSigningKey = mkOption {
        type = types.nullOr types.str;
        default = null;
      };
    };
  };

  config = mkIf cfg.enable {
    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.git.enable
    programs.git = {
      enable = true;
      inherit aliases extraConfig ignores;
      signing.key = cfg.userSigningKey;
      userEmail = cfg.userEmail;
      userName = cfg.userName;
    };

    home.packages = [ pkgs.gitAndTools.gitflow ];
  };
}
