{
  description = "NixOS configuration for my work laptop @Famedly";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    famedly-nixos.url = "github:famedly/famedly-nixos";
    famedly-nixos.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, famedly-nixos, home-manager, ... }: {
    nixosConfigurations = {
      "scuzzy" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          famedly-nixos.nixosModules.default
          home-manager.nixosModules.home-manager
          # How does this part work, it doesn't look like a module?
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.amanda = ./home.nix;
          }
        ];
      };
    };
  };
}
