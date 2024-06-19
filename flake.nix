{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: {
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;

    nixosConfigurations.blade = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        inputs.home-manager.nixosModules.default
        ./nixos/hosts/blade/configuration.nix
        inputs.chaotic.nixosModules.default
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.anmol.imports = [
            inputs.nix-index-database.hmModules.nix-index
            ./home/profiles/blade.nix
          ];
        }
      ];
    };
    nixosConfigurations.relic = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        inputs.disko.nixosModules.disko
        inputs.home-manager.nixosModules.default
        ./nixos/hosts/relic/configuration.nix
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.anmol.imports = [
            ./home/profiles/relic.nix
          ];
        }
      ];
    };
  };
}
