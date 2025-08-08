{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.programs.zsh;
in
{
  options.programs.zsh.p10k.enable = lib.mkEnableOption "Enable powerlevel10k";

  config.programs.zsh = lib.mkMerge [
    {
      enable = true;
      dotDir = "${config.xdg.configHome}/zsh";
      enableCompletion = true;
      autosuggestion.enable = true;
      plugins = [
        {
          name = "fast-syntax-highlighting";
          src = pkgs.zsh-fast-syntax-highlighting;
          file = "share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh";
        }
      ];
    }
    (lib.mkIf (cfg.enable && cfg.p10k.enable) {
      plugins = [
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
      ];

      initContent = lib.mkMerge [
        (lib.mkBefore ''
          # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
          # Initialization code that may require console input (password prompts, [y/n]
          # confirmations, etc.) must go above this block; everything else may go below.
          if [[ -r "$\{XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-$\{(%):-%n}.zsh" ]]; then
            source "$\{XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-$\{(%):-%n}.zsh"
          fi
        '')
        (lib.mkAfter ''
          test -f ~/.config/zsh/.p10k.zsh && source ~/.config/zsh/.p10k.zsh
        '')
      ];
    })
  ];
}
