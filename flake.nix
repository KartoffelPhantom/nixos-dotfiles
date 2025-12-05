{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
  };
  outputs = { self, nixpkgs }: {
      nixosConfigurations.kys = nixpkgs.lib.nixosSystem {
      	  modules = [ ./configuration.nix ];
    };
  }; 
}
