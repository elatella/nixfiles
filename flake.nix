{
  description = "System configuration of elatella";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    dagger.url = "github:dagger/nix";
    dagger.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixos-hardware, lanzaboote, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          nixos-hardware.nixosModules.tuxedo-infinitybook-pro14-gen7
          lanzaboote.nixosModules.lanzaboote
          ./system
        ];
      };

      homeConfigurations.ela = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home ];
      };

      flake-utils.lib.eachDefaultSystem (system:
      let
      pkgs = nixpkgs.legacyPackages.${system};
      in {
      devShell = pkgs.mkShell {
        buildInputs = [ dagger.packages.dagger ];
      };
    });

  formatter.${system} = pkgs.nixpkgs-fmt;
};
}
