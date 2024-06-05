{
  config,
  lib,
  pkgs,
  ...
}: {
  # ksmbd
  environment.systemPackages = with pkgs; [ksmbd-tools];

  environment.etc."ksmbd/ksmbd.conf" = {
    mode = "0640";
    text = ''
      ; see ksmbd.conf(5) for details
      [global]
        workgroup = WORKGROUP
        netbios name = relic

      [media]
        ; share parameters
        comment = Media drive
        create mask = 0755
        force group = media
        force user = anmol
        path = /srv/media
        read only = yes
        write list = anmol
        guest ok = yes
        guest account = guest
    '';
  };

  networking.firewall.allowedTCPPorts = [445];
  systemd.packages = with pkgs; [ksmbd-tools];
  systemd.services.ksmbd.wantedBy = ["multi-user.target"];
}
