{ pkgs, lib, ... }:
{
  config = {
    programs.fish.enable = true;

    environment.systemPackages = with pkgs; [
      pciutils
      usbutils
    ];
  };
}
