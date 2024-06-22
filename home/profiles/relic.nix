{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ../modules/shell.nix
    ../modules/nixos-specific.nix
  ];
}
