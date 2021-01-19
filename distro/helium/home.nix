{ pkgs, ... }:

{
  imports = [ ./home ];

  u7693.home.dev = {
    lorri.enable = true;
    nodejs.enable = true;
    rust.enable = true;
  };

  home.packages = with pkgs; [
    asciinema
    exercism
  ];
}
