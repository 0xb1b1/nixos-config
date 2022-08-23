{ pkgs, ... }:

{
  # Install flakes.
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
}
