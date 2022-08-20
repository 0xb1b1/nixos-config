{
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
}
