{ pkgs, ... }:
{
  # services.syncthing = {
  #   enable = true;
  #   systemService = false;
  #   openDefaultPorts = true;
  # };

  environment.systemPackages = with pkgs; [ syncthingtray ];
  systemd.packages = with pkgs; [ syncthing ];
}
