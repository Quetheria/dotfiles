{
  description = "system flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let 
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

    in 
    {
      nixosConfigurations.default = nixpkgs.lib.nixosSystem { 
      formatter = pkgs.alejandra;
        modules = [
          ./system/default.nix
          inputs.home-manager.nixosModule.default {
            home-manager.useGlobalPackages = true;
            home-manager.useUserPackages = true;
            home-manager.users.cessna = import ./home/home.nix;
            home-manager.extraSpecialArgs = {inherit inputs;};

          }

        ];

      };

  };
  
}
