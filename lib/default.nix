{
  pkgs,
  inputs,
  lib,
  ...
}:
{
  lib.mkHm =
    {
      user,
      sops,
      imports,
      modules,
    }:
    {
      home-manager = {
        extraSpecialArgs = { inherit inputs; };
        useGlobalPkgs = true;
        useUserPackages = true;
        sharedModules = [
          inputs.catppuccin.homeManagerModules.catppuccin
          inputs.sops-nix.homeManagerModules.sops
        ];
        users.${user} = {
          inherit sops;
          inherit imports;
        };
        inherit modules;
      };
    };

  lib.mkNixos = import ./mknixos.nix { inherit pkgs lib inputs; };
  # {
  #   hostname,
  #   system ? "x86_64-linux",
  #   modules ? [ ],
  #   mainUser ? "anmol",
  #   meta,
  #   sshKeys ? [ ],
  #   sops ? false,
  #   hm ? false,
  # }:
  # lib.nixosConfiguration {
  #   inherit hostname;
  #   inherit system;
  #   specialArgs = { inherit inputs; };
  #   modules = modules ++ [
  #     inputs.sops-nix.nixosModules.default
  #     (lib.mkIf hm inputs.home-manager.nixosModules.default)
  #     (lib.mkIf sops inputs.sops-nix.nixosModules.default)
  #     {
  #       users.users.${mainUser} = {
  #         isNormalUser = true;
  #         shell = pkgs.zsh;
  #         openssh.authorizedKeys.keys = sshKeys;
  #         extraGroups = [ "wheel" ];
  #       };
  #     }
  #   ];
  # };
}
