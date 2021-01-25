{ config, lib, pkgs, ... }:

with lib; with builtins;
let
  cfg = config.u7693.nixos.user;

  user = fromJSON (readFile ../user.json);

in {
  options = {
    u7693.nixos.user = {
      enable = mkEnableOption "user";
    };
  };

  config = mkIf cfg.enable {
    users.users.u7693 = {
      home = "/home/" + user.username;
      name = user.username;
      createHome = true;
      description = user.name;
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };
  };
}
