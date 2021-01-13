{ config, lib, pkgs, ... }:

with builtins;
let
  user = fromJSON (readFile ../../user.json);

  aliases = {
    lg = "log --oneline --graph";
    st = "status --short --branch";
  };

  ignores = import ./git-ignores.nix;
in
{
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.git.enable
  programs.git = {
    enable = true;
    inherit aliases ignores;
    signing.key = user.gpg;
    userEmail = user.email;
    userName = user.name;
  };
}
