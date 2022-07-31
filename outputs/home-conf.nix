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

in
{
  main = home-manager.lib.homeManagerConfiguration rec {
    inherit pkgs system username homeDirectory;

    stateVersion = "22.05";
    configuration = import ./home.nix {
      inherit (pkgs) config lib stdenv;
    };
  };
}
