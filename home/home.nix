{ pkgs, ...}: {
  # Install packages
  home.packages = with pkgs; [
    ### Tools ###
    kitty
    dmenu
    ranger
    sshfs
    unzip
    wget
    curl
    bpytop

    ### Programming languages ###
    python27
    python310
    rustc
    go
    gcc

    ### Sound ###
    pavucontrol
    #xfce.xfce4-pulseaudio-plugin

    ### Syncronization ###
    #syncthing # Enabled as a service
    
    ### Development ###
    vscodium-fhs
    
    ### Social ###
    element-desktop
    tdesktop
    thunderbird
    
    ### Browsers ###
    firefox
    tor-browser-bundle-bin
    
    ### Documents ###
    libreoffice-fresh

    ### Security ###
    keepassxc
    i3lock

    ### Downloads ###
    youtube-dl
    transmission
    hakuneko

    ### Media, streaming ###
    mpv
    ani-cli
    vlc
    
    ### Games ###
    minetest
    
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
  };

  # Manage programs
  programs = {
    git = {  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.git.signing
      enable = true;
      userName = "username";  # CHANGEME: Set your username
      userEmail = "email@address.example";  # CHANGEME: Set your email
      extraConfig = {
        init = {
          defaultBranch = "master";  # CHANGEME: Set your default branch (`main`, `master`, ...)
        };
      };
      signing = {
        key = "D2AC7A8F8CBF358416EF12ECF76D87C85967B1B1";  # CHANGEME: Set your own GnuPG key
	signByDefault = true;
      };
    };
  };
}
