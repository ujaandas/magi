{
  description = "a basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    hardware.url = "github:nixos/nixos-hardware/master";
  };

  outputs = 
    inputs@{
      self,
      nixpkgs,
      hardware
    }:
    {
      nixosConfigurations = {
        vm = nixpkgs.lib.nixosSystem {
	  specialArgs = { inherit self inputs; };
	  system = "x86_64-linux";
	  modules = [
	    ./hosts/vm
	  ];
	};
      };
    };
}
