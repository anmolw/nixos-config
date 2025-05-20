{
  imports = [
    ./caddy.nix
    ./forgejo.nix
    ./ssh.nix
    ./tailscale.nix
  ];

  virtualisation.podman.enable = true;
}
