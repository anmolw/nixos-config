{
  inputs,
  lib,
}:
{
  hostname,
  system ? "x86_64-linux",
  modules ? [ ],
  mainUser,
  meta ? { },
  sshKeys ? [ ],
  sops ? false,
  hm ? false,
}:
lib.nixosSystem {
  inherit system;
  specialArgs = {
    inherit inputs;
  };
  modules = modules ++ [
    (if hm then inputs.home-manager.nixosModules.default else { })
    (if sops then inputs.sops-nix.nixosModules.default else { })
    (
      { pkgs, config, ... }:
      {
        imports = [ ../modules/nixos/base.nix ];

        users.users.${mainUser} = {
          isNormalUser = true;
          shell = config.programs.fish.package;
          openssh.authorizedKeys.keys = sshKeys;
          extraGroups = [ "wheel" ];
        };

        networking.hostName = hostname;
      }
    )
  ];
}
