{ pkgs, ... }:

{
  programs = {
    gpg.enable = true;

    zsh = {  # From https://www.reddit.com/r/NixOS/comments/jlcckh/comment/gap2tdk/?utm_source=share&utm_medium=web2x&context=3
      enable = true;
      enableCompletion = false;  # Enabled in oh-my-zsh
      initExtra = ''
        test -f ~/.dir_colors && eval $(dircolors ~/.dir_colors)
        test -f ~/.config/term/ls_colors && source ~/.config/term/ls_colors
      '';
      shellAliases = {
        #doas = "sudo";  # using doas by default
        #docker = "sudo docker";
        git-push = "git remote | xargs -L1 git push --all";  # push all branches to all remotes
        git-push-master = "git remote | xargs -L1 -I R git push R master"; # push "master" branch to all remotes
      };
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "systemd" "rsync" "kubectl" ];
        theme = "terminalparty";  # Other themes: terminalparty eastwood fishy ...
      };
      enableSyntaxHighlighting = true;
      enableAutosuggestions = true;
      envExtra = ''
        source $HOME/.config/env
      '';
      history = {
        extended = true;
        ignoreDups = true;  # true by default
        save = 500000;  # Number of lines to save
        size = 500000;  # Number of history lines to keep
      };
    };

    neovim = {
      enable = true;
      plugins = with pkgs.vimPlugins; [ coc-rust-analyzer ];
    };

    obs-studio = {
      enable = true;
      plugins = [];
    };
  };
}
