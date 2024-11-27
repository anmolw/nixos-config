{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ../modules/home/shell
  ];

  home.packages = with pkgs; [
    fastfetch
  ];

  home.sessionPath = [];

  home.stateVersion = "25.05";
}
