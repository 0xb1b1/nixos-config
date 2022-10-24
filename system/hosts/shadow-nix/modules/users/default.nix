# Define per-machine accounts
{ pkgs, ... }:

{
  # User management settings.
  users.mutableUsers = false;

  # Set default shell.
  # users.defaultUserShell = pkgs.zsh;  # Set in global configuration

  # Define user accounts.
  users.users = {
    arzym = {
      isNormalUser = true;
      description = "arzym";
      uid = 1100;
      useDefaultShell = true;
      hashedPassword = "$6$pZQZXnA2AW0Y$7eWmfxPIuc7RfPcU8IpnKy32Yhz/g2lTRotIVzO7Sd3QuKyKkdTGZ15GD029G8xoP0SuQCkpsVRcGBoeHkkVn.";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBz0IhG7jBM1G/iwSamDQZg7H0NRqSgKF8C1M1GHyrta artem@Artems-MacBook-Air"
      ];
    };
  };
}
