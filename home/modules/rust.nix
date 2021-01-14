{ config, lib, pkgs, ... }:

with lib;
let cfg = config.u7693.home.dev.rust;
in {
  options = {
    u7693.home.dev.rust = {
      enable = mkEnableOption "Rust";

      rustupHome = mkOption {
        type = types.str;
        default = "${config.xdg.dataHome}/rustup";
      };

      cargoHome = mkOption {
        type = types.str;
        default = "${config.xdg.dataHome}/cargo";
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ gcc rustup ];

    home.sessionVariables = {
      RUSTUP_HOME = cfg.rustupHome;
      CARGO_HOME  = cfg.cargoHome;
    };

    home.sessionPath = [ "${cfg.cargoHome}/bin" ];
  };
}
