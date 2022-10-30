{ pkgs, ... }:

{
  # User management settings.
  users.mutableUsers = false;

  # Set default shell.
  users.defaultUserShell = pkgs.zsh;

  # Define user accounts.
  users.users = {
    voxel = {
      isNormalUser = true;
      description = "voxel";
      uid = 1000;
      extraGroups = [ "networkmanager" "wheel" "libvirtd" "docker" "adbusers" ];
      useDefaultShell = true;
      hashedPassword = "$6$cQWJCPMwSqsbh9r$xhnVcK.SONgK7P60uNPaJjoAtXXZdKbuy7YpKGzabWJuOte8LVNjNk4lTHEwvtX5SKagTgr24qwFxNkc3HRWY0";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINZk4eNkp+63OWjGvEXz6xUwVU3rb7669IlLJYM54Dk0 voxel@outline"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGVxgW64ZqL0NZm+ze5aAZWUsFG6arDYsx0S3jIDK30m voxel@voyager"
      ];
    };
    arina = {
      isNormalUser = true;
      description = "arina";
      uid = 1001;
      useDefaultShell = true;
      hashedPassword = "$6$cQWJCPMwSqsbh9r$mIALQWkszxd8W4lHHq9JLkJIOLzRnfre9RVBFoidi1zssk9rvPZEAvtRCMqc5tTkq95ZfOLIcLomAzbXkvX7F1";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINIbLUONM0K9idIRgTANd+soJRpeJgPhfC+fTJUCM7Bv arina@hachpachmak"
      ];
    };
  };
}
