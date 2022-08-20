{ pkgs, ... }:

{
  # User management settings.
  users.mutableUsers = false;

  # Define user accounts.
  users.users = {
    voxel = {
      isNormalUser = true;
      description = "voxel";
      extraGroups = [ "networkmanager" "wheel" "libvirtd" "docker" "adbusers" ];
      shell = pkgs.zsh;
      hashedPassword = "$6$cQWJCPMwSqsbh9r$xhnVcK.SONgK7P60uNPaJjoAtXXZdKbuy7YpKGzabWJuOte8LVNjNk4lTHEwvtX5SKagTgr24qwFxNkc3HRWY0";
    };
    arina = {
      isNormalUser = true;
      description = "arina";
      shell = pkgs.bash;
      hashedPassword = "$6$cQWJCPMwSqsbh9r$mIALQWkszxd8W4lHHq9JLkJIOLzRnfre9RVBFoidi1zssk9rvPZEAvtRCMqc5tTkq95ZfOLIcLomAzbXkvX7F1";
    };
  };
}
