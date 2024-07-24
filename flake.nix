{
  description = "System configuration of elatella";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
	dagger = {
      url = "github:dagger/nix";
      inputs.nixpkgs.follows = "nixpkgs";
	};
  };

  outputs = { nixpkgs, nixos-hardware, lanzaboote, home-manager, dagger, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          nixos-hardware.nixosModules.dell-xps-13-9310
          lanzaboote.nixosModules.lanzaboote
          ./system
        ];
      };

      homeConfigurations.ela = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
		extraSpecialArgs = { inherit dagger; };
        modules = [ ./home ];
      };

      formatter.${system} = pkgs.nixpkgs-fmt;
    };
}
