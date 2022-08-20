{
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
}
