{
  pkgs,
  config,
  ...
}:
{
  imports = [
    ../modules/home/shell
    ../modules/home/development
    ../modules/home/ssh.nix
    ../modules/home/gpg.nix
    ../modules/home/fonts.nix
    ../modules/home/vscode.nix
    ../modules/home/krisp.nix
    ../modules/home/nixos-specific.nix
  ];

  home.stateVersion = "24.05";

  # HM Secrets setup
  sops = {
    defaultSopsFile = ../secrets/hm.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/anmol/.config/sops/age/keys.txt";
    secrets = {
      "env/hass-token" = { };
      "env/hass-url" = { };
    };
  };

  programs.fish.shellInit = ''
    set -gx HASS_TOKEN (cat ${config.sops.secrets."env/hass-token".path})
    set -gx HASS_URL (cat ${config.sops.secrets."env/hass-url".path})
  '';

  programs.zsh.initContent = ''
    export HASS_TOKEN="$(cat ${config.sops.secrets."env/hass-token".path})"
    export HASS_URL="$(cat ${config.sops.secrets."env/hass-url".path}))"
  '';

  home.packages = with pkgs; [
    btdu
    fastfetch
    jellyfin-media-player
    ktailctl
    moonlight-qt
    obsidian
    syncthingtray-minimal
  ];

  programs.zsh.p10k.enable = true;

  services.syncthing = {
    enable = true;
  };

  programs.ghostty = {
    enable = true;
    settings = {
      command = "fish";

      theme = "catppuccin-mocha";
      window-theme = "ghostty";

      font-family = "JetBrains Mono";
      font-size = 12;
      font-feature = [
        "-calt"
        "-dlig"
        "-liga"
      ];
      adjust-underline-position = -1;
      freetype-load-flags = "no-force-autohint";

      cursor-style = "block";
      cursor-style-blink = "false";

      gtk-single-instance = true;
      shell-integration-features = "no-cursor,sudo";
    };
  };

  programs.alacritty = {
    enable = true;
    settings = {
      font.normal = {
        family = "JetBrainsMono Nerd Font";
        style = "Regular";
      };
      shell = {
        program = "tmux";
        args = [
          "new"
          "-As0"
        ];
      };
    };
  };

  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Mocha";
    font = {
      name = "JetBrains Mono";
      size = 12;
    };
    settings = {
      shell = "fish";
    };
    shellIntegration.mode = "no-cursor";
  };

  programs.wezterm = {
    enable = true;
  };

  programs.tmux.extraConfig = ''
    set -g default-command ${pkgs.fish}/bin/fish
    set -g default-shell ${pkgs.fish}/bin/fish
  '';

  programs.discord.enable = true;
  programs.discord.wrapDiscord = true;
}
