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
    ../modules/vscode.nix
    ../modules/krisp.nix
    ../modules/nixos-specific.nix
  ];

  programs.discord.enable = true;
  programs.discord.wrapDiscord = true;
}
