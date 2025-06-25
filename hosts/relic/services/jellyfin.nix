{ pkgs, ... }:
{
  services.jellyfin = {
    enable = true;
    user = "jellyfin";
    group = "jellyfin";
    openFirewall = true;
  };
  systemd.services.jellyfin.serviceConfig.SupplementaryGroups = [ "media" ];

  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
  ];

  users.users.jellyfin.uid = 1100;
  users.users.anmol.extraGroups = [ "jellyfin" ];
  users.groups.jellyfin.gid = 1100;
}
