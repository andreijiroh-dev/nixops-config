{
  description = "Andrei Jiroh's NixOS and home-manager configurations in one place, seperate from the dotfiles repo";

  # try to be in-sync with the nix-channels
  inputs = {
    # nixpkgs itself
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1.0.tar.gz";

    # home-manager
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Determinate Nix
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/0.1";

    # Community Extras
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    vscode-server.url = "github:nix-community/nixos-vscode-server";
    vscode-server.inputs.nixpkgs.follows = "nixpkgs";

    # nix-ld
    nix-ld = {
      url = "github:Mic92/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixos-hardware,
    determinate,
    vscode-server,
    nix-ld
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
    homeConfigurations = {
      gildedguy = home-manager.lib.homeManagerConfiguration {
        modules = [
          ./shared/home-manager/main.nix
          {
            home.username = "gildedguy";
            home.homeDirectory = "/home/gildedguy";
          }
        ];

        extraSpecialArgs = {
          home = {
            useUserPackages = true;
            useGlobalPkgs = true;
          };
        };
      };

      ajhalili2006 = home-manager.lib.homeManagerConfiguration {
        modules = [
          ./shared/home-manager/main.nix
          {
            home.username = "ajhalili2006";
            home.homeDirectory = "/home/ajhalili2006";
          }
        ];

        extraSpecialArgs = {
          home = {
            useUserPackages = true;
            useGlobalPkgs = true;
          };
        };
      };
    };
    nixosModules = {
      flatpak = ./shared/flatpak.nix;
      gnupg = ./shared/gnupg.nix;
      locale = ./shared/locale.nix;
      metaConfigs = ./shared/meta-configs.nix;
      networking = ./shared/networking.nix;
      sshKeys = ./shared/ssh-keys.nix;
      devenv = ./shared/server/devenv.nix;
      server = {
        devenv = ./shared/server/devenv.nix;
        firewall = ./shared/server/firewall.nix;
        ssh = ./shared/server/ssh.nix;
        tailscale = ./shared/server/tailscale.nix;
      };
      desktop = {
        bluetooth = ./shared/desktop/bluetooth.nix;
        firewall = ./shared/desktop/firewall.nix;
        kdePlasma = ./shared/desktop/kde-plasma.nix;
      };
    };
  };
}