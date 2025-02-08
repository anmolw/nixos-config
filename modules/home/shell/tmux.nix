{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    prefix = "C-a";
    mouse = true;
    extraConfig = ''
      set -g default-terminal "tmux-256color"
      set -ag terminal-overrides ",$TERM:RGB"
      set -g allow-passthrough on

      # set -ga update-environment TERM
      # set -ga update-environment TERM_PROGRAM
    '';
    plugins = [
      # TODO: Re-enable when build failure is resolved
      # pkgs.tmuxPlugins.resurrect
      pkgs.tmuxPlugins.tmux-fzf
      {
        plugin = pkgs.tmuxPlugins.tmux-thumbs;
        extraConfig = ''
          set -g @thumbs-key Q
        '';
      }
      pkgs.tmuxPlugins.catppuccin
    ];
  };
}
