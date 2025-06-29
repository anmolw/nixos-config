{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ../../modules/nixos/nixsettings.nix
    ../../modules/nixos/podman.nix
    ./disko-configuration.nix
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;
  boot.extraModulePackages = [ config.boot.kernelPackages.xone ];

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
    pulse.enable = true;
    extraConfig.pipewire = { };
  };

  programs.fish.enable = true;
  programs.nh = {
    enable = true;
    flake = "/home/anmol/code/github/nixos-config";
  };

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;

  environment.systemPackages = with pkgs; [
    aria2
    bat
    compsize
    croc
    curl
    eza
    fd
    file
    fzf
    git
    jujutsu
    micro
    nvme-cli
    pciutils
    smartmontools
    usbutils
    vim
    wget
    wireguard-tools
  ];

  programs.firefox.enable = true;

  programs.steam = {
    enable = true;
    protontricks.enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };

  services.fwupd.enable = true;
  services.smartd.enable = true;

  services.flatpak.enable = true;

  services.tailscale.enable = true;

  users.users.anmol = {
    isNormalUser = true;
    shell = config.programs.fish.package;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP5QyKja6UgJW2DrXEFgbtgNZoJlinEvTVpcZy6EfnbK anmol@blade"
    ];
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    packages = [ ];
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.PermitRootLogin = "no";
    settings.KbdInteractiveAuthentication = false;
    openFirewall = true;
  };

  virtualisation.vmVariant = { };

  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Asia/Kolkata";

  system.stateVersion = "25.11";
}
