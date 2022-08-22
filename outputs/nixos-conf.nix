{ lib, inputs, system, ... }:

{
  shadow-nix = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs; };
    modules = [
      ../system/hosts/shadow-nix
      ../system/configuration.nix
      inputs.sops-nix.nixosModules.sops
    ];
  };

  outline = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs; };
    modules = [
      ../system/hosts/outline
      ../system/configuration.nix
      inputs.sops-nix.nixosModules.sops
      ./modules/laptop
    ];
  };
}
