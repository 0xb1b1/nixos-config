{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-amd" "amdgpu" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/60f9c3c8-79b5-4fc5-bab0-70f02ef511fc";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-ed063466-3ef8-44f4-9f79-09ac281da778".device = "/dev/disk/by-uuid/ed063466-3ef8-44f4-9f79-09ac281da778";

  fileSystems."/boot/efi" =
    { device = "/dev/disk/by-uuid/8019-6507";
      fsType = "vfat";
    };

  swapDevices =
    [
      {
        device = "/dev/disk/by-uuid/c7f8081e-f426-4469-b056-5a24191b0c9f";
        priority = 100;
      }
      {
        device = "/swapfile";
        priority = 0;
        size = 8192;
      }
    ];

  # Setup keyfile.
  boot.initrd = {
    secrets = {
      "/crypto_keyfile.bin" = null;
    };
  };

  # Enable swap on LUKS.
  boot.initrd.luks.devices."luks-aaff553d-5b8e-4cf7-89be-2238e473b503".device = "/dev/disk/by-uuid/aaff553d-5b8e-4cf7-89be-2238e473b503";
  boot.initrd.luks.devices."luks-aaff553d-5b8e-4cf7-89be-2238e473b503".keyFile = "/crypto_keyfile.bin";

  # Mount drives.
  # Load LUKS keyfiles (https://gitlab.utc.fr/huetremy/nixos/-/blob/master/hardware-configuration.nix.example)
  boot.initrd.secrets =
    { "wd1tb-001.key" = "/root/keys/wd1tb-001.key";
      "wd3tb-001.key" = "/root/keys/wd3tb-001.key";
      "wd6tb-001.key" = "/root/keys/wd6tb-001.key";
    };
  #region WD3TB-001
  fileSystems."/mnt/wd3tb-001" =
    { device = "/dev/disk/by-uuid/430f490f-9439-48e6-b09b-0000723d7697";
      fsType = "ext4";
    };
  boot.initrd.luks.devices."wd3tb-001" =
    { device = "/dev/disk/by-uuid/bcc81913-2d40-4320-a1e3-c0732dee0884";
      keyFile = "wd3tb-001.key";
    };
  #endregion
  #region WD6TB-001
  fileSystems."/mnt/wd6tb-001" =
    { device = "/dev/disk/by-uuid/0ef2fa05-e678-496f-b6e2-0df2de1b612a";
      fsType = "ext4";
    };
  boot.initrd.luks.devices."wd6tb-001" =
    { device = "/dev/disk/by-uuid/c4cd2373-4930-402e-8f94-1a353a527056";
      keyFile = "wd6tb-001.key";
    };
  #endregion

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  #networking.useDHCP = lib.mkDefault true;  # DHCP enabled on per-device basis in ./default.nix.
  # networking.interfaces.br-c24e58b84a50.useDHCP = lib.mkDefault true;
  # networking.interfaces.docker0.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno1.useDHCP = lib.mkDefault true;
  # networking.interfaces.veth55f9a96.useDHCP = lib.mkDefault true;
  # networking.interfaces.vethb4255ff.useDHCP = lib.mkDefault true;

  # TODO: Add a description
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  # Enable high-definition display.
  hardware.video.hidpi.enable = lib.mkDefault true;
}
