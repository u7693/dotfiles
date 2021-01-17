{ config, lib, pkgs, ... }:

with lib;
let cfg = config.u7693.home.dev.lorri;
in {
  options = {
    u7693.home.dev.lorri = {
      enable = mkEnableOption "lorri";
    };
  };

  config = mkIf cfg.enable {
    # https://rycee.gitlab.io/home-manager/options.html#opt-services.lorri.enable
    services.lorri.enable = true;

    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.direnv.enable
    programs.direnv = {
      enable = true;
      enableNixDirenvIntegration = true;
      enableZshIntegration = true;
    };
  };
}
