{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager-unstable = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-nixos-unstable,
    nixpkgs-unstable,
    home-manager,
    home-manager-unstable,
    ...
  } @ inputs: {
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;

    # WSL Home manager configuration
    homeConfigurations."anmol@desktop" = let
      pkgs = import nixpkgs-unstable {system = "x86_64-linux";};
    in
      home-manager-unstable.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home/profiles/wsl.nix
        ];
      };

    nixosConfigurations.blade = let
      pkgs-unstable = import nixpkgs-nixos-unstable {system = "x86_64-linux";};
    in
      nixpkgs.lib.nixosSystem {
        # specialArgs = {inherit inputs;};
        specialArgs = {inherit pkgs-unstable;};
        modules = [
          home-manager.nixosModules.default
          inputs.chaotic.nixosModules.default
          ./nixos/hosts/blade/configuration.nix
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home.stateVersion = "24.05";
            home-manager.users.anmol.imports = [
              inputs.nix-index-database.hmModules.nix-index
              ./home/profiles/blade.nix
            ];
          }
        ];
      };

    nixosConfigurations.relic = let
      pkgs-unstable = import nixpkgs-nixos-unstable {system = "x86_64-linux";};
    in
      nixpkgs.lib.nixosSystem {
        # specialArgs = {inherit inputs;};
        specialArgs = {inherit pkgs-unstable;};
        modules = [
          inputs.disko.nixosModules.disko
          home-manager.nixosModules.default
          ./nixos/hosts/relic/configuration.nix
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home.stateVersion = "24.05";
            home-manager.users.anmol.imports = [
              ./home/profiles/relic.nix
            ];
          }
        ];
      };
  };
}
