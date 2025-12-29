{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "github:hyprwm/Hyprland?submodules=1";
     hy3 = {
       url = "github:outfoxxed/hy3";
       inputs.hyprland.follows = "hyprland";
    };
  };
   
   outputs = { self, nixpkgs, home-manager, hyprland, hy3, ... }:   
      let
        lib = nixpkgs.lib;
	system = "x86_64-linux";
	pkgs = nixpkgs.legacyPackages.${system};
      in {
         nixosConfigurations.kys = nixpkgs.lib.nixosSystem {
          inherit system;         
          modules = [ ./configuration.nix ];
    };
      homeConfigurations.kartoma = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit hy3 hyprland; };
        modules = [ ./home.nix ]; 
      };
};
}
