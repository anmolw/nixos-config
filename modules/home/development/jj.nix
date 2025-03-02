{ config, pkgs, ... }:
{
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = "anmolw";
        email = "4815989+anmolw@users.noreply.github.com";
      };
      aliases = {
        fetch = [
          "git"
          "fetch"
        ];
        l = [ "log" ];
        la = [
          "log"
          "-r"
          "::"
        ];
        push = [
          "git"
          "push"
        ];
        s = [
          "status"
        ];
      };
      signing = {
        sign-all = true;
        backend = "ssh";
        key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINhjKonstq1xifZcoYcPkaqZmD6hOLMRdzq7xfhFrPLm anmol@desktop";
      };
      git.sign-on-push = true;
      template-aliases = {
        "format_short_signature(signature)" = "    coalesce(signature.name(), name_placeholder)";
        "format_short_commit_header(commit)" = ''
          separate(" ",
              format_short_change_id_with_hidden_and_divergent_info(commit),
              if(commit.signature(), "", ""),
              format_short_signature(commit.author()),
              format_timestamp(commit_timestamp(commit)),
              commit.bookmarks(),
              commit.tags(),
              commit.working_copies(),
              if(commit.git_head(), label("git_head", "git_head()")),
              format_short_commit_id(commit.commit_id()),
              if(commit.conflict(), label("conflict", "conflict")),
              if(config("ui.show-cryptographic-signatures").as_boolean(),
                  format_short_cryptographic_signature(commit.signature())),)
        '';
      };
      merge-tools.delta.diff-expected-exit-codes = [
        0
        1
      ];
      ui = {
        default-command = "log";
        pager = [
          "delta"
        ];
        diff = {
          format = "git";
        };
      };
    };
  };
}
