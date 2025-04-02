{
  pkgs,
  lib,
  config,
  ...
}:
let
  pluginIsDisabled = plugin: builtins.elem plugin.name config.programs.fish.disabledPlugins;
  defaultPlugins = [
    {
      name = "tide";
      src = pkgs.fishPlugins.tide.src;
    }
    {
      name = "autopairs";
      src = pkgs.fishPlugins.autopair.src;
    }
    {
      name = "done";
      src = pkgs.fishPlugins.done.src;
    }
    {
      name = "bangbang";
      src = pkgs.fetchFromGitHub {
        owner = "oh-my-fish";
        repo = "plugin-bang-bang";
        rev = "ec991b80ba7d4dda7a962167b036efc5c2d79419";
        sha256 = "sha256-oPPCtFN2DPuM//c48SXb4TrFRjJtccg0YPXcAo0Lxq0=";
      };
    }
  ];
in
{
  options.programs.fish.disabledPlugins = lib.mkOption {
    description = "List of plugins to disable. (Only affects the default set of plugins)";
    default = [ ];
  };

  config = {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        ${pkgs.nix-your-shell}/bin/nix-your-shell fish | source
      '';
      shellInit = ''
        set fish_greeting
      '';
      plugins = builtins.filter (plugin: !pluginIsDisabled plugin) defaultPlugins;
      shellAbbrs = {
        g = "git";
        ga = "git add";
        gco = "git checkout";
        gd = "git diff";
        gds = "git diff --staged";
        gl = "git log";
        gs = "git status";
      };
    };
  };
}
