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

  nixpkgs.overlays = [(import ../../../overlays/doggo.nix)];

  home.stateVersion = "24.05";

  programs.discord.enable = true;
  programs.discord.wrapDiscord = true;
}
