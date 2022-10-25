{ lib, inputs, system, ... }:

{
  shadow-nix = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs; };
    modules = [
      ../system/hosts/shadow-nix
      ../system/configuration.nix
      ./modules/nix/compile
      inputs.sops-nix.nixosModules.sops
      inputs.vscode-server.nixosModule
    ];
  };

  outline = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs; };
    modules = [
      ../system/hosts/outline
      ../system/configuration.nix
      ./modules/nix/substitute
      inputs.sops-nix.nixosModules.sops
      ./modules/laptop
    ];
  };
}
