{
  pkgs,
  inputs,
  lib,
}:
{
  hostname,
  system ? "x86_64-linux",
  modules ? [ ],
  mainUser ? "anmol",
  meta,
  sshKeys ? [ ],
  sops ? false,
  hm ? false,
}:
lib.nixosConfiguration {
  inherit hostname;
  inherit system;
  specialArgs = { inherit inputs; };
  modules = modules ++ [
    inputs.sops-nix.nixosModules.default
    (lib.mkIf hm inputs.home-manager.nixosModules.default)
    (lib.mkIf sops inputs.sops-nix.nixosModules.default)
    {
      users.users.${mainUser} = {
        isNormalUser = true;
        shell = pkgs.zsh;
        openssh.authorizedKeys.keys = sshKeys;
        extraGroups = [ "wheel" ];
      };
    }
  ];
}
