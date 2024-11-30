{
  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };

  users.users.jellyfin.uid = 1100;
  users.groups.jellyfin.gid = 1100;
}
