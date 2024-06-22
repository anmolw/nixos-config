{pkgs, ...}: {
  home.packages = with pkgs; [
    nil
    nixd
  ];

  programs.mise = {
    enable = true;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
