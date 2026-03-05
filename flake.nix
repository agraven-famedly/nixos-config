{
  description = "NixOS configuration for my work laptop @Famedly";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    famedly-nixos.url = "github:famedly/famedly-nixos";
    famedly-nixos.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      nixpkgs,
      famedly-nixos,
      ...
    }:
    {
      nixosConfigurations = {
        "scuzzy" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
	    famedly-nixos.nixosModules.default
          ];
        };
      };
    };
}
