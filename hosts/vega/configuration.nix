{ config, pkgs, ... }:
{
  imports = [
    ./disko-configuration.nix
    ./hardware-configuration.nix
    ./networking.nix
    ../../modules/nixos/nixsettings.nix
    ./services
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages;

  users = {
    users.anmol = {
      isNormalUser = true;
      uid = 1000;
      shell = config.programs.fish.package;
      extraGroups = [
        "wheel"
        "web"
      ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHEFb4CAY8laV5JmSD/AMgIZWBvF1uM8nLVFgzUu+JdP anmol@desktop"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP5QyKja6UgJW2DrXEFgbtgNZoJlinEvTVpcZy6EfnbK anmol@blade"
      ];
    };
    groups = {
      "web" = { };
    };
  };

  programs.fish.enable = true;
  programs.zsh.enable = true;

  programs.git.enable = true;

  environment.systemPackages = with pkgs; [
    bat
    fd
    ripgrep
    btop
    vim
  ];

  time.timeZone = "Asia/Kolkata";
  time.hardwareClockInLocalTime = false;

  i18n.defaultLocale = "en_US.UTF-8";
  system.stateVersion = "25.05";
}
