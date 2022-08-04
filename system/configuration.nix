# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, modulesPath, ... }:

{
  imports =  [
    "${modulesPath}/profiles/hardened.nix"
  ];

  # Make hardened profile more usable        # This should be enabled alongside the hardened profile
  security.allowUserNamespaces = true;       # Must be set to true for `nix build` to function (https://nixos.org/manual/nixos/stable/index.html#sec-profile-hardened)
  security.lockKernelModules = false;        # https://discourse.nixos.org/t/default-security-settings/9755
  #security.hideProcessInformation = false;  # -^ [ErrLog: The hidepid module was removed, since the underlying machinery is broken when using cgroups-v2.]

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure networking.
  networking.networkmanager = {
    enable = true;
    insertNameservers = [ "1.1.1.1" "1.0.0.1" ];
  };

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  ### SECURITY ###
  # Enable AppArmor.
  security.apparmor.enable = true;
  ### SECURITY ###

  # Enable Docker.
  virtualisation.docker.enable = true;

  # Enable Podman.  # Docker is temporarily preferred due to Podman requiring OCI-Containers SystemD service to run (too complex for me at the moment)
  # TODO: Re-enable Podman with OCI-Containers SystemD services
  # virtualisation.podman = {
  #   enable = true;
  #   dockerCompat = true;
  #   defaultNetwork = {
  #     dnsname.enable = true;
  #   };
  #   dockerSocket.enable = true;
  # };

  # Enable libvirt (KVM).
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;

  # User settings.
  users.mutableUsers = false;
  boot.kernelParams = [ "nohibernate" ];

  # Configure keymap in X11.
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

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

  # Enable PipeWire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Define user accounts.
  users.users = {
    voxel = {
      isNormalUser = true;
      description = "voxel";
      extraGroups = [ "networkmanager" "wheel" "libvirtd" "docker" "adbusers" ];
      shell = pkgs.zsh;
      hashedPassword = "$6$cQWJCPMwSqsbh9r$xhnVcK.SONgK7P60uNPaJjoAtXXZdKbuy7YpKGzabWJuOte8LVNjNk4lTHEwvtX5SKagTgr24qwFxNkc3HRWY0";
    };
  };

  # Configure sudo. (required my minikube)
  security.sudo.enable = true;
  security.sudo.extraRules = [
    {
      users = [ "voxel" ];
      commands = [
        {
         command = "ALL";
         options = [ "NOPASSWD" ];
        }
      ];
    }
  ];

  # Configure doas.
  security.doas = {
    enable = true;
    extraRules = [
      {
        users = [ "voxel" ];
	noPass = true;
	keepEnv = true;
      }
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    gcc
    neovim
    wget
    zsh
    lsof
    virt-manager
    #podman-compose
    dnsname-cni
    minikube
    shadowsocks-rust
    openvpn
  ];

  # Add udev rules.
  services.udev.packages = with pkgs; [
    trezor-udev-rules
    android-udev-rules
  ];

  # Enable android-tools.
  programs.adb.enable = true;

  # Enable gcr on dbus for gnome pinentry.
  #services.dbus.packages = [ pkgs.gcr ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  services.pcscd.enable = true;

  # List services that you want to enable:

  # Open ports in the firewall.
  # [Services list]
  networking.firewall.allowedTCPPorts = [  ];

  # [Services list]
  networking.firewall.allowedUDPPorts = [  ];

  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leavecatenate(variables, "bootdev", bootdev)
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

  # Install flakes
  nix = {
    # Enable Flakes.
    package = pkgs.nixFlakes;
    # Set extra options
    # (substituting is equal to using cache instead of building packages).
    extraOptions = ''
    substitute = true
    experimental-features = nix-command flakes
    '';
  };

  # Add extra lines in /etc/hosts.
  networking.extraHosts = ''
    127.0.0.1 host0.local
    127.0.0.1 host1.local
    127.0.0.1 host2.local
    127.0.0.1 host3.local
    127.0.0.1 host4.local
  '';
}
