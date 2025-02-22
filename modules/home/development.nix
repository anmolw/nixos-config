{ pkgs, ... }:
{
  home.packages = with pkgs; [
    alejandra
    treefmt
    nixfmt-rfc-style
    devenv
    poop
    # lazyjj
    nil
    nix-melt
    nixd
    tea
  ];

  programs.lazygit.enable = true;

  catppuccin.lazygit = {
    enable = true;
    flavor = "mocha";
  };

  programs.mise = {
    enable = true;
    globalConfig = {
      tools = {
        usage = "latest";
      };
    };
  };

  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
    };
  };

  programs.git = {
    enable = true;
    aliases = {
      unstage = "restore --staged";
    };
    includes = [
      {
        path = "~/.config/git/config-github";
        condition = "gitdir:~/code/github/";
      }
    ];
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  programs.jujutsu.enable = true;

  programs.git.diff-so-fancy.enable = true;

  programs.direnv = {
    enable = true;
    stdlib = ''
      layout_uv() {
        if [[ -d ".venv" ]]; then
            VIRTUAL_ENV="$(pwd)/.venv"
        fi

        if [[ -z $VIRTUAL_ENV || ! -d $VIRTUAL_ENV ]]; then
            log_status "No virtual environment exists. Executing \`uv venv\` to create one."
            uv venv
            VIRTUAL_ENV="$(pwd)/.venv"
        fi

        PATH_add "$VIRTUAL_ENV/bin"
        export UV_ACTIVE=1  # or VENV_ACTIVE=1
        export VIRTUAL_ENV
      }
    '';
    nix-direnv.enable = true;
  };

  programs.helix = {
    enable = true;
    settings = {
      theme = "catppuccin_mocha";
      editor = {
        line-number = "relative";
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "block";
        };
        end-of-line-diagnostics = "hint";
        true-color = true;
        # show warnings and errors on the cursorline inline
        inline-diagnostics.cursor-line = "warning";
      };
    };
    languages = {
      language = [
        {
          name = "nix";
          formatter = {
            command = "nixfmt";
          };
        }
      ];
    };
  };
}
