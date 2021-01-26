{ pkgs, ... }:

with builtins;
let user = fromJSON (readFile ../../user.json);
in {
  imports = [ ../../home ];

  u7693.home = {
    shell.enable = true;
    git = {
      enable = true;
      userName = user.name;
      userEmail = user.email;
      userSigningKey = user.gpg;
    };
    cargo-atcoder = {
      enable = true;
      config = builtins.readFile ./cargo-atcoder.toml;
    };
    lorri.enable = true;
    nodejs.enable = true;
    rust.enable = true;
  };

  home.packages = with pkgs; [
    asciinema
    exercism
  ];
}
