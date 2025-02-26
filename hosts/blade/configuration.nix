# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  config,
  lib,
  pkgs,
  inputs,
  stablePkgs,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./gfx.nix
    ./network.nix
    ../../modules/nixos/common.nix
    ../../modules/nixos/desktop/kde.nix
    ../../modules/nixos/fonts.nix
    ../../modules/nixos/nixsettings.nix
    ../../modules/nixos/steam.nix
  ];

  # Secrets setup
  sops.defaultSopsFile = ../../secrets/blade.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

  # Nix settings
  nix.settings.trusted-users = [ "anmol" ];
  nix.settings.extra-substituters = [
    "http://relic:5000"
    "https://ghostty.cachix.org"
  ];
  nix.settings.extra-trusted-public-keys = [
    "relic:m82+/J4P+QTmMdBHd7UGeuuYIqsxA+TKOQ9+HOFP8lQ="
    "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
  ];
  nix.extraOptions = ''
    builders-use-substitutes = true
  '';

  # Home-manager
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
    sharedModules = [
      inputs.catppuccin.homeManagerModules.catppuccin
      inputs.sops-nix.homeManagerModules.sops
      inputs.nix-index-database.hmModules.nix-index
    ];
    users.anmol = {
      imports = [
        ../../homes/blade.nix
      ];
    };
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Kernel setup
  boot.kernelParams = [
    "nvme_core.default_ps_max_latency_us=0"
    "zswap.enabled=1"
    "zswap.compressor=lz4"
  ];

  boot.kernelPackages = pkgs.linuxPackages_zen;

  systemd.units."dev-tpmrm0.device".enable = false;
  systemd.targets."tpm".enable = false;
  systemd.targets."tpm2".enable = false;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # rtkit is optional but recommended
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    extraConfig.pipewire = {
      "10-allowed-rates" = {
        "context.properties" = {
          "default.clock.allowed-rates" = [
            44100
            48000
          ];
        };
      };
    };
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
  };

  # Enable power profiles
  services.power-profiles-daemon.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.anmol = {
    isNormalUser = true;
    home = "/home/anmol";
    createHome = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHEFb4CAY8laV5JmSD/AMgIZWBvF1uM8nLVFgzUu+JdP anmol@desktop"
    ];
    packages = with pkgs; [
      firefox
      mpv
      spotify
      vlc
      tree
    ];
  };

  # Enable flatpak
  services.flatpak.enable = true;

  services.tailscale.enable = true;

  environment.systemPackages = with pkgs; [
    aria2
    compsize
    croc
    curl
    eza
    file
    fzf
    git
    micro
    nvme-cli
    pciutils
    usbutils
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wireguard-tools
    wget
  ];

  custom.desktop.kde.enable = true;

  programs.dconf.enable = true;

  programs.zsh.enable = true;
  environment.pathsToLink = [
    "/share/zsh"
    "/share/fish"
  ];

  programs.nh = {
    enable = true;
    flake = "/home/anmol/code/github/nixos-config";
  };

  programs.firefox = {
    enable = true;
    preferences = {
      "widget.use-xdg-desktop-portal.file-picker" = 1;
      "widget.use-xdg-desktop-portal.mime-handler" = 1;
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  services.fwupd.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = false;
  services.openssh.openFirewall = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?
}
