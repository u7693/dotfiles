{ config, lib, pkgs, ... }:

with lib;
let cfg = config.u7693.home.rust;
in {
  options = {
    u7693.home.rust = {
      enable = mkEnableOption "Rust";

      rustupHome = mkOption {
        type = types.str;
        default = "${config.xdg.dataHome}/rustup";
      };

      cargoHome = mkOption {
        type = types.str;
        default = "${config.xdg.dataHome}/cargo";
      };

      wasm  = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      gcc
      rustup
    ] ++ optionals cfg.wasm [
      cargo-generate
      wasm-pack
    ];

    home.sessionVariables = {
      RUSTUP_HOME = cfg.rustupHome;
      CARGO_HOME  = cfg.cargoHome;
    };

    home.sessionPath = [ "${cfg.cargoHome}/bin" ];
  };
}
