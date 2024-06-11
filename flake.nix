{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: {
    nixosConfigurations.blade = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        inputs.home-manager.nixosModules.default
        ./hosts/blade/configuration.nix
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.anmol.imports = [
            ./home/general.nix
            ./home/ssh.nix
            ./home/vscode.nix
            ./home/nixos-specific.nix
          ];
        }
      ];
    };
    nixosConfigurations.relic = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        inputs.disko.nixosModules.disko
        inputs.home-manager.nixosModules.default
        ./hosts/relic/configuration.nix
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.anmol.imports = [
            ./home/general.nix
            ./home/podman.nix
            ./home/nixos-specific.nix
          ];
        }
      ];
    };
  };
}
