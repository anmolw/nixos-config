{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscode-fhs;
    enableUpdateCheck = false;
  };
}
