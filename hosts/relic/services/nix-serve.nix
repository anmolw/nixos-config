{ config, pkgs, ... }:
{
  # Binary cache for other machines
  services.nix-serve = {
    enable = true;
    package = pkgs.nix-serve-ng;
    secretKeyFile = config.sops.secrets."nix-serve-priv-key".path;
    openFirewall = true;
  };
}
