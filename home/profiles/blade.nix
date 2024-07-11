{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ../modules/shell.nix
    ../modules/p10k.nix
    ../modules/development.nix
    ../modules/ssh.nix
    ../modules/neovim.nix
    ../modules/fonts.nix
    ../modules/vscode.nix
    ../modules/krisp.nix
    ../modules/nixos-specific.nix
  ];

  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    btdu
    fastfetch
    ktailctl
    obsidian
    python3
  ];

  programs.alacritty = {
    enable = true;
    settings = {
      font.normal = {
        family = "Hack Nerd Font Mono";
        style = "Regular";
      };
    };
  };

  programs.wezterm = {
    enable = true;
  };

  programs.tmux.extraConfig = ''
    set -g default-command ${pkgs.fish}/bin/fish
    set -g default-shell ${pkgs.fish}/bin/fish
  '';

  programs.discord.enable = true;
  programs.discord.wrapDiscord = true;
}
