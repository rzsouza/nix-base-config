{
  description = "Base Development Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }: {
    flakes.base-dev = import ./flakes/base-dev.nix;
    
    # standalone configuration
    homeConfigurations = {
      "rodrigo@base-dev" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [ ./flakes/base-dev.nix ];
      };
    };
  };
}
