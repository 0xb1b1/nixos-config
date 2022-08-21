{ config, pkgs, modulesPath, ... }:

{
  imports = [
    "${modulesPath}/profiles/hardened.nix"
  ];

  # Make hardened profile more usable
  security = {
    allowUserNamespaces = true;              # Must be set to true for `nix build` to function (https://nixos.org/manual/nixos/stable/index.html#sec-profile-hardened)
    lockKernelModules = false;               # https://discourse.nixos.org/t/default-security-settings/9755
    allowSimultaneousMultithreading = true;  # Proposed by K900 <me@0upti.me>
  };
  environment.memoryAllocator.provider = "libc";  # Proposed by j-k <dev@j-k.io>
}
