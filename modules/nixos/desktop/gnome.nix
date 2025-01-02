{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.custom.desktop.gnome;
in
{
  programs.dconf.enable = true;

  options.custom.desktop.gnome.enable = lib.mkEnableOption "Enable the GNOME desktop environment";

  config = lib.mkIf cfg.enable {
    services.xserver.enable = true;
    services.displayManager.gdm = {
      enable = true;
    };

    services.desktopManager.gnome.enable = true;

    environment.systemPackages = with pkgs; [
      gnomeExtensions.appindicator
      gnomeExtensions.dash-to-dock
      gnomeExtensions.mpris-label
      gnomeExtensions.blur-my-shell
    ];
  };
}
