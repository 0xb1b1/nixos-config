{ pkgs, ... }:

{
  #! Only one (singular!) display manager should be enabled.
  services.xserver = {
    enable = true;
    # Configure a display manager.
    displayManager = {
      gdm.enable = true;
      defaultSession = "none+awesome";
    };
    windowManager.awesome = {
      enable = true;
      luaModules = with pkgs.luaPackages; [
        luarocks # is the package manager for Lua modules
        luadbi-mysql # Database abstraction layer
      ];
    };
    desktopManager.gnome = {
      enable = true;
    };
  };

  #? This setting affects Gnome 3.
  # Disable some bundled Gnome 3 packages.
  # Source: https://nixos.wiki/wiki/GNOME
  environment.gnome.excludePackages = (with pkgs; [
    #gnome-photos      # Photo viewer
    gnome-tour         # GNOME Greeter & Tour
  ]) ++ (with pkgs.gnome; [
    cheese            # Webcam tool
    gnome-terminal    # Terminal emulator
    epiphany          # Web browser
    geary             # Email reader
    gnome-characters  # Character explorer
    tali              # Poker game
    iagno             # Go game
    hitori            # Sudoku game
    atomix            # Puzzle game
    #gnome-music       # Music player
    #gedit             # Text editor
    #evince            # Document viewer
    #totem             # Video player
  ]);
}
