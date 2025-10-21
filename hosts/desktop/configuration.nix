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
    ./gfx.nix
    ./networking.nix
    ./programs
    ./services
    ./users.nix
  ];

  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      devices = [ "nodev" ];
      efiSupport = true;
      useOSProber = true;
    };
  };

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

  hardware.logitech.wireless.enable = true;
  hardware.logitech.wireless.enableGraphical = true;

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;

  environment.systemPackages = with pkgs; [
    aria2
    asciinema
    bat
    btop-rocm
    cider-2
    compsize
    croc
    curl
    delta
    dfrs
    distrobox
    doggo
    dua
    element-desktop
    eza
    fastfetch
    fd
    file
    fzf
    gh
    ghostty
    git
    go
    gum
    gpu-screen-recorder
    gpu-screen-recorder-gtk
    helix
    heroic
    jellyfin-media-player
    jq
    jujutsu
    just
    kdePackages.kasts
    kdePackages.partitionmanager
    lazygit
    (llama-cpp.override { rocmSupport = true; })
    micro
    mission-center
    mpv
    nfs-utils
    nix-output-monitor
    nix-search-cli
    nvme-cli
    nvtopPackages.amd
    mangohud
    obsidian
    ollama-rocm
    pciutils
    podlet
    prismlauncher
    ripgrep
    signal-desktop
    smartmontools
    television
    tlrc
    usbutils
    uv
    vim
    vlc
    wget
    wl-clipboard
    wireguard-tools
    zoxide
  ];

  programs.virt-manager.enable = true;
  programs.firefox.enable = true;

  programs.direnv.enable = true;

  programs.steam = {
    enable = true;
    protontricks.enable = true;
    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };

  programs.discord.enable = true;
  programs.discord.wrapDiscord = true;

  services.fwupd.enable = true;
  services.smartd.enable = true;
  services.flatpak.enable = true;

  virtualisation.vmVariant = { };

  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Asia/Kolkata";

  system.stateVersion = "25.11";
}
