{
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
