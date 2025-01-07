{
  description = "Andrei Jiroh's NixOS and home-manager configurations";

  # try to be in-sync with the nix-channels
  inputs = {
    # nixpkgs itself
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # home-manager
    home-manager.url = "github:nix-community/home-manager/master";
    # make sure to be in sync with our nixpkgs itself.
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Determinate Nix
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/0.1";

    # Community Extras
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    vscode-server.url = "github:nix-community/nixos-vscode-server";

    # nix-ld
    inputs.nix-ld.url = "github:Mic92/nix-ld";
    # this line assume that you also have nixpkgs as an input
    inputs.nix-ld.inputs.nixpkgs.follows = "nixpkgs";
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
      recoverykit-amd64 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/recoverykit/configuration.nix
          "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
        ];
      };

      stellapent-cier = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/stellapent-cier/configuration.nix

          # load Determinate Nix and the rest
          determinate.nixosModules.default
          home-manager.nixosModules.home-manager
          vscode-server.nixosModules.default
          nix-ld.nixosModules.nix-ld

          # one-liners?
          { programs.nix-ld.dev.enable = true; }
        ];
      };
    };
  };
}