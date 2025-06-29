{ config, pkgs, ... }:
{

  hardware.graphics.enable = true;
  hardware.graphics.extraPackages = with pkgs; [ nvidia-vaapi-driver ];

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
