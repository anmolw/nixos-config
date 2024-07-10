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

  home.packages = with pkgs; [
    fastfetch
  ];

  home.stateVersion = "24.05";
}
