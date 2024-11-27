{
  pkgs,
  lib,
  ...
}: {
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/2eaa5988-0623-4366-a78e-b7a92bd8399f";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/B93D-543C";
    fsType = "vfat";
    options = ["fmask=0022" "dmask=0022"];
  };

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
