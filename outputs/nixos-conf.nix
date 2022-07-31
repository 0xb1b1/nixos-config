{ lib, inputs, system, ... }:

{
  outline = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs; };
    modules = [
      ../system/machine/outline
      ../system/configuration.nix
    ];
  };

  shadow-nix = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs; };
    modules = [
      ../system/machine/shadow-nix
      ../system/configuration.nix
    ];
  };
}
