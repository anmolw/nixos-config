{ pkgs, ... }:
{
  virtualisation.containers.enable = true;
  virtualisation.podman = {
    enable = true;
    autoPrune.enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  environment.systemPackages = with pkgs; [
    podman-compose
    podman-tui
  ];

  systemd.services.podman-restart.wantedBy = [ "multi-user.target" ];
}
