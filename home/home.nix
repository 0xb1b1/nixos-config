{ pkgs, ...}: {
  # Install packages
  home.packages = with pkgs; [
    ### Tools ###
    home-manager
    kitty
    cool-retro-term
    dmenu
    ranger
    xfce.thunar
    xfce.tumbler
    gthumb
    sshfs
    unzip
    wget
    curl
    fakeroot
    rsync
    bat
    scrot
    #gnupg
    feh
    #networkmanagerapplet
    gotop
    #bpytop
    pinentry-curses
    appimage-run

    ### Development ###
    gnumake
    cmake
    rustup
    maturin
    gcc
    python27
    python310
    go
    nodejs
    nodePackages.npm
    nodePackages.vue-cli
    kubectl

    ### Linters ###
    rust-analyzer
    #vimPlugins.coc-rust-analyzer

    ### Pwning ###
    inetutils
    samba
    redis
    gobuster
    mariadb
    postgresql

    ### Sound ###
    pavucontrol
    #xfce.xfce4-pulseaudio-plugin

    ### Security ###


    ### Encryption ###
    cryptomator

    ### Syncronization ###
    #syncthing # Enabled as a service
    
    ### Development ###
    vscodium-fhs
    emacs

    ### OSINT ###
    nmap  # Network enumeration tool
    dnsrecon  # DNS enumeration tool

    ### Customization ###
    cascadia-code

    ### Identity ###
    keybase

    ### Social ###
    element-desktop
    threema-desktop
    #tdesktop
    telegram-cli
    kotatogram-desktop
    thunderbird
    
    ### Browsers ###
    librewolf
    tor-browser-bundle-bin
    lynx

    ### Documents ###
    libreoffice-fresh

    ### Media editing ###
    darktable
    libsForQt5.kdenlive
    handbrake

    ### Security ###
    keepassxc
    i3lock

    ### Filesharing ###
    ipfs
    transmission-gtk

    ### Downloads ###
    youtube-dl
    hakuneko

    ### Media, streaming ###
    mpv
    ani-cli
    vlc

    ### Recording ###
    obs-studio
    asciinema

    ### Cryptocurrency ###
    trezord
    # trezor-suite - unfree license!

    ### Games ###
    minetest
    polymc  # Downloads non-free Minecraft (compiled) JAR-file!

    ### Showing off ###
    neofetch
    uwufetch
  ];
  
  # Manage services
  services = {
    syncthing = {
      enable = true;
      #tray.enable = true;  # systemctl can't find tray.target
    };
    keybase = {
      enable = true;
    };
    gpg-agent = {
      enable = true;
      enableSshSupport = true;
      #enableExtraSocket = true;
      pinentryFlavor = "curses";
      defaultCacheTtl = 34560000;
      defaultCacheTtlSsh = 34560000;
      maxCacheTtl = 34560000;
      maxCacheTtlSsh = 34560000;
      extraConfig = "display :0";
    };
  };

  # Manage programs
  programs.gpg = {
    enable = true;
  };
  programs = {
    zsh = {  # From https://www.reddit.com/r/NixOS/comments/jlcckh/comment/gap2tdk/?utm_source=share&utm_medium=web2x&context=3
      enable = true;
      enableCompletion = false;  # Enabled in oh-my-zsh
      initExtra = ''
        test -f ~/.dir_colors && eval $(dircolors ~/.dir_colors)
      '';
      shellAliases = {
        #doas = "sudo";  # using doas by default
	#docker = "sudo docker";  # using rootless podman
      };
      oh-my-zsh = {
        enable = true;
	plugins = [ "git" "systemd" "rsync" "kubectl" ];
	theme = "terminalparty";  # terminalparty eastwood fishy
      };
      enableSyntaxHighlighting = true;
      enableAutosuggestions = true;
      envExtra = ''
        source $HOME/.config/env
      '';
      history = {
        #path = "$HOME/.local/share/zsh/history";  # Doesn't seem to work
        extended = true;
        ignoreDups = true;  # true by default
        save = 500000;  # Number of lines to save
        size = 500000;  # Number of history lines to keep
      };
    };
    #ssh = {  # TODO: Fix
    #  startAgent = true;
    #};
    git = {  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.git.signing
      enable = true;
      userName = "0xb1b1";
      userEmail = "voxelflee@protonmail.com";
      extraConfig = {
        init = {
          defaultBranch = "master";
        };
      };
      signing = {
        key = "D2AC7A8F8CBF358416EF12ECF76D87C85967B1B1";
	signByDefault = true;
      };
    };
    neovim = {
      enable = true;
      plugins = with pkgs.vimPlugins; [ coc-rust-analyzer ];
    };
  };
}

