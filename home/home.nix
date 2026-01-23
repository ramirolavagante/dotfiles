{ config, pkgs, lib, ... }:

let
  shared = import ./shared.nix;
  darwin = import ./darwin.nix;
  linux = import ./linux.nix;

  hostConfigModule = if pkgs.stdenv.isDarwin then darwin else linux;
in
{
  imports = [
    shared
    hostConfigModule
  ];
}
