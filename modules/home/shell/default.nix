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
    nix-output-monitor
    hyperfine
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

  programs.bat = {
    enable = true;
    extraPackages = with pkgs.bat-extras; [batman];
    catppuccin.enable = true;
    catppuccin.flavor = "mocha";
  };

  programs.fzf.enable = true;
  programs.ripgrep.enable = true;
  programs.zoxide.enable = true;
  programs.fd.enable = true;

  programs.tealdeer = {
    enable = true;
    settings.updates = {
      auto_update = true;
    };
  };

  programs.jq.enable = true;

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
