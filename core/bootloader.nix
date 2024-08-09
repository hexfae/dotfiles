{...}: {
  boot = {
    kernelParams = [
      "quiet"
      "udev.log_level=3"
      "systemd.show_status=auto"
      "splash"
      "nowatchdog"
      "nomce"
      "mitigations=off"
    ];
    plymouth.enable = true;
    initrd.verbose = false;
    consoleLogLevel = 3;
    tmp.cleanOnBoot = true;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      systemd-boot.configurationLimit = 20;
    };
  };
}
