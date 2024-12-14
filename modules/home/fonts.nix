{ pkgs, ... }:
{
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    fira-code
    jetbrains-mono
    meslo-lg
    monaspace
    maple-mono
    nerd-fonts.fira-code
    nerd-fonts.meslo-lg
    nerd-fonts.jetbrains-mono
    nerd-fonts.monaspace
  ];
}
