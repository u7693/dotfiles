{ pkgs, ... }:

{
  imports = [ ./home ];

  u7693.home.dev = {
    cargo-atcoder.enable = true;
    lorri.enable = true;
    nodejs.enable = true;
    rust.enable = true;
  };

  home.packages = with pkgs; [
    asciinema
    exercism
  ];
}
