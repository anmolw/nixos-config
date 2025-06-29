{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "nvme"
    "sd_mod"
    "usb_storage"
    "usbhid"
    "xhci_pci"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems = {
    "/boot" = {
      fsType = "vfat";
      device = "/dev/disk/by-uuid/5A38-FE95";
    };
    "/" = {
      options = [
        "subvol=@root"
        "compress=zstd:1"
      ];
      device = "/dev/disk/by-uuid/238023bf-e0b3-47fb-be73-37b720da7e3b";
    };
    "/home" = {
      fsType = "btrfs";
      options = [
        "subvol=@home"
        "compress=zstd:1"
      ];
      device = "/dev/disk/by-uuid/238023bf-e0b3-47fb-be73-37b720da7e3b";
    };
    "/nix" = {
      options = [
        "subvol=@nix"
        "compress=zstd:1"
      ];
      device = "/dev/disk/by-uuid/238023bf-e0b3-47fb-be73-37b720da7e3b";
    };
    "/var" = {
      options = [
        "subvol=@var"
        "compress=zstd:1"
      ];
      device = "/dev/disk/by-uuid/238023bf-e0b3-47fb-be73-37b720da7e3b";
    };
    "/tmp" = {
      options = [
        "subvol=@tmp"
        "compress=zstd:1"
      ];
      device = "/dev/disk/by-uuid/238023bf-e0b3-47fb-be73-37b720da7e3b";
    };
  };

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hardware.enableRedistributableFirmware = true;
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
