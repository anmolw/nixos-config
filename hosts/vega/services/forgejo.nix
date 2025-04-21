{ pkgs, config, ... }:
let
  cfg = config.services.forgejo;
  srv = cfg.settings.server;
in
{
  services.forgejo = {
    enable = true;
    user = "git";
    group = "git";
    package = pkgs.forgejo;
    settings = {
      server = {
        DOMAIN = "git.anmolw.com";
        ROOT_URL = "https://${srv.DOMAIN}";
        HTTP_PORT = 3000;
        SSH_USER = "git";
        SSH_DOMAIN = "anmolw.com";
        SSH_PORT = 22;
      };
      service = {
        DISABLE_REGISTRATION = true;
      };
    };
  };

  users.users.git = {
    isSystemUser = true;
    useDefaultShell = true;
    group = "git";
    home = cfg.stateDir;
  };
  users.groups.git = { };
}
