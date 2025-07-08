{
  services.caddy = {
    enable = true;
    group = "web";
    virtualHosts = {
      "anmolw.com" = {
        serverAliases = [ "www.anmolw.com" ];
        extraConfig = ''
          encode gzip
          root * /srv/www/anmolw.com
          file_server
        '';
      };
      "hass.anmolw.com" = {
        extraConfig = ''
          reverse_proxy pi4:8123
        '';
      };
    };
  };
}
