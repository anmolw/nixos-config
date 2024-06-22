{
  config,
  pkgs,
  lib,
  ...
}: let
  wsl2-ssh-agent = pkgs.fetchurl {
    url = "https://github.com/mame/wsl2-ssh-agent/releases/download/v0.9.4/wsl2-ssh-agent";
    hash = "sha256-cecxTYdLjxFZPXcMW8j/NJugaCufqP9Yq/HcAnpslJM=";
  };
in {
  imports = [
    ../modules/shell.nix
    ../modules/p10k.nix
    ../modules/development.nix
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "anmol";
  home.homeDirectory = "/home/anmol";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    nh
    uv
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  programs.btop = {
    enable = true;
    settings.proc_gradient = false;
  };

  home.file.".local/bin/wsl2-ssh-agent" = {
    source = wsl2-ssh-agent;
    executable = true;
  };

  programs.zsh.initExtra = ''
    eval $($HOME/.local/bin/wsl2-ssh-agent)
  '';

  programs.mise = {
    globalConfig = {
      tools = {
        usage = "latest";
        node = "lts";
        python = "3.12";
      };
    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  home.sessionVariables = {
    EDITOR = "micro";
    FLAKE = "/home/anmol/code/nixos-config";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
