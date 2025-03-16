# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./disko-configuration.nix
    ./nfs.nix
    ./network.nix
    ./samba.nix
    ./jellyfin.nix
    ../../modules/nixos/common.nix
    ../../modules/nixos/nixsettings.nix
    ../../modules/nixos/podman.nix
  ];

  # Secrets setup
  sops = {
    defaultSopsFile = ../../secrets/relic.yaml;
    defaultSopsFormat = "yaml";
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    secrets."nix-serve-priv-key" = { };
  };

  # Nix settings
  nix.settings.trusted-users = [ "anmol" ];

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

    users.anmol.imports = [
      ../../homes/relic.nix
    ];
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Kernel setup
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Binary cache for other machines
  services.nix-serve = {
    enable = true;
    secretKeyFile = config.sops.secrets."nix-serve-priv-key".path;
    openFirewall = true;
  };

  services.tailscale.enable = true;
  services.tailscale.extraUpFlags = [ "--stateful-filtering=false" ];

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Intel specific video drivers and video acceleration
  # services.xserver.videoDrivers = ["modesetting"];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.anmol = {
    isNormalUser = true;
    home = "/home/anmol";
    uid = 1000;
    createHome = true;
    shell = pkgs.zsh;
    linger = true;
    extraGroups = [
      "wheel"
      "docker"
      "media"
    ]; # Enable sudo and docker usage
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHEFb4CAY8laV5JmSD/AMgIZWBvF1uM8nLVFgzUu+JdP anmol@desktop"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP5QyKja6UgJW2DrXEFgbtgNZoJlinEvTVpcZy6EfnbK anmol@blade"
    ];
  };

  # No initial root password for the purpose of setting up the system unattended
  users.users.root.initialHashedPassword = "";

  users.groups.media.gid = 1002;

  environment.systemPackages = with pkgs; [
    aria2
    btop
    compsize
    croc
    curl
    eza
    file
    fzf
    git
    micro
    nfs-utils
    pciutils
    pyenv
    usbutils
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
  ];

  programs.zsh.enable = true;
  environment.pathsToLink = [ "/share/zsh" ];

  programs.nh = {
    enable = true;
    flake = "/home/anmol/nixos-config";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

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
  system.stateVersion = "24.05"; # Did you read the comment?
}
