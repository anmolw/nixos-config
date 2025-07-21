{ config, ... }:
{
  users.users.anmol = {
    isNormalUser = true;
    shell = config.programs.fish.package;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP5QyKja6UgJW2DrXEFgbtgNZoJlinEvTVpcZy6EfnbK anmol@blade"
    ];
    extraGroups = [
      "wheel"
      "networkmanager"
      "libvirtd"
    ];
    packages = [ ];
  };

}
