{
  pkgs,
  inputs,
  ...
}:
let
  wsl2-ssh-agent = pkgs.fetchurl {
    url = "https://github.com/mame/wsl2-ssh-agent/releases/download/v0.9.5/wsl2-ssh-agent";
    hash = "sha256-xdJcVmjEEJnvVKE6wZA447R97IuV6VFcOUxLByweKq4=";
  };
in
{
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

  sops = {
    defaultSopsFile = ../secrets/hm.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/anmol/.config/sops/age/keys.txt";
    secrets = {
      "env/hass-token" = { };
      "env/hass-url" = { };
    };
  };

  home.stateVersion = "24.05"; # Please read the comment before changing.

  targets.genericLinux.enable = true;

  home.packages = with pkgs; [
    glow
    gum
    mdcat
    mods
    mosh
    nh
    nixos-rebuild
    pixi
    sops
    uv
    wishlist
    ansible
    terraform
    terraform-providers.digitalocean
    terraform-providers.docker
    wslu
    # It is sometimes useful to fine-tune packages, for example, by applying
    # overrides. You can do that directly here, just don't forget the
    # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # You can also create simple shell scripts directly inside your
    # configuration. For example, this adds a command 'my-hello' to your
    # environment:
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

  programs.zsh.envExtra = ''
    # Source the nix daemon script only if the parent process is sshd and the
    # shell is non-interactive
    if [[ ! -o interactive && $(ps -p $PPID --format=comm --no-header) == "sshd" ]]; then
      source /etc/profile.d/nix.sh
    fi
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
        deno = "latest";
        node = "lts";
        pnpm = "latest";
        python = "3.12";
        usage = "latest";
        yarn = "latest";
      };
    };
  };

  # With wslu installed, `done` causes a very annoying pause after entering
  # each command. Disable this plugin on WSL.
  programs.fish.disabledPlugins = [ "done" ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # You can also set the file content immediately.
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
    EDITOR = "nvim";
    FLAKE = "/home/anmol/code/github/nixos-config";
    PNPM_HOME = "$HOME/.local/share/pnpm";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
