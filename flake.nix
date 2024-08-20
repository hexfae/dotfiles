{
  description = "Nixos config flake";

  inputs = {
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
      follows = "chaotic/nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    jovian = {
      url = "github:Jovian-Experiments/Jovian-NixOS";
      follows = "chaotic/jovian";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = {
    self,
    chaotic,
    nixpkgs,
    home-manager,
    jovian,
    disko,
    stylix,
    nixos-hardware,
  } @ inputs: let
    username = "hexfae";
    system = "x86_64-linux";
  in {
    nixosConfigurations.deck = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        chaotic.nixosModules.default
        home-manager.nixosModules.default
        jovian.nixosModules.default
        inputs.stylix.nixosModules.stylix
        nixos-hardware.nixosModules.common-cpu-amd
        nixos-hardware.nixosModules.common-gpu-amd
        nixos-hardware.nixosModules.common-pc
        nixos-hardware.nixosModules.common-pc-ssd
        ./deck/deck.nix
      ];
      specialArgs = {
        host = "deck";
        inherit self inputs username;
      };
    };

    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        chaotic.nixosModules.default
        home-manager.nixosModules.default
        disko.nixosModules.disko
        inputs.stylix.nixosModules.stylix
        nixos-hardware.nixosModules.common-cpu-amd
        nixos-hardware.nixosModules.common-gpu-amd
        nixos-hardware.nixosModules.common-pc
        nixos-hardware.nixosModules.common-pc-ssd
        ./laptop/laptop.nix
      ];
      specialArgs = {
        host = "laptop";
        inherit self inputs username;
      };
    };
  };
}
