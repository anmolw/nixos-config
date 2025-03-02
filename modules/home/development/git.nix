{
  programs.git = {
    enable = true;
    aliases = {
      unstage = "restore --staged";
    };
    includes = [
      {
        path = "~/.config/git/config-github";
        condition = "gitdir:~/code/github/";
      }
    ];
    extraConfig = {
      user = {
        name = "anmolw";
        email = "4815989+anmolw@users.noreply.github.com";
      };
      init.defaultBranch = "main";
    };
  };
}
