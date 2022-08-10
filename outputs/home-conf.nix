{ system, home-manager, ... }:

let
  mkHome = username: config: (
    home-manager.lib.homeManagerConfiguration rec {
      inherit system username;
      configuration = import config;

      stateVersion = "22.05";
      homeDirectory = "/home/${username}";
    });

in
{
  voxel = mkHome "voxel" ../home/voxel.nix;
  arina = mkHome "arina" ../home/arina.nix;
}
