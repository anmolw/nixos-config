{pkgs, ...}: {
  home.packages = with pkgs; [
    pyenv
    nixd
  ];
}
