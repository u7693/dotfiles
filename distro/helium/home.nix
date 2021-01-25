{ pkgs, ... }:

{
  imports = [ ./home ];

  u7693.home = {
    shell.enable = true;
    git.enable = true;
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
