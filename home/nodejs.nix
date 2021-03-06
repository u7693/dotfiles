{ config, lib, pkgs, ... }:

with lib;
let cfg = config.u7693.home.nodejs;
in {
  options = {
    u7693.home.nodejs = {
      enable = mkEnableOption "NodeJS";

      package = mkOption {
        type = types.package;
        default = pkgs.nodejs;
      };

      serverless  = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      cfg.package
    ] ++ optionals cfg.serverless [
      nodePackages.serverless
    ];

    home.sessionVariables = {
      NPM_CONFIG_USERCONFIG = "${config.xdg.configHome}/npm/npmrc";
    };

    home.sessionPath = [ "${config.xdg.dataHome}/npm/bin" ];

    # TODO: tmp=${XDG_RUNTIME_DIR}/npm
    xdg.configFile."npm/npmrc".text = ''
      prefix=${config.xdg.dataHome}/npm
      cache=${config.xdg.cacheHome}/npm
      init-module=${config.xdg.configHome}/npm/config/npm-init.js
    '';
  };
}
