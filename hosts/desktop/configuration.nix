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
    ./pipewire.nix
    ./programs
    ./services
    ./users.nix
  ];

  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        default = "saved";
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;
      };
    };
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    kernelParams = [ "systemd.swap=false" ];
    extraModulePackages = [ config.boot.kernelPackages.xone ];
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
    pulse.enable = true;
  };

  programs.fish.enable = true;
  programs.nh = {
    enable = true;
    flake = "/home/anmol/code/github/nixos-config";
  };

  hardware.bluetooth.enable = true;
  hardware.xone.enable = true;
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
    # Disabled due to vulnerabilities in qt5 qtwebengine
    # jellyfin-media-player
    jq
    jujutsu
    just
    kdePackages.kasts
    kdePackages.partitionmanager
    kitty
    lazygit
    (llama-cpp.override { rocmSupport = true; })
    micro
    mission-center
    mpv
    nfs-utils
    nix-output-monitor
    nix-search-cli
    nix-your-shell
    nixos-rebuild-ng
    nvme-cli
    nvtopPackages.amd
    mangohud
    obsidian
    ollama-rocm
    pciutils
    podlet
    prismlauncher
    qbittorrent
    ripgrep
    rocmPackages.rocm-smi
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
  programs.firefox.preferences = {
    "widget.use-xdg-desktop-portal.file-picker" = 1;
  };

  programs.direnv = {
    enable = true;
    settings = {
      global = {
        hide_env_diff = true;
      };
    };
  };

  programs.steam = {
    enable = true;
    package = pkgs.steam.override {
      extraPkgs = pkgs: with pkgs; [ kdePackages.breeze ];
    };
    protontricks.enable = true;
    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  programs.discord.enable = true;
  programs.discord.wrapDiscord = true;

  programs.kdeconnect.enable = true;

  services.fwupd.enable = true;
  services.smartd.enable = true;
  services.flatpak.enable = true;

  virtualisation.vmVariant = { };

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      swtpm.enable = true;
      ovmf.packages = [ pkgs.OVMFFull.fd ];
    };
  };

  zramSwap = {
    enable = true;
    memoryPercent = 50;
    writebackDevice = "/dev/disk/by-uuid/3e12d1bb-24df-460b-a943-1c23feeff0cf";
  };

  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Asia/Kolkata";

  system.stateVersion = "25.11";
}
