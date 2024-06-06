{pkgs, ...}: {
  home.packages = with pkgs; [
    tealdeer
    fzf
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
  };

  programs.bat.enable = true;
  programs.zoxide.enable = true;

  programs.eza = {
    enable = true;
    icons = true;
    git = true;
    extraOptions = [
      "-l"
      "--group-directories-first"
    ];
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";
}
