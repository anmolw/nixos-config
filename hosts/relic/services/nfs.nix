{
  services.nfs.server.enable = true;
  services.nfs.server.exports = ''
    /srv/media -mp *(ro) 192.168.1.0/24(rw,all_squash,anonuid=1000,anongid=1100) *.local(rw,all_squash,anonuid=1000,anongid=1100)
  '';

  networking.firewall.allowedTCPPorts = [ 2049 ];
  # networking.firewall.allowedUDPPorts = [2049];
}
