# 0xb1b1's NixOS Config

## Because I have way too much time

### How to switch to your host configuration?

Switching is done with just one command. However, you have to copy over your current hardware configuration and make sure that nothing conflicts.
Tip: to avoid breakage, `nixos-rebuild boot` is preferred for the first rebuild on this flake. Reboot, make sure everything works - and use `nixos-rebuild switch` afterwards (unless not suitable for the change you made).

```bash
# UID 0 (root) must perform this action.
nixos-rebuild <boot/switch> --flake .#<hostname>
```

### How to switch to your home-manager configuration?

It's quite easy. Just go to the root directory of the Git repo and execute this command.

```bash
home-manager switch --flake .#<username>
```

### What are all these modules about?

I broke up my configuration into modules to make it more or less readable. You can easily enable/disable modules by commenting out imports.

```nix
{
  imports = [
    #./hardened.nix  # <- Commented out module.
    ./sudo.nix
    ./doas.nix
  ];
}
```

### How to contribute?

Fork this repository and create a new branch. After committing your changes, go to GitHub/Gitea and open a new pull request. Thanks!
