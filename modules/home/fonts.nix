{pkgs, ...}: {
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    fira-code
    jetbrains-mono
    monaspace
    maple-mono
    (nerdfonts.override {fonts = ["Hack" "Meslo" "FiraCode" "JetBrainsMono" "Monaspace"];})
  ];
}
