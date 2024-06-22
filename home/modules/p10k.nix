{pkgs, ...}: {
  programs.zsh.plugins = [
    {
      name = "powerlevel10k";
      src = pkgs.zsh-powerlevel10k;
      file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    }
  ];

  programs.zsh.initExtra = ''
    test -f ~/.config/zsh/.p10k.zsh && source ~/.config/zsh/.p10k.zsh
  '';
}
