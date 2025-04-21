{
  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "server string" = "relic";
        "server role" = "standalone";
        "netbios name" = "relic";
        "security" = "user";
        "hosts allow" = "192.168.1.0/24 100.64.0.0/10 fe80::/64 127.0.0.1 localhost";
        "hosts deny" = "ALL";
        "guest account" = "nobody";
        "map to guest" = "never";
      };
      "media" = {
        "path" = "/srv/media";
        "comment" = "Media share";
        "force unknown acl user" = "yes";
        "browseable" = "yes";
        "read only" = "yes";
        "guest ok" = "no";
        "force directory mode" = "0775";
        "force create mode" = "0775";
        "force user" = "jellyfin";
        "force group" = "jellyfin";
        "map archive" = "no";
        "map hidden" = "no";
        "map readonly" = "no";
        "store dos attributes" = "no";
        "vfs objects" = "io_uring";
        "write list" = "anmol";
      };
    };
  };

  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };
}
