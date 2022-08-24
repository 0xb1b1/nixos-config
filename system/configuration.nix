# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, modulesPath, ... }:

{
  imports = [
    ./modules
  ];

  # Configure networking.
  networking.networkmanager = {
    enable = true;
    #insertNameservers = [ "1.1.1.1" "1.0.0.1" ];  # Configure in host configs
  };

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Enable libvirt (KVM).
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;

  boot.kernelParams = [ "nohibernate" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    sops
    age
    git
    gcc
    neovim
    wget
    zsh
    lsof
    virt-manager
    podman-compose
    dnsname-cni
    minikube
    shadowsocks-rust
    openvpn
    ntfs3g
    proot
    protontricks
  ];

  # Add udev rules.
  services.udev.packages = with pkgs; [
    trezor-udev-rules
    android-udev-rules
  ];

  # Enable android-tools.
  programs.adb.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  services.pcscd.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leavecatenate(variables, "bootdev", bootdev)
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

  # Add extra lines in /etc/hosts.
  networking.extraHosts = ''
    127.0.0.1 host0.local
    127.0.0.1 host1.local
    127.0.0.1 host2.local
    127.0.0.1 host3.local
    127.0.0.1 host4.local
  '';
}
