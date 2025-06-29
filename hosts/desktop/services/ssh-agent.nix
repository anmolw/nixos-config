{ pkgs, ... }:
{
  systemd.user.services.ssh-agent = {
    name = "ssh-agent";
    wantedBy = [ "default.target" ];
    unitConfig = {
      Description = "SSH authentication agent";
      Documentation = "man:ssh-agent(1)";
    };
    serviceConfig = {
      ExecStart = "${pkgs.openssh}/bin/ssh-agent -D -a %t/ssh-agent.sock";
    };
  };
}
