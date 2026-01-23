{
  description = "Cross-platform Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      mkSystem = { system, username, homeDirectory, hostConfigModule, cudaSupportIfApplies }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { 
            inherit system; 
            config = cudaSupportIfApplies // { allowUnfree = true; };
          };
          modules = [
            ./home/home.nix
            hostConfigModule
            {
              home.username = username;
              home.homeDirectory = homeDirectory;
              home.stateVersion = "24.05";
            }
          ];
        };

    in {
      homeConfigurations = {
        rodelrod-darwin = mkSystem {
          system = "aarch64-darwin";
          username = "rodelrod";
          homeDirectory = "/Users/rodelrod";
          hostConfigModule = ./home/darwin.nix;
          cudaSupportIfApplies = { cudaSupport = false; };
        };

        rodelrod-linux = mkSystem {
          system = "x86_64-linux";
          username = "rodelrod";
          homeDirectory = "/home/rodelrod";
          hostConfigModule = ./home/linux.nix;
          cudaSupportIfApplies = { cudaSupport = true ; };
        };
      };
    };
}
