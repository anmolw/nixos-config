{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.tmux-which-key.homeManagerModules.default
  ];

  nixpkgs.overlays = [inputs.tmux-which-key.overlays.default];

  programs.tmux = {
    enable = true;
    baseIndex = 1;
    prefix = "C-a";
    mouse = true;
    extraConfig = ''
      set -g default-terminal "tmux-256color"
    '';
    tmux-which-key.enable = true;
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
