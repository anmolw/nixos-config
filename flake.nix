{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    ghostty = {
      url = "git+ssh://git@github.com/ghostty-org/ghostty";
      inputs.nixpkgs-stable.follows = "nixpkgs";
      inputs.nixpkgs-unstable.follows = "nixpkgs";
    };
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
          ./homes/wsl.nix
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
          inputs.chaotic.nixosModules.default
          inputs.catppuccin.nixosModules.catppuccin
          ./hosts/blade/configuration.nix
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
          ./hosts/relic/configuration.nix
        ];
      };
  };
}
