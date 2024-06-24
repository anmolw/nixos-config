{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ../modules/shell.nix
    ../modules/development.nix
    ../modules/ssh.nix
    ../modules/fonts.nix
    ../modules/vscode.nix
    ../modules/krisp.nix
    ../modules/nixos-specific.nix
  ];

  home.stateVersion = "24.05";

  programs.discord.enable = true;
  programs.discord.wrapDiscord = true;
}
