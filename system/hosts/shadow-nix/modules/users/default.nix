{ pkgs, ... }:

{
  # User management settings.
  users.mutableUsers = false;

  # Set default shell.
  users.defaultUserShell = pkgs.zsh;

  # Define user accounts.
  users.users = {
    reverse = {
      isNormalUser = trur;
      description = "Reverse SSH connections";
      uid = 1001;
      useDefaultShell = false;
      # TODO: Edit for production!!!
      hashedPassword = "$6$cQWJCPMwSqsbh9r$mIALQWkszxd8W4lHHq9JLkJIOLzRnfre9RVBFoidi1zssk9rvPZEAvtRCMqc5tTkq95ZfOLIcLomAzbXkvX7F1";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINIbLUONM0K9idIRgTANd+soJRpeJgPhfC+fTJUCM7Bv arina@hachpachmak"
      ];
    };
  };
}
