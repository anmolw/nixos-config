{ config, ... }:
{
  # Binary cache for other machines
  services.nix-serve = {
    enable = true;
    secretKeyFile = config.sops.secrets."nix-serve-priv-key".path;
    openFirewall = true;
  };
}
