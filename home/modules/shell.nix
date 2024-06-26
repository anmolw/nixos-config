{pkgs, ...}: {
  home.packages = with pkgs; [
    fzf
  ];

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    enableCompletion = true;
    syntaxHighlighting.enable = true;
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
  programs.zoxide.enable = true;

  programs.tealdeer = {
    enable = true;
    settings.updates = {
      auto_update = true;
    };
  };

  programs.tmux = {
    enable = true;
    baseIndex = 1;
    prefix = "C-a";
    mouse = true;
    extraConfig = ''
      set -g default-terminal "tmux-256color"
    '';
  };

  programs.eza = {
    enable = true;
    icons = true;
    git = true;
    extraOptions = [
      "-l"
      "--group-directories-first"
    ];
  };
}
