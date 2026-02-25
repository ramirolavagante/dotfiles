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

  home.file.".vimrc".text = ''
    " --- sensible defaults ---
    set nocompatible
    filetype plugin indent on
    syntax on
    
    set number
    set hidden
    set mouse=a
    set clipboard=unnamed
    
    " --- indentation (tabs -> spaces) ---
    set expandtab
    set shiftwidth=2
    set tabstop=2
    set softtabstop=2
    set smartindent
    
    " --- nice editing ---
    set nowrap
    set linebreak
    set breakindent
    set undofile
    set ignorecase
    set smartcase
    set incsearch
    set hlsearch
    
    " --- visuals ---
    set termguicolors
    set cursorline
    set signcolumn=yes
    
    " --- extras ---
    " keep a bit of context above/below the cursor
    set scrolloff=5
    set sidescrolloff=5
    
    " cursor goes to new window
    set splitbelow
    set splitright
    
    " sensible per-language indentation overrides
    autocmd FileType python,go setlocal shiftwidth=4 tabstop=4 softtabstop=4
    Autocmd FileType make setlocal noexpandtab
    
    " command completion more like bash
    Set wildmode=longest:full,full
    " --- sensible defaults ---
    set nocompatible
    filetype plugin indent on
    syntax on

    set number
    set hidden
    set mouse=a
    set clipboard=unnamed

    " --- indentation (tabs -> spaces) ---
    set expandtab
    set shiftwidth=2
    set tabstop=2
    set softtabstop=2
    set smartindent

    " --- nice editing ---
    set nowrap
    set linebreak
    set breakindent
    set undofile
    set ignorecase
    set smartcase
    set incsearch
    set hlsearch

    " --- visuals ---
    set termguicolors
    set cursorline
    set signcolumn=yes
  '';

  # Doom Emacs: install/update via scripts/post-install.sh after darwin-rebuild.
}
