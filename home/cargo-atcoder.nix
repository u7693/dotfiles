{ config, lib, pkgs, ... }:

with lib;
let cfg = config.u7693.home.cargo-atcoder;
in {
  options = {
    u7693.home.cargo-atcoder = {
      enable = mkEnableOption "cargo-atcoder";

      config = mkOption {
        type = types.lines;
        default = readFile ./cargo-atcoder.toml;
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.u7693.cargo-atcoder ];

    xdg.configFile."cargo-atcoder.toml".text = cfg.config;
  };
}
