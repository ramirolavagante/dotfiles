{ config, pkgs, lib, ... }:

{
  home.stateVersion = "24.05";

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    shellAliases = {
      ll = "ls -la";
      gs = "git status";
      doom = "~/.emacs.d/bin/doom";
    };
  };

  programs.git.enable = true;

  home.packages = with pkgs; [
    bat
    fd
    ripgrep
    fzf
    tmux
    htop
    tree
  ];
}
