{...}: {
  services.xserver.videoDrivers = ["amdgpu"];
  hardware = {
    enableAllFirmware = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
