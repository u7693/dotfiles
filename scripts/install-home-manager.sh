#! /usr/bin/env nix-shell
#! nix-shell -i bash -p bash

HOME_MANAGER="https://github.com/nix-community/home-manager/archive/master.tar.gz"

if [[ `nix-channel --list` != *"home-manager"* ]]; then
    nix-channel --add $HOME_MANAGER home-manager
    nix-channel --update

    . /etc/os-release
    if [[ $NAME != "NixOS" ]]; then
        export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH
        nix-shell '<home-manager>' -A install
    fi
fi
