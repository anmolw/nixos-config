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
    url = "https://raw.githubusercontent.com/sersorrel/sys/3c1b4f2faffce32a5d2cae780a63872e7fb292bb/hm/discord/krisp-patcher.py";
    hash = "sha256-87VlZKw6QoXgQwEgxT3XeFY8gGoTDWIopGLOEdXkkjE=";
  };

  python = pkgs.python3.withPackages (ps: [ps.pyelftools ps.capstone]);

  wrapperScript = pkgs.writeShellScript "discord-wrapper" ''
    set -euxo pipefail
    ${pkgs.findutils}/bin/find -L $HOME/.config/discord -name 'discord_krisp.node' -exec ${python}/bin/python3 ${patcher} {} +
    ${pkgs.discord}/bin/discord "$@"
  '';

  wrappedDiscord = pkgs.runCommand "discord" {} ''
    mkdir -p $out/share/applications $out/bin
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
