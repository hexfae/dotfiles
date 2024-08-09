{pkgs, ...}: {
  services.xserver.desktopManager.gnome.enable = true;
  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };
  environment.gnome.excludePackages =
    (with pkgs; [
      baobab
      epiphany
      geary
      snapshot
      totem
      evince
      simple-scan
      file-roller
      seahorse
      yelp
      adwaita-icon-theme
      gnome-themes-extra
      gnome-tour
      gnome-connections
      gnome-calendar
      gnome-calculator
      gnome-user-docs
      gnome-font-viewer
      gnome-console
      gnome-disk-utility
      gnome-system-monitor
      gnome-text-editor
    ])
    ++ (with pkgs.gnome; [
      gnome-music
      gnome-contacts
      gnome-weather
      gnome-clocks
      gnome-maps
      gnome-characters
      gnome-logs
      gnome-shell-extensions
    ]);
}
