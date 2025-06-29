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
    ../../modules/nixos/ssh.nix
    ./hardware-configuration.nix
    ./users.nix
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
    jellyfin-media-player
    jujutsu
    kdePackages.partitionmanager
    micro
    mpv
    nix-output-monitor
    nix-search-cli
    nvme-cli
    pciutils
    smartmontools
    usbutils
    vim
    vlc
    wget
    wireguard-tools
  ];

  programs.virt-manager.enable = true;
  programs.firefox.enable = true;

  programs.steam = {
    enable = true;
    protontricks.enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };

  services.fwupd.enable = true;
  services.smartd.enable = true;
  services.flatpak.enable = true;

  services.tailscale = {
    enable = true;
    extraSetFlags = [
      "--operator=anmol"
    ];
  };

  virtualisation.vmVariant = { };

  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Asia/Kolkata";

  system.stateVersion = "25.11";
}
