{
  description = "Home Manager (dotfiles) and NixOS configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.05";

    home-manager = {
      url = github:nix-community/home-manager/release-22.05;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, home-manager }:
  let
    system = "x86_64-linux";
  in
  {
    homeConfigurations = (
      import ./outputs/home-conf.nix {
        inherit system nixpkgs home-manager;
      }
    );

    nixosConfigurations = (
      import ./outputs/nixos-conf.nix {
        inherit (nixpkgs) lib;
        inherit inputs system;
      }
    );

    devShell.${system} = (
      import ./outputs/installation.nix {
        inherit system nixpkgs;
      }
    );
  };
}