{ config, pkgs, lib, ... }:

let
  doomCorePath = "${config.home.homeDirectory}/.config/emacs";
in
{
  home.stateVersion = "24.05";

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.git.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    shellAliases = {
      ll = "ls -la";
      gs = "git status";
      doom = "${doomCorePath}/bin/doom";
    };
  };


  home.packages = with pkgs; [
    # CLI tools (cross-platform via Nix)
    bat
    fd
    fzf
    graphviz
    htop
    neovim
    nodejs
    pandoc
    pdftk
    pwgen
    ripgrep
    tmux
    tree
    uv
    wget
  ];

  # Doom Emacs: install/update via scripts/post-install.sh after darwin-rebuild.
}
