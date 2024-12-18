{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ../modules/home/shell
    ../modules/home/development.nix
    ../modules/home/ssh.nix
    ../modules/home/fonts.nix
    ../modules/home/vscode.nix
    ../modules/home/krisp.nix
    ../modules/home/nixos-specific.nix
  ];

  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    btdu
    fastfetch
    inputs.ghostty.packages.x86_64-linux.default
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

  xdg.configFile."ghostty/config".text = ''
    command = fish

    font-family = Fira Code
    font-size = 12
    font-feature = -calt
    font-feature = -dlig
    font-feature = -liga

    shell-integration-features = no-cursor,sudo

    cursor-style = block
    cursor-style-blink = false

    theme = catppuccin-mocha
    window-theme = ghostty
  '';

  programs.alacritty = {
    enable = true;
    settings = {
      font.normal = {
        family = "FiraCode Nerd Font Mono";
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
      name = "Fira Code";
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
