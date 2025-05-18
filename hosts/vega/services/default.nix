{
  imports = [
    ./caddy.nix
    ./forgejo.nix
    ./minecraft.nix
    ./ssh.nix
    ./tailscale.nix
  ];

  virtualisation.podman.enable = true;
}
