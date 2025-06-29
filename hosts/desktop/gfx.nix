{ config, pkgs, ... }:
{
  hardware.graphics.enable = true;
  hardware.graphics.extraPackages = with pkgs; [ nvidia-vaapi-driver ];
  environment.variables = {
    LIBVA_DRIVER_NAME = "nvidia";
  };

  hardware.nvidia = {
    enable = true;
    modesetting = true;
    open = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
    powerManagement = {
      enable = true;
      finegrained = true;
    };
    nvidiaSettings = true;
  };
}
