{
  imports = [
    ./caddy.nix
    ./forgejo.nix
    ./homepage.nix
    ./minecraft.nix
    ./miniflux.nix
    ./ssh.nix
    ./tailscale.nix
  ];

  virtualisation.podman.enable = true;
}
