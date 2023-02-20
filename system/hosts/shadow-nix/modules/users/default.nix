# Define per-machine accounts
{ pkgs, ... }:

{
  # User management settings.
  users.mutableUsers = false;

  # Set default shell.
  # users.defaultUserShell = pkgs.zsh;  # Set in global configuration

  # Define user accounts.
  # users.users = {};
}
