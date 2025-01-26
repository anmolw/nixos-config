{ pkgs, ... }:
{
  programs.nix-index.enable = true;
  programs.zsh.shellAliases = {
    nvdsys = "nvd diff $(command ls -dv /nix/var/nix/profiles/system-*-link | tail -2)";
  };
  programs.fish.shellAliases = {
    nvdsys = "nvd diff (command ls -dv /nix/var/nix/profiles/system-*-link | tail -2)";
  };
}
