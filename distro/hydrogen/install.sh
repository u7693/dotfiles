#! /usr/bin/env nix-shell
#! nix-shell -i bash -p bash stow

DISTRO_DIR=$(cd $(dirname $0) && cd .. && pwd)
NIXOS_DIR="/mnt/etc/nixos"

rm "${NIXOS_DIR}/configuration.nix"
cp "${NIXOS_DIR}/hardware-configuration.nix" "$DISTRO_DIR/hydrogen/"
rm "${NIXOS_DIR}/hardware-configuration.nix"
stow -d $DISTRO_DIR -t  $NIXOS_DIR -v hydrogen
