{ system, nixpkgs, home-manager, ... }:

let
  username = "voxel";
  homeDirectory = "/home/${username}";
  configHome = "${homeDirectory}/.config";

  pkgs = import nixpkgs {
    inherit system;

    config.allowUnfree = false;
    config.xdg.configHome = configHome;

    overlays = [  ];
  };

  mkHome = { hidpi ? false }: (
    home-manager.lib.homeManagerConfiguration rec {
      inherit pkgs;
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
  voxel-edp = mkHome { hidpi = false; };
  voxel-hdmi = mkHome { hidpi = true; };
}
