{ pkgs, ... }:
{
  services.immich = {
    enable = true;
    port = 2283;
    host = "0.0.0.0";
    openFirewall = true;
    settings = null;
    machine-learning.enable = true;

    database = {
      enable = true;
      createDB = true;
    };
  };
}
