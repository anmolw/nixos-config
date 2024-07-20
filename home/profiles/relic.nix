{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ../modules/shell
    ../modules/nixos-specific.nix
  ];

  home.packages = with pkgs; [
    btdu
    fastfetch
  ];

  programs.zsh.p10k.enable = true;

  home.stateVersion = "24.05";
}
