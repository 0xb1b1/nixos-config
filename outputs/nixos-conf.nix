{ lib, inputs, system, ... }:

{
  outline = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs; };
    modules = [
      ../system/hosts/outline
      ../system/configuration.nix
      inputs.sops-nix.nixosModules.sops
    ];
  };

  shadow-nix = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs; };
    modules = [
      ../system/hosts/shadow-nix
      ../system/configuration.nix
      inputs.sops-nix.nixosModules.sops
    ];
  };
}
