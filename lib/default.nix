{
  inputs,
  lib,
  ...
}:
{
  mkHm =
    {
      user,
      sops ? false,
      imports,
      modules ? [ ],
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

  foo = "baz";

  mkNixos = import ./mknixos.nix { inherit lib inputs; };
}
