{pkgs, ...}: {
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    fira-code
    (nerdfonts.override {fonts = ["Hack" "Meslo" "FiraCode"];})
  ];
}
