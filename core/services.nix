{pkgs, ...}: {
  systemd.services.NetworkManager-wait-online.enable = false;
  services = {
    thermald.enable = true;
    power-profiles-daemon.enable = true;
    gvfs.enable = true;
    gnome.gnome-keyring.enable = true;
    dbus.enable = true;
    fstrim.enable = true;
    openssh.enable = true;
    searx = {
      enable = true;
      package = pkgs.searxng;
      settings = {
        server.secret_key = "";
      };
    };
    upower = {
      enable = true;
      percentageLow = 20;
      percentageCritical = 5;
      percentageAction = 3;
      criticalPowerAction = "PowerOff";
    };
  };
  # services.logind.extraConfig = ''
  #   HandlePowerKey=ignore
  # '';
}
