
{ config, pkgs, lib, ... }:

{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    gcc
    gnumake
    nerd-fonts.jetbrains-mono
    source-code-pro
    source-sans
  ];
}
