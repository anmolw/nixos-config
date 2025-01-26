{ pkgs, inputs, ... }:
{
  lib.mkStandardHM =
    args@{
      user,
      sops,
      ...
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
        users.${args.user} = {
          inherit sops;
          imports = [ args.homeModule ];
        };
      };
    };
}
