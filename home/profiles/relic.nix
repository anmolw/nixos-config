{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ../modules/shell.nix
    ../modules/p10k.nix
    ../modules/nixos-specific.nix
  ];

  home.stateVersion = "24.05";
}
