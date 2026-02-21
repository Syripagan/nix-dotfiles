{
  description = "Based thrixOS Flake BTW";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nix-software-center.url = "github:snowfallorg/nix-software-center";
  };

  outputs = { self, nixpkgs, nix-software-center, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in
  {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [
        ./configuration.nix
        {
          environment.systemPackages = [
            nix-software-center.packages.${system}.default
          ];
        }
      ];
    };
  };
}
