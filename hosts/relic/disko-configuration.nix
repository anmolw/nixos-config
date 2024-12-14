{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/disk/by-id/ata-SPCC_Solid_State_Disk_AA231020S325606479";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };

            root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ]; # Override existing partition
                # Subvolumes must set a mountpoint in order to be mounted,
                # unless their parent is mounted
                subvolumes = {
                  "/@root" = {
                    mountOptions = [ "compress=zstd:2" ];
                    mountpoint = "/";
                  };
                  "/@home" = {
                    mountOptions = [ "compress=zstd:2" ];
                    mountpoint = "/home";
                  };
                  "/@var" = {
                    mountOptions = [
                      "compress=zstd:2"
                      "noatime"
                    ];
                    mountpoint = "/var";
                  };
                  "/@tmp" = {
                    mountOptions = [
                      "compress=zstd:2"
                      "noatime"
                    ];
                    mountpoint = "/tmp";
                  };
                  # Parent is not mounted so the mountpoint must be set
                  "/@nix" = {
                    mountOptions = [
                      "compress=zstd:2"
                      "noatime"
                    ];
                    mountpoint = "/nix";
                  };
                  # Subvolume for the swapfile
                  "/@swap" = {
                    mountpoint = "/swap";
                    swap = {
                      swapfile.size = "4G";
                      swapfile.path = "swapfile";
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
