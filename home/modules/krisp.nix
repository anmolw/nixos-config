# Taken from m1cr0man's nix-configs repo
# https://github.com/m1cr0man/nix-configs/blob/374c28ea2e1c057059fb4e03553501c395c88518/homes/deck/krisp.nix
# Adapted from https://github.com/NixOS/nixpkgs/issues/195512#issuecomment-1814318443
# Changes:
#  - Pull the script from sersorrel directly
#  - Use python3.withPackages > writePython3Bin
#  - Copy + alter discord's .desktop file
{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.programs.discord;

  patcher = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/sersorrel/sys/de1ce2ba941318a05d4d029f717ad8be7b4b09ee/hm/discord/krisp-patcher.py";
    hash = "sha256-XIjXDzNglk7RBWjhPfVY8iaR70OSHWYxuh/rUPYVKLQ=";
  };

  python = pkgs.python3.withPackages (ps: [ps.pyelftools ps.capstone]);

  wrapperScript = pkgs.writeShellScript "discord-wrapper" ''
    set -euxo pipefail
    ${pkgs.findutils}/bin/find -L $HOME/.config/discord -name 'discord_krisp.node' -exec ${python}/bin/python3 ${patcher} {} +
    ${pkgs.discord}/bin/discord "$@"
  '';

  wrappedDiscord = pkgs.runCommand "discord" {} ''
    mkdir -p $out/share/applications $out/bin
    ln -s ${pkgs.discord}/share/pixmaps $out/share/pixmaps
    ln -s ${pkgs.discord}/share/icons $out/share/icons
    ln -s ${wrapperScript} $out/bin/discord
    ${pkgs.gnused}/bin/sed 's!Exec=.*!Exec=${wrapperScript}!g' ${pkgs.discord}/share/applications/discord.desktop > $out/share/applications/discord.desktop
  '';
in {
  options.programs.discord = {
    enable = lib.mkEnableOption "Discord";
    wrapDiscord = lib.mkEnableOption "wrap Discord to patch and enable Krisp audio support";
  };

  config = lib.mkIf (cfg.enable) {
    home.packages =
      if cfg.wrapDiscord
      then [wrappedDiscord]
      else [pkgs.discord];
  };
}
