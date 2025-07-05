{ pkgs, lib, ... }:
{
  environment.enableAllTerminfo = lib.mkDefault true;
}
