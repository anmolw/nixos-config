{
  imports = [
    ./caddy.nix
    ./forgejo.nix
    ./minecraft.nix
    ./miniflux.nix
    ./ssh.nix
    ./tailscale.nix
  ];

  virtualisation.podman.enable = true;
}
