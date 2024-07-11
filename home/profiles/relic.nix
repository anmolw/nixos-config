{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ../modules/shell
    ../modules/p10k.nix
    ../modules/nixos-specific.nix
  ];

  home.packages = with pkgs; [
    btdu
    fastfetch
  ];

  home.stateVersion = "24.05";
}
