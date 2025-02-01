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

    alejandra.url = "github:kamadorueda/alejandra/3.1.0";
    alejandra.inputs.nixpkgs.follows = "nixpkgs";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    alejandra,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    formatter.${system} = pkgs.alejandra;
    nixosConfigurations.cessna = nixpkgs.lib.nixosSystem {
      modules = [
        ./system/default.nix
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.cessna = {...}: {imports = [./home/home.nix];};
          home-manager.extraSpecialArgs = {inherit inputs;};
        }
      ];
    };
  };
}
