{
  description = "Andrei Jiroh's NixOS configurations";

  # try to be in-sync with the nix-channels
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
    };
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };
    determinate = {
      url = "https://flakehub.com/f/DeterminateSystems/determinate/0.1";
    };
    vscode-server = {
      url = "github:nix-community/nixos-vscode-server";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixos-hardware,
    determinate,
    vscode-server
  }: {
    nixosConfigurations = {
      stellapent-cier = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          determinate.nixosModules.default
          vscode-server.nixosModules.default
          home-manager.nixosModules.home-manager
          ./hosts/stellapent-cier/configuration.nix
        ];
      };
    };
  };
}