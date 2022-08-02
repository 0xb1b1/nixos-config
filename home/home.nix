{ pkgs, ...}:

let
  toolPkgs = with pkgs; [
    ### Tools ###
    #home-manager            # Reconfigure a user environment
    alacritty               # Fast, cross-platform, OpenGL terminal emulator written in Rust
    cool-retro-term         # Cool Retro Terminal emulator
    dmenu                   # Dynamic GUI menu
    tree                    # List contents of directories in a tree-like format
    ranger                  # Visual file manager written in Python
    xfce.thunar             # File Manager for the Xfce Desktop Environment
    xfce.tumbler            # Thumbnail generator for the Xfce Desktop Environment
    gthumb                  # Image viewer and browser for GNOME
    sshfs                   # Filesystem client based on SSH
    zip                     # Package and compress (archive) files
    unzip                   # List, test and extract compressed files in a ZIP archive
    wget                    # Non-interactive network downloader
    curl                    # Transfer a URL
    fakeroot                # Faking root privileges for file manipulation
    rsync                   # File-copying tool
    bat                     # `cat` clone with syntax highlighting and Git integration
    scrot                   # CLI screen capture utility
    feh                     # Image viewer and cataloguer
    ffmpeg                  # Video converter
    htop                    # TUI system resource visualizer
    gotop                   # TUI system resource visualizer
    appimage-run            # AppImage executor
    glow                    # Markdown CLI renderer
  ];

  devPkgs = with pkgs; [
    ### Development ###
    gnumake                 # Development environment automatization
    cmake                   # Family of tools designed to build, test and package software
    rustup                  # Rust toolchain installer
    maturin                 # Build and publish Rust crates Python packages
    gcc                     # GNU Compiler Collection
    python27                # High-level dynamically-typed programming language
    python310               # High-level dynamically-typed programming language
    go                      # The Go Programming language
    nodejs                  # Event-driven I/O framework for the V8 JavaScript engine
    nodePackages.npm        # Package manager for JavaScript
    nodePackages.vue-cli    # Simple CLI for scaffolding Vue.js projects
    kubectl                 # Kubernetes CLI
    vscodium-fhs            # Wrapped variant of vscodium which launches in a FHS compatible envrionment
    emacs                   # The extensible, customizable GNU text editor
    android-tools           # Android SDK platform tools
    drone-cli               # Command line client for the Drone continuous integration server
  ];

  lintPkgs = with pkgs; [
    ### Linters ###
    rust-analyzer           # 
    #vimPlugins.coc-rust-analyzer
  ];

  pwnPkgs = with pkgs; [
    ### Pwning ###
    inetutils               # 
    samba                   # 
    redis                   # 
    gobuster                # 
    mariadb                 # 
    postgresql              # 
  ];

  revEngineeringPkgs = with pkgs; [
    ### Reverse-engineering ###
    hexyl                 # Hex file viewer
  ];

  soundPkgs = with pkgs; [
    ### Sound ###
    pavucontrol             # 
    #xfce.xfce4-pulseaudio-plugin
  ];

  secPkgs = with pkgs; [
    ### Security ###
    keepassxc               # 
    i3lock                  # 
  ];

  encPkgs = with pkgs; [
    ### Encryption ###
    cryptomator             # 
  ];

  syncPkgs = with pkgs; [
    ### Syncronization ###
    #syncthing              # Enabled as a service
  ];

  osintPkgs = with pkgs; [
    ### OSINT ###
    nmap                    # Network enumeration tool
    dnsrecon                # DNS enumeration tool
  ];

  fontPkgs = with pkgs; [
    ### Fonts ###
    cascadia-code           # 
  ];

  identPkgs = with pkgs; [
    ### Identity ###
    keybase                 # 
  ];

  socialPkgs = with pkgs; [
    ### Social ###
    element-desktop         # 
    threema-desktop         # 
    #tdesktop               # 
    telegram-cli            # 
    kotatogram-desktop      # 
    thunderbird             # 
  ];

  browserPkgs = with pkgs; [
    ### Browsers ###
    firefox                 # 
    #librewolf              # 
    #chromium               # 
    tor-browser-bundle-bin  # 
    lynx                    # 
  ];

  docPkgs = with pkgs; [
    ### Documents ###
    libreoffice-fresh       # 
  ];

  mediaEditPkgs = with pkgs; [
    ### Media editing ###
    darktable               # 
    libsForQt5.kdenlive     # 
    handbrake               # 
  ];

  fileSharingPkgs = with pkgs; [
    ### Filesharing ###
    ipfs                    # 
    transmission-gtk        # 
  ];

  dlPkgs = with pkgs; [
    ### Downloads ###
    youtube-dl              # 
    hakuneko                # 
  ];

  mediaViewPkgs = with pkgs; [
    ### Media, streaming ###
    mpv                     # 
    ani-cli                 # 
    vlc                     # 
  ];

  recPkgs = with pkgs; [
    ### Recording ###
    asciinema               # 
  ];

  cCurrPkgs = with pkgs; [
    ### Cryptocurrency ###
    trezord                 # 
    # trezor-suite - unfree license!
  ];

  gamePkgs = with pkgs; [
    ### Games ###
    minetest                # 
    polymc                  # Downloads non-free Minecraft (compiled) JAR-file!
  ];

  showPkgs = with pkgs; [
    ### Showing off ###
    neofetch                # 
    uwufetch                # 
  ];

  laptopPkgs = with pkgs; [
    acpi                    # 
    light                   # 
  ];

  nonFreePkgs = with pkgs; [
    ### Nonfree ###
    rustdesk                # [NONFREEDEP]
    trezor-suite            # [NONFREE?]
  ];

in {
  programs.home-manager.enable = true;

  # Install packages
  home = {
    # Add "++ laptopPkgs" if running on a laptop
    packages = toolPkgs ++ devPkgs ++ lintPkgs ++ pwnPkgs ++
      revEngineeringPkgs ++ soundPkgs ++ secPkgs ++ encPkgs ++
      syncPkgs ++ osintPkgs ++ fontPkgs ++ identPkgs ++ socialPkgs ++
      browserPkgs ++ docPkgs ++ mediaEditPkgs ++ fileSharingPkgs ++
      dlPkgs ++ mediaViewPkgs ++ recPkgs ++ cCurrPkgs ++ gamePkgs ++
      showPkgs;
    sessionVariables = {
      DISPLAY = ":0";
      EDITOR = "nvim";
    };
  };

  xdg.enable = true;

  # Manage services
  services = {
    syncthing = {
      enable = true;
      #tray.enable = true;  # systemctl can't find tray.target
    };

    keybase = {
      enable = false;
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
  programs = {
    gpg.enable = true;

    zsh = {  # From https://www.reddit.com/r/NixOS/comments/jlcckh/comment/gap2tdk/?utm_source=share&utm_medium=web2x&context=3
      enable = true;
      enableCompletion = false;  # Enabled in oh-my-zsh
      initExtra = ''
        test -f ~/.dir_colors && eval $(dircolors ~/.dir_colors)
        test -f ~/.config/term/ls_colors && source ~/.config/term/ls_colors
      '';
      shellAliases = {
        #doas = "sudo";  # using doas by default
        #docker = "sudo docker";
        git-push = "git remote | xargs -L1 git push --all";  # push all branches to all remotes
        git-push-master = "git remote | xargs -L1 -I R git push R master"; # push "master" branch to all remotes
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
        extended = true;
        ignoreDups = true;  # true by default
        save = 500000;  # Number of lines to save
        size = 500000;  # Number of history lines to keep
      };
    };

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

    obs-studio = {
      enable = true;
      plugins = [];
    };
  };
}
