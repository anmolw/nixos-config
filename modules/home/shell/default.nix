{ pkgs, ... }:
let
  catppuccinPrograms = [
    "atuin"
    "bat"
    "fzf"
    "btop"
    "yazi"
    "zellij"
  ];
in
{
  catppuccin = builtins.listToAttrs (
    map (val: {
      name = val;
      value = {
        enable = true;
        flavor = "mocha";
      };
    }) catppuccinPrograms
  );

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

  programs.fzf.enable = true;

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
  };

  programs.yazi.enable = true;

}
