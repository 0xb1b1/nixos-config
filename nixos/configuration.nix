# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  # TODO: Change luks-abcdefgh-1bcd-a2cd-ab3d-123456abcdef to a viable UUID
  boot.initrd.luks.devices."luks-abcdefgh-1bcd-a2cd-ab3d-123456abcdef".device = "/dev/disk/by-uuid/luks-abcdefgh-1bcd-a2cd-ab3d-123456abcdef";
  boot.initrd.luks.devices."luks-abcdefgh-1bcd-a2cd-ab3d-123456abcdef".keyFile = "/crypto_keyfile.bin";

  networking.hostName = "nixos"; # TODO: Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";  # TODO: Use your TZ

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  ### SECURITY ###
  # Enable AppArmor.
  security.apparmor.enable = true;
  ### SECURITY ###

  # Enable Docker.
  virtualisation.docker.enable = true;

  # Configure keymap in X11.
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable the X11 windowing system and XFCE.
  #services.xserver = {
  #  enable = true;
  #  desktopManager = {
  #    xterm.enable = false;
  #    xfce.enable = true;
  #  };
  #displayManager.defaultSession = "xfce";
  #};

  # Enable the X11 windowing system and awesomeWM.
  services.xserver = {
    enable = true;
    # Configure a display manager.
    displayManager = {
      lightdm.enable = true;
      defaultSession = "none+awesome";
    };
    windowManager.awesome = {
      enable = true;
      luaModules = with pkgs.luaPackages; [
        luarocks # is the package manager for Lua modules
        luadbi-mysql # Database abstraction layer
      ];
    };
  };

  # Enable PipeWire
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.changeme = {  # CHANGEME: Use your username
    isNormalUser = true;
    description = "changeme";  # CHANGEME: Enter a description or just your username
    extraGroups = [ "networkmanager" "wheel" ];  # Group `docker` is not utilized since it's insecure
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim
    wget
    zsh
    lsof
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # TODO: Disable if unused
  services.openssh = {
    enable = true;
    permitRootLogin = "no";
    passwordAuthentication = false;
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22000 ];  # Syncthing, 
  networking.firewall.allowedUDPPorts = [ 22000 21027 ];  # Syncthing, Syncthing, 
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leavecatenate(variables, "bootdev", bootdev)
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

  # Set extra options
  nix.extraOptions = ''
    substitute = true  # Substitution = using cache instead of building packages
  '';
}
