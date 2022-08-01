{ system, nixpkgs, home-manager, ... }:

let
  username = "voxel";
  homeDirectory = "/home/${username}";
  configHome = "${homeDirectory}/.config";

  pkgs = import nixpkgs {
    inherit system;

    config.allowUnfree = false;
    config.xdg.configHome = configHome;

    #overlays = [  ];
  };

  mkVoxelHome = { }: (
    home-manager.lib.homeManagerConfiguration rec {
      inherit pkgs;  # Panics at [required] system username homeDirectory configuration <- configuration not defined
      modules = [
        {
          imports = [ ../home/home.nix ];
        }
        {
          home = {
            inherit username homeDirectory;
            stateVersion = "22.05";
          };
        }
      ];
    });

in
{
  voxel = mkVoxelHome { };
}
