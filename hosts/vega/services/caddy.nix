{
  services.caddy = {
    enable = true;
    group = "web";
    virtualHosts = {
      "anmolw.com" = {
        serverAliases = [ "www.anmolw.com" ];
        extraConfig = ''
          encode gzip
          handle_path /minecraft* {
            root /srv/www/anmolw.com/minecraft
            file_server browse
          }
          handle {
            root * /srv/www/anmolw.com
            file_server
          }
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
