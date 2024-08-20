{
  disko.devices = {
    disk = {
      main = {
        device = "/dev/sda";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            boot = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            root = {
              end = "-20G";
              content = {
                type = "filesystem";
                format = "bcachefs";
                mountpoint = "/";
                extraArgs = [
                  "--encrypted"
                  "--compression=lz4:8"
                ];
              };
            };
            swap = {
              size = "100%";
              content = {
                type = "luks";
                name = "swap";
                settings.allowDiscards = true;
                # passwordFile = "/mnt-root/root/swap.key";
                # settings.keyFile = "/mnt-root/root/swap.key";
                # additionalKeyFiles = ["/root/swap.key" "/mnt-root/root/swap.key"];
                content = {
                  type = "swap";
                  priority = 100;
                  discardPolicy = "both";
                  resumeDevice = true;
                };
              };
            };
          };
        };
      };
    };
    nodev = {
      "/tmp" = {
        fsType = "tmpfs";
        mountOptions = [
          "size=10G"
        ];
      };
    };
  };
}
