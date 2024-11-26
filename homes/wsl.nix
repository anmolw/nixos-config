{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  wsl2-ssh-agent = pkgs.fetchurl {
    url = "https://github.com/mame/wsl2-ssh-agent/releases/download/v0.9.5/wsl2-ssh-agent";
    hash = "sha256-xdJcVmjEEJnvVKE6wZA447R97IuV6VFcOUxLByweKq4=";
  };
in {
  imports = [
    inputs.catppuccin.homeManagerModules.catppuccin
    inputs.sops-nix.homeManagerModules.sops
    ../modules/home/shell
    ../modules/home/development.nix
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "anmol";
  home.homeDirectory = "/home/anmol";

  nixpkgs.config.allowUnfree = true;

  # Secrets setup
  sops.defaultSopsFile = ../secrets/wsl.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = /home/anmol/.config/sops/age/keys.txt;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  targets.genericLinux.enable = true;

  home.packages = with pkgs; [
    mdcat
    glow
    gum
    mods
    nh
    pixi
    sops
    uv
    wishlist
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

  home.file.".local/bin/wsl2-ssh-agent" = {
    source = wsl2-ssh-agent;
    executable = true;
  };

  programs.zsh.initExtra = ''
    eval $($HOME/.local/bin/wsl2-ssh-agent)
  '';

  programs.zsh.p10k.enable = true;

  programs.fish.shellInit = ''
    if not set -q SSH_AUTH_SOCK
      SHELL=fish wsl2-ssh-agent | source
    end
  '';

  programs.tmux.extraConfig = ''
    set -g default-command ${pkgs.fish}/bin/fish
    set -g default-shell ${pkgs.fish}/bin/fish
  '';

  programs.mise = {
    globalConfig = {
      tools = {
        usage = "latest";
        node = "lts";
        python = "3.12";
        yarn = "latest";
        pnpm = "latest";
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
    "/mnt/c/Users/anmol/AppData/Local/Programs/Microsoft VS Code/bin"
    "$HOME/.local/bin"
    "$HOME/.cargo/bin"
    "$HOME/.local/share/pnpm"
  ];

  home.sessionVariables = {
    EDITOR = "micro";
    FLAKE = "/home/anmol/code/nixos-config";
    PNPM_HOME = "$HOME/.local/share/pnpm";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}