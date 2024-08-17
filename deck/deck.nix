{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../desktop/gnome.nix
    ../core
  ];

  jovian = {
    hardware.has.amd.gpu = true;
    devices.steamdeck = {
      enable = true;
      autoUpdate = true;
    };
    steam = {
      enable = true;
      autoStart = true;
      desktopSession = "gnome";
      user = "hexfae";
    };
  };

  environment.systemPackages = with pkgs; [
    jupiter-dock-updater-bin
    steamdeck-firmware
  ];

  stylix = {
    enable = true;
    image = ./keys.png;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/onedark.yaml";
    cursor = {
      package = pkgs.posy-cursors;
      name = "Posy_Cursor_Black";
    };
    fonts = {
      serif = {
        package = pkgs.roboto-slab;
        name = "Roboto Slab";
      };
      sansSerif = {
        package = pkgs.roboto;
        name = "Roboto";
      };
      monospace = {
        package = pkgs.maple-mono-NF;
        name = "Maple Mono NF";
      };
      emoji = {
        package = pkgs.twitter-color-emoji;
        name = "Twitter Color Emoji";
      };
    };
  };
}
