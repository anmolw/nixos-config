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
    ../modules/fonts.nix
    ../modules/vscode.nix
    ../modules/krisp.nix
    ../modules/nixos-specific.nix
  ];

  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    obsidian
  ];

  programs.alacritty = {
    enable = true;
  };

  programs.discord.enable = true;
  programs.discord.wrapDiscord = true;
}
