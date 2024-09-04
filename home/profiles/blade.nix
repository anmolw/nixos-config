{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ../modules/shell
    ../modules/development.nix
    ../modules/ssh.nix
    ../modules/fonts.nix
    ../modules/vscode.nix
    ../modules/krisp.nix
    ../modules/nixos-specific.nix
  ];

  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    btdu
    fastfetch
    ktailctl
    obsidian
    jellyfin-media-player
    moonlight-qt
    python3
    syncthingtray-minimal
  ];

  programs.zsh.p10k.enable = true;

  services.syncthing = {
    enable = true;
  };

  programs.alacritty = {
    enable = true;
    settings = {
      font.normal = {
        family = "Hack Nerd Font Mono";
        style = "Regular";
      };
      shell = {
        program = "tmux";
        args = ["new" "-As0"];
      };
    };
  };

  programs.kitty = {
    enable = true;
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
