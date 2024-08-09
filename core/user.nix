{
  pkgs,
  inputs,
  username,
  host,
  ...
}: {
  imports = [inputs.home-manager.nixosModules.home-manager];
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {inherit inputs username host;};
    users.${username} = import ../home.nix;
  };

  users.users.${username} = {
    isNormalUser = true;
    description = "${username}";
    shell = pkgs.nushell;
    extraGroups = ["networkmanager" "wheel" "audio" "input"];
  };
}
