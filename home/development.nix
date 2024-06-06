{pkgs, ...}: {
  home.packages = with pkgs; [
    nil
    nixd
    pyenv
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
