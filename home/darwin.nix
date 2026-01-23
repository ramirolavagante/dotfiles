{ config, pkgs, lib, ... }:

let
  doomConfigPath = "/Users/rodelrod/code/doom-emacs";
in
{
  home.file.".config/doom".source = doomConfigPath;

  home.activation.doomConfigUpdate = lib.mkAfter ''
    echo "Checking Doom Emacs config repo at ${doomConfigPath}..."

    if [ ! -d "${doomConfigPath}/.git" ]; then
      echo "Cloning Doom Emacs config repo..."
      git clone https://github.com/rodelrod/doom-emacs.git "${doomConfigPath}"
    else
      echo "Updating Doom Emacs config repo..."
      git -C "${doomConfigPath}" pull --ff-only
    fi
  '';
}
