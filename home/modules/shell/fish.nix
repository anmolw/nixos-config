{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.fish = {
    enable = true;
    shellInit = ''
      set fish_greeting
    '';
    plugins = [
      {
        name = "tide";
        src = pkgs.fishPlugins.tide.src;
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
  };
}
