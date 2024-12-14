{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.custom.desktop.kde;
in
{
  options.custom.desktop.kde.enable = lib.mkEnableOption "Enable KDE Desktop environment";

  config = lib.mkIf cfg.enable {
    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable the Plasma 6 Desktop Environment.
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      wayland.compositor = "kwin";
      enableHidpi = true;
    };

    services.desktopManager.plasma6.enable = true;

    environment.systemPackages = with pkgs; [
      kdePackages.sddm-kcm
    ];
  };
}
