{ config, lib, pkgs, ... }:

with lib; with builtins;
let cfg = config.u7693.nixos.user;
in {
  options = {
    u7693.nixos.user = {
      enable = mkEnableOption "user";
    };

    userName = mkOption {
      type = types.nullOr types.str;
      default = null;
    };

    description = mkOption {
      type = types.nullOr types.str;
      default = null;
    };
  };

  config = mkIf cfg.enable {
    users.users.u7693 = {
      home = "/home/" + cfg.userName;
      name = cfg.userName;
      createHome = true;
      description = cfg.description;
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };
  };
}
