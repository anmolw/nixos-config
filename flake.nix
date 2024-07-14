{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
    nixpkgs-stable,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
  in {
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;

    # WSL Home manager configuration
    homeConfigurations."anmol@desktop" = let
      pkgs = import nixpkgs {
        inherit system;
      };
    in
      home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {inherit inputs;};
        modules = [
          ./home/profiles/wsl.nix
        ];
      };

    nixosConfigurations.blade = let
      stablePkgs = import nixpkgs-stable {inherit system;};
    in
      nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs stablePkgs;};
        modules = [
          inputs.sops-nix.nixosModules.default
          home-manager.nixosModules.default
          # inputs.chaotic.nixosModules.default
          ./nixos/hosts/blade/configuration.nix
        ];
      };

    nixosConfigurations.relic = let
      stablePkgs = import nixpkgs-stable {inherit system;};
    in
      nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs stablePkgs;};
        modules = [
          inputs.sops-nix.nixosModules.default
          inputs.disko.nixosModules.disko
          home-manager.nixosModules.default
          ./nixos/hosts/relic/configuration.nix
        ];
      };
  };
}
