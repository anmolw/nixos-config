{
  pkgs,
  config,
  inputs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./networking.nix
    ../../modules/nixos/nixsettings.nix
  ];

  # Nix settings
  nix.settings.trusted-users = [ "anmol" ];
  nix.settings.extra-substituters = [ "http://relic:5000" ];
  nix.settings.extra-trusted-public-keys = [ "relic:m82+/J4P+QTmMdBHd7UGeuuYIqsxA+TKOQ9+HOFP8lQ=" ];

  users.users.anmol = {
    isNormalUser = true;
    home = "/home/anmol";
    createHome = true;
    shell = config.programs.fish.package;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHEFb4CAY8laV5JmSD/AMgIZWBvF1uM8nLVFgzUu+JdP anmol@desktop"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP5QyKja6UgJW2DrXEFgbtgNZoJlinEvTVpcZy6EfnbK anmol@blade"
    ];
    packages = with pkgs; [
    ];
  };

  # Home-manager
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
    sharedModules = [
      inputs.catppuccin.homeManagerModules.catppuccin
      inputs.sops-nix.homeManagerModules.sops
    ];
    users.anmol = {
      imports = [
        ../../homes/pi.nix
      ];
    };
  };

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

  programs.zsh.enable = true;
  programs.fish.enable = true;

  virtualisation.containers.enable = true;
  virtualisation.docker = {
    enable = true;
  };

  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_US.UTF-8";
  services.tailscale.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = false;
  services.openssh.openFirewall = true;

  system.stateVersion = "25.05";
}
