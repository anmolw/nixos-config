{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [
    ./fish.nix
    ./tmux.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    dua
    erdtree
    nix-search-cli
  ];

  programs.btop = {
    enable = true;
    settings.proc_gradient = false;
  };

  programs.atuin = {
    enable = true;
  };

  programs.micro = {
    enable = true;
    settings = {
      autosu = true;
      mkparents = true;
      scrollbar = true;
      tabsize = 2;
    };
  };

  programs.bat.enable = true;
  programs.fzf.enable = true;
  programs.zoxide.enable = true;
  programs.fd.enable = true;

  programs.tealdeer = {
    enable = true;
    settings.updates = {
      auto_update = true;
    };
  };

  programs.eza = {
    enable = true;
    icons = "auto";
    git = true;
    extraOptions = [
      "-l"
      "--group-directories-first"
    ];
  };

  programs.zellij = {
    enable = true;
    settings = {
      theme = "catppuccin-mocha";
    };
  };

  programs.yazi.enable = true;
}
