{ pkgs, ...}:

let
  toolPkgs = with pkgs; [
    ### Tools ###
    # home-manager            # Reconfigure a user environment
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
    tea                     # Gitea official CLI client
    file                    # Program that shows the type of files
    gnome.gnome-tweaks      # Gnome 3 DE tweaking tool
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
    go                      # Go Programming language
    nodejs                  # Event-driven I/O framework for the V8 JavaScript engine
    nodePackages.npm        # Package manager for JavaScript
    nodePackages.vue-cli    # Simple CLI for scaffolding Vue.js projects
    # kubectl                 # Kubernetes CLI
    vscodium-fhs            # Wrapped variant of vscodium which launches in a FHS compatible envrionment
    # emacs                   # Extensible, customizable GNU text editor
    # drone-cli               # Command line client for the Drone continuous integration server
    # openjdk16-bootstrap     # AdoptOpenJDK, prebuilt OpenJDK binary
  ];

  lintPkgs = with pkgs; [
    ### Linters ###
    rust-analyzer           # Modular compiler frontend for the Rust language
    # vimPlugins.coc-rust-analyzer
  ];

  pwnPkgs = with pkgs; [
    ### Pwning ###
    # gobuster                # Tool used to brute-force URIs, DNS subdomains, Virtual Host names on target web servers
    # inetutils               # Collection of common network programs
    # samba                   # Standard Windows interoperability suite of programs for Linux and Unix
    # redis                   # Open source, advanced key-value store
    # mariadb                 # Enhanced, drop-in replacement for MySQL
    # postgresql              # Powerful, open source object-relational database system
    # sqlmap                  # Automatic SQL injection and database takeover tool
  ];

  revEngineeringPkgs = with pkgs; [
    ### Reverse-engineering ###
    # hexyl                 # Hex file viewer
  ];

  soundPkgs = with pkgs; [
    ### Sound ###
    pavucontrol             # PulseAudio Volume Control
  ];

  secPkgs = with pkgs; [
    ### Security ###
    keepassxc               # Offline password manager with many features
    i3lock                  # Simple screen locker like slock
  ];

  encPkgs = with pkgs; [
    ### Encryption ###
    cryptomator             # Free client-side encryption for your cloud files
  ];

  syncPkgs = with pkgs; [
    ### Syncronization ###
    #syncthing              # [Enabled as a service] Open Source Continuous File Synchronization
  ];

  osintPkgs = with pkgs; [
    ### OSINT ###
    # nmap                    # Network enumeration tool
    # dnsrecon                # DNS enumeration tool
  ];

  fontPkgs = with pkgs; [
    ### Fonts ###
    cascadia-code           # Monospaced font that includes programming ligatures
    # ipaexfont               # Japanese font package with Mincho and Gothic fonts
  ];

  identPkgs = with pkgs; [
    ### Identity ###
    # keybase                 # Keybase official command-line utility and service
  ];

  socialPkgs = with pkgs; [
    ### Social ###
    element-desktop         # Feature-rich Matrix client
    threema-desktop         # Desktop client for Threema, a privacy-focused end-to-end encrypted mobile messenger
    #tdesktop               # Telegram Desktop messaging app
    # telegram-cli            # Command-line interface for Telegram
    kotatogram-desktop      # Kotatogram – experimental Telegram Desktop fork
    thunderbird             # Full-featured e-mail client
  ];

  browserPkgs = with pkgs; [
    ### Browsers ###
    # firefox                 # Web browser built from Firefox source tree
    # librewolf               # Fork of Firefox, focused on privacy, security and freedom
    chromium                # Open source web browser from an evil company
    tor-browser-bundle-bin  # Tor Browser Bundle built by torproject.org
    # lynx                    # Text-mode web browser
  ];

  docPkgs = with pkgs; [
    ### Documents ###
    libreoffice-fresh       # Comprehensive, professional-quality productivity suite, a variant of openoffice.org
  ];

  mediaEditPkgs = with pkgs; [
    ### Media editing ###
    darktable               # Virtual lighttable and darkroom for photographers
    libsForQt5.kdenlive     # Video editor
    handbrake               # Tool for converting video files and ripping DVDs
  ];

  fileSharingPkgs = with pkgs; [
    ### Filesharing ###
    # ipfs                    # Global, versioned, peer-to-peer filesystem
    transmission-gtk        # Fast, easy and free BitTorrent client
  ];

  dlPkgs = with pkgs; [
    ### Downloads ###
    youtube-dl              # Command-line tool to download videos from YouTube.com and other sites
    hakuneko                # Manga & Anime Downloader
  ];

  mediaViewPkgs = with pkgs; [
    ### Media, streaming ###
    mpv                     # General-purpose media player, fork of MPlayer and mplayer2
    ani-cli                 # Cli tool to browse and play anime
    vlc                     # Cross-platform media player and streaming server
  ];

  recPkgs = with pkgs; [
    ### Recording ###
    asciinema               # Terminal session recorder
  ];

  cCurrPkgs = with pkgs; [
    ### Cryptocurrency ###
    # trezord                 # Trezor Communication Daemon aka Trezor Bridge
  ];

  gamePkgs = with pkgs; [
    ### Games ###
    minetest                # Infinite-world block sandbox game
    polymc                  # [NONFREE-DL] Free, open source launcher for Minecraft
  ];

  showPkgs = with pkgs; [
    ### Showing off ###
    neofetch                # Fast, highly customizable system info script
    # uwufetch                # Meme system info tool for Linux
    cmatrix                 # Simulates the falling characters theme from The Matrix movie
  ];

  laptopPkgs = with pkgs; [
    ### Packages for laptop hosts ###
    acpi                    # Show battery status and other ACPI information
    light                   # GNU/Linux application to control backlights
  ];

  nonFreePkgs = with pkgs; [
    ### Nonfree ###
    rustdesk                # [NONFREE_DEP] Yet another remote desktop software
    # trezor-suite            # [NONFREE_LICENSE] Trezor Suite - Desktop App for managing crypto
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
      showPkgs ++ laptopPkgs;
    sessionVariables = {
      DISPLAY = ":0";
      EDITOR = "nvim";
    };
  };

  xdg.enable = true;

  # Manage services
  services = {
    syncthing = {
      enable = false;
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
        theme = "terminalparty";  # Other themes: terminalparty eastwood fishy ...
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
