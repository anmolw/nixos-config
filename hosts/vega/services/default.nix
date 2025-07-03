{
  imports = [
    ./caddy.nix
    ./forgejo.nix
    ./minecraft.nix
    ./miniflux.nix
    ./ssh.nix
    ./syncthing.nix
    ./tailscale.nix
  ];

  virtualisation.podman.enable = true;
}
