{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.u7693.home.shell;

  shellAliases = {
    # https://github.com/ogham/exa
    ls = "exa";
    ll = "exa -alFh --git --time-style=long-iso";
    lt = "exa -T --git-ignore";

    # safety
    cp = "cp -i";
    mv = "mv -i";
    rm = "rm -i";

    # misc
    mkdir = "mkdir -p";
    path = "echo -e \${PATH//:/\\\\n}";
    nixpath = "echo -e \${NIX_PATH//:/\\\\n}";
  };

  zshPluginPure = {
    name = "pure";
    src = pkgs.fetchFromGitHub {
      owner = "sindresorhus";
      repo = "pure";
      rev = "v1.16.0";
      sha256 = "1wsmv32pdcs0y5xq4537v66bijgnblj04bqa2k2pwja0nja3hyby";
    };
  };

in {
  options = {
    u7693.home.shell = {
      enable = mkEnableOption "shell";
    };
  };

  config = mkIf cfg.enable {
    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.zsh.enable
    programs.zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      enableVteIntegration = true;
      autocd = true;
      defaultKeymap = "emacs";
      dotDir = ".config/zsh";
      history.path = "${config.xdg.dataHome}/zsh/zsh_history";
      initExtra = ''
        autoload -U promptinit; promptinit
        prompt pure
      '';
      plugins = [ zshPluginPure ];
      envExtra = ''
        # Nix
        if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then
          . $HOME/.nix-profile/etc/profile.d/nix.sh
        fi
      '';
      inherit shellAliases;
    };

    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.bat.enable
    programs.bat.enable = true;

    # https://rycee.gitlab.io/home-manager/options.html#opt-home.packages
    home.packages = with pkgs; [ exa fd ripgrep ];
  };
}
