{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    sersorrel-sys = {
      type = "github";
      owner = "sersorrel";
      repo = "sys";
      rev = "a88ae627fcbd38c0229364d4ba90e2b0a3cbc2bc";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
      home-manager,
      ...
    }@inputs:
    let
      forAllSystems = with nixpkgs.lib; genAttrs systems.flakeExposed;
    in
    {
      packages = forAllSystems (
        system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          arch-profile = pkgs.buildEnv {
            name = "arch-profile";
            paths = with pkgs; [
              nixos-rebuild
              devenv
              nix-output-monitor
              nix-search-cli
              treefmt
              nixos-rebuild-ng
              nixd
              alejandra
              nixfmt-rfc-style
            ];
          };
        }
      );

      homeConfigurations =
        let
          system = "x86_64-linux";
          pkgs = import nixpkgs { inherit system; };
        in
        {
          "anmol@desktop" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            extraSpecialArgs = { inherit inputs; };
            modules = [
              ./homes/wsl.nix
            ];
          };
        };

      nixosConfigurations =
        let
          system = "x86_64-linux";
          stablePkgs = import nixpkgs-stable { inherit system; };
        in
        {
          blade = nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = { inherit inputs stablePkgs; };
            modules = [
              inputs.sops-nix.nixosModules.default
              home-manager.nixosModules.default
              inputs.chaotic.nixosModules.default
              inputs.catppuccin.nixosModules.catppuccin
              ./hosts/blade/configuration.nix
            ];
          };

          relic = nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = { inherit inputs stablePkgs; };
            modules = [
              inputs.sops-nix.nixosModules.default
              inputs.disko.nixosModules.disko
              home-manager.nixosModules.default
              ./hosts/relic/configuration.nix
            ];
          };
        };
    };
}
