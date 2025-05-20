{ lib, modulesPath, ... }:
{
  imports = [ (modulesPath + "/profiles/qemu-guest.nix") ];

  boot.initrd.availableKernelModules = [
    "virtio_scsi"
    "virtio_gpu"
    "virtio_pci"
    "sd_mod"
    "sr_mod"
    "xhci_pci"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelParams = [ "console=tty" ];
  boot.extraModulePackages = [ ];

  swapDevices = [ ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
