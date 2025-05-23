{ pkgs, ... }:
{
  imports = [
    ./fish.nix
    ./tmux.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    dfrs
    dua
    erdtree
    hyperfine
    nix-output-monitor
    nix-search-cli
    nvd
    shpool
  ];

  home.sessionVariables = {
    # PAGER = "bat --plain";
  };

  home.shellAliases = {
    man = "batman";
  };

  programs.btop = {
    enable = true;
    settings.proc_gradient = false;
  };

  catppuccin.btop = {
    enable = true;
    flavor = "mocha";
  };

  programs.atuin = {
    enable = true;
  };

  programs.micro = {
    enable = true;
    settings = {
      autosu = true;
      mkparents = true;
      scrollbar = true;
      tabsize = 2;
    };
  };

  programs.bat = {
    enable = true;
    extraPackages = with pkgs.bat-extras; [ batman ];
  };

  catppuccin.bat = {
    enable = true;
    flavor = "mocha";
  };

  programs.fzf.enable = true;

  catppuccin.fzf = {
    enable = true;
    flavor = "mocha";
  };

  programs.ripgrep.enable = true;
  programs.zoxide.enable = true;
  programs.fd.enable = true;

  programs.tealdeer = {
    enable = true;
    settings.updates = {
      auto_update = true;
    };
  };

  programs.jq.enable = true;

  programs.eza = {
    enable = true;
    icons = "auto";
    git = true;
    extraOptions = [
      "-l"
      "--group-directories-first"
    ];
  };

  programs.zellij = {
    enable = true;
    enableZshIntegration = false;
    enableFishIntegration = false;
    enableBashIntegration = false;
    settings = {
      theme = "catppuccin-mocha";
    };
  };

  programs.yazi.enable = true;

  catppuccin.yazi = {
    enable = true;
    flavor = "mocha";
  };

}
