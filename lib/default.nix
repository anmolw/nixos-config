{
  inputs,
  lib,
  ...
}:
{
  mkHm = import ./mkHm.nix { inherit lib inputs; };
  mkNixos = import ./mkNixos.nix { inherit lib inputs; };
}
