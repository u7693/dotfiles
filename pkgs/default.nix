{ pkgs ? import <nixpkgs> {} }:

{
  cargo-atcoder = pkgs.callPackage ./cargo-atcoder.nix { };
}
