{pkgs, ...}: {
  home.packages = with pkgs; [
    fzf
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
  };

  programs.atuin = {
    enable = true;
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
