{pkgs, ...}: {
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
  documentation.nixos.enable = false;

  environment.systemPackages = with pkgs; [
    acpi
    brightnessctl
    powertop
  ];

  services = {
    xserver = {
      enable = true;
      excludePackages = [pkgs.xterm];
    };
    libinput.mouse.accelProfile = "flat";
  };

  zramSwap = {
    enable = true;
  };
  powerManagement.cpuFreqGovernor = "performance";
  xdg.mime.enable = true;
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "24.05";

  services.xserver.xkb.layout = "se";
  time.timeZone = "Europe/Stockholm";
  console.keyMap = "sv-latin1";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "sv_SE.UTF-8";
      LC_IDENTIFICATION = "sv_SE.UTF-8";
      LC_MEASUREMENT = "sv_SE.UTF-8";
      LC_MONETARY = "sv_SE.UTF-8";
      LC_NAME = "sv_SE.UTF-8";
      LC_NUMERIC = "sv_SE.UTF-8";
      LC_PAPER = "sv_SE.UTF-8";
      LC_TELEPHONE = "sv_SE.UTF-8";
      LC_TIME = "sv_SE.UTF-8";
    };
  };
}
