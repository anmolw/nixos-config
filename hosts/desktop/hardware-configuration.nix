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
    "ahci"
    "nvme"
    "sd_mod"
    "usb_storage"
    "usbhid"
    "xhci_pci"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/562dcb29-1cc6-464d-bd10-474a6712bf39";
    fsType = "btrfs";
    options = [
      "subvol=@root"
      "compress=zstd:1"
    ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/F3C5-18F1";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/562dcb29-1cc6-464d-bd10-474a6712bf39";
    fsType = "btrfs";
    options = [
      "subvol=@nix"
      "compress=zstd:1"
    ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/562dcb29-1cc6-464d-bd10-474a6712bf39";
    fsType = "btrfs";
    options = [
      "subvol=@home"
      "compress=zstd:1"
    ];
  };

  swapDevices = [ ];

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hardware.enableRedistributableFirmware = true;
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
