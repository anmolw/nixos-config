{
  inputs,
  lib,
  pkgs,
}:
{
  user,
  imports,
  modules ? [ ],
  catppuccin ? false,
  sops ? false,
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
}
