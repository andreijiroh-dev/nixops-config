{
  description = "Andrei Jiroh's NixOS and home-manager configurations (AKA declarative dotfiles) in one place";

  # try to be in-sync with the nix-channels
  inputs = {
    # nixpkgs itself
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # home-manager
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Determinate Nix
    determinate = {
      url = "https://flakehub.com/f/DeterminateSystems/determinate/0.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Community Extras
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    vscode-server = {
      url = "github:nix-community/nixos-vscode-server";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # flake utils
    flake-utils.url = "github:numtide/flake-utils";

    # nix-ld
    nix-ld = {
      url = "github:Mic92/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # nixos-generators
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
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
    nix-ld,
    flake-utils,
    systems,
    nixos-generators
  }:
  {
    nixosConfigurations = {
      recoverykit-amd64 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/recoverykit/configuration.nix
          "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
        ];
      };

      portable-amd64-256gb = {
        system = "x86_64-linux";
        modules = [
          ./hosts/portable/amd64/configuration.nix

          # load Determinate Nix and the rest
          determinate.nixosModules.default
          home-manager.nixosModules.home-manager
          vscode-server.nixosModules.default
          nix-ld.nixosModules.nix-ld

          # one-liners?
          { programs.nix-ld.dev.enable = true; }
        ];
      };

      stellapent-cier = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/stellapent-cier/configuration.nix
          ./hosts/stellapent-cier/hardware-configuration.nix

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
      # Usage
      # - From GitHub:
      #  nix run home-manager/master -- switch --flake github:andreijiroh-dev/nixops-config#stellapent-cier
      # - Locally:
      #  nix run home-manager/master -- switch --flake .#stellapent-cier
      stellapent-cier = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [
          ./shared/home-manager/main.nix
          {
            home = {
              username = "gildedguy";
              homeDirectory = "/home/gildedguy";
              useGlobalPkgs = true;
            };
          }
        ];
      };

      # Usage
      # - From GitHub:
      #  nix run home-manager/master -- switch --flake github:andreijiroh-dev/nixops-config#plain
      # - Locally:
      #  nix run home-manager/master -- switch --flake .#plain
      plain = home-manager.lib.homeManagerConfiguration {
        modules = [
          ./shared/home-manager/main.nix
          {
            home.username = "ajhalili2006";
            home.homeDirectory = "/home/ajhalili2006";
            home.useUserPackages = true;
            home.useGlobalPkgs = true;
          }
        ];
      };
    };

    # This is for external users who want to reproduce my configs as needed
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
