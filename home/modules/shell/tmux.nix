{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    prefix = "C-a";
    mouse = true;
    extraConfig = ''
      set -g default-terminal "tmux-256color"
    '';
    plugins = [
      pkgs.tmuxPlugins.resurrect
      pkgs.tmuxPlugins.tmux-fzf
      {
        plugin = pkgs.tmuxPlugins.tmux-thumbs;
        extraConfig = ''
          set -g @thumbs-key Q
        '';
      }
    ];
  };
}
