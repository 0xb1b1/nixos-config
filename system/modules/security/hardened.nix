{ config, pkgs, modulesPath, ... }:

{
  imports = [
    "${modulesPath}/profiles/hardened.nix"
  ];
}
