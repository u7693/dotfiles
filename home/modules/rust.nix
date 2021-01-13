{ config, lib, pkgs, ... }:

with lib;
let cfg = config.programs.rust;
in {
  options = {
    programs.rust = {
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
