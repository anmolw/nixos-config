{ config, ... }:
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
        signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINhjKonstq1xifZcoYcPkaqZmD6hOLMRdzq7xfhFrPLm anmol@desktop";
      };
      commit.gpgsign = true;
      tag.gpgsign = true;
      gpg.format = "ssh";
      init.defaultBranch = "main";
    };
  };
}
