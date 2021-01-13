{ config, lib, pkgs, ... }:

with lib;
let cfg = config.services.xserver.gnome3;
in {
  options = {
    services.xserver.gnome3 = {
      enable = mkEnableOption "GNOME 3";
    };
  };

  config = mkIf cfg.enable {
    services.xserver.enable = true;
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome3.enable = true;
  };
}
