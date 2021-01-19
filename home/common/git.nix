{ config, lib, pkgs, ... }:

with builtins;
let
  user = fromJSON (readFile ../../user.json);

  aliases = {
    lg = "log --oneline --graph";
    st = "status --short --branch";
  };

  extraConfig = {
    init.defaultBranch = "main";
  };

  ignores = import ./git-ignores.nix;
in
{
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.git.enable
  programs.git = {
    enable = true;
    inherit aliases extraConfig ignores;
    signing.key = user.gpg;
    userEmail = user.email;
    userName = user.name;
  };

  home.packages = [ pkgs.gitAndTools.gitflow ];
}
