{
	description = "Based thrixOS Flake BTW";

  	inputs = {
    		nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

		# ----------------- HERE ARE INPUTS -----------------
		nix-software-center.url = "github:snowfallorg/nix-software-center";
		quickshell = {
      			url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      			inputs.nixpkgs.follows = "nixpkgs";
    		};

    		qml-niri = {
      			url = "github:imiric/qml-niri/main";
      			inputs.nixpkgs.follows = "nixpkgs";
      			inputs.quickshell.follows = "quickshell";
    		};
  	};

  	outputs = { self, nixpkgs, nix-software-center, qml-niri, quickshell, ... }:
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
						qml-niri.packages.${system}.default
						quickshell.packages.${system}.default
					];
        			}
      			];
    		};
  	};
}
