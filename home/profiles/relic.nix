{pkgs, lib, config, ...}:
{
  imports = [
    ../modules/general.nix
    ../modules/nixos-specific.nix
  ];
}
