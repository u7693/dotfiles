#! /usr/bin/env nix-shell
#! nix-shell -i bash -p bash stow

DISTRO_DIR=$(cd $(dirname $0) && cd .. && pwd)
HOME_MANAGER_DIR="${HOME}/.config/nixpkgs"

stow -d $DISTRO_DIR -t  $HOME_MANAGER_DIR -v helium
