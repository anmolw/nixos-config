{
  pkgs,
  config,
  lib,
  inputs,
  ...
}:
let
  cfg = config.programs.discord;

  patcher = "${inputs.keysmashes-sys}/hm/discord/krisp-patcher.py";

  python = pkgs.python3.withPackages (ps: [
    ps.pyelftools
    ps.capstone
  ]);

  wrapperScript = pkgs.writeShellScript "discord-wrapper" ''
    #set -euxo pipefail
    ${pkgs.findutils}/bin/find -L $HOME/.config/discord -name 'discord_krisp.node' -exec ${python}/bin/python3 ${patcher} {} +
    ${pkgs.discord}/bin/discord "$@"
  '';

  wrappedDiscord = pkgs.runCommand "discord" { } ''
    mkdir -p $out/share/applications $out/bin
    ln -s ${pkgs.discord}/share/pixmaps $out/share/pixmaps
    ln -s ${pkgs.discord}/share/icons $out/share/icons
    ln -s ${wrapperScript} $out/bin/discord
    ${pkgs.gnused}/bin/sed 's!Exec=.*!Exec=${wrapperScript}!g' ${pkgs.discord}/share/applications/discord.desktop > $out/share/applications/discord.desktop
  '';
in
{
  options.programs.discord = {
    enable = lib.mkEnableOption "Discord";
    wrapDiscord = lib.mkEnableOption "wrap Discord to patch and enable Krisp audio support";
  };

  config = lib.mkIf (cfg.enable) {
    environment.systemPackages = if cfg.wrapDiscord then [ wrappedDiscord ] else [ pkgs.discord ];
  };
}
