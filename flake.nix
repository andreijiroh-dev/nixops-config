{
  description = "Andrei Jiroh's NixOS and home-manager configurations (AKA declarative dotfiles)";

  # try to be in-sync with the nix-channels
  inputs = {
    # nixpkgs essientials
    lib.url = "github:nix-community/nixpkgs.lib";
    nixpkgs.url = "https://flakehub.com/f/DeterminateSystems/nixpkgs-weekly/*.tar.gz";
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs = {
        systems = {
          follows = "systems";
        };
      };
    };
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    systems = {
      url = "github:nix-systems/default";
    };

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
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    # nix-ld
    nix-ld = {
      url = "github:Mic92/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      nixos-hardware,
      determinate,
      vscode-server,
      nix-ld,
      flake-utils,
      systems,
      nixos-generators,
      lib,
      zen-browser,
    }:
    {
      nixosConfigurations = {
        recoverykit-amd64 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/recoverykit/configuration.nix
            "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
          ];

          specialArgs = {
            zen-browser = zen-browser;
          };
        };

        portable-amd64-256gb = nixpkgs.lib.nixosSystem {
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

          specialArgs = {
            zen-browser = zen-browser;
          };
        };

        lairland = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
                ./hosts/lairland/configuration.nix
                # load Determinate Nix and the rest
                determinate.nixosModules.default
                home-manager.nixosModules.home-manager
                vscode-server.nixosModules.default
                nix-ld.nixosModules.nix-ld

                # one-liners?
                { programs.nix-ld.dev.enable = true; }
          ];
          specialArgs = {
            zen-browser = zen-browser;
          };
        };

        stellapent-cier = nixpkgs.lib.nixosSystem {
          # for some reason, zen-browser needs to be imported before nixos-hardware
          # otherwise, it fails to build with some missing dependencies
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
          specialArgs = {
            zen-browser = zen-browser;
          };
        };
      };
      homeConfigurations = {
        # Usage
        # - From GitHub:
        #  nix run home-manager/master -- switch --flake github:andreijiroh-dev/nixops-config#stellapent-cier
        # - Locally:
        #  nix run home-manager/master -- switch --flake .#stellapent-cier
        stellapent-cier = home-manager.lib.homeManagerConfiguration {
          inherit lib;
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          modules = [
            ./shared/home-manager/main.nix
            {
              home = {
                username = "gildedguy";
                homeDirectory = "/home/gildedguy";
              };
            }
          ];
          specialArgs = {
            zen-browser = zen-browser;
          };
        };

        # Usage
        # - From GitHub:
        #  nix run home-manager/master -- switch --flake github:andreijiroh-dev/nixops-config#plain
        # - Locally:
        #  nix run home-manager/master -- switch --flake .#plain
        plain = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          modules = [
            ./shared/home-manager/main.nix
            {
              home.username = "ajhalili2006";
              home.homeDirectory = "/home/ajhalili2006";
            }
          ];
          specialArgs = {
            zen-browser = zen-browser;
          };
        };

        # Usage
        # - From GitHub:
        #  nix run home-manager/master -- switch --flake github:andreijiroh-dev/nixops-config#arm64-plain
        # - Locally:
        #  nix run home-manager/master -- switch --flake .#arm64-plain
        arm64-plain = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-linux;
          modules = [
            ./shared/home-manager/nogui.nix
            {
              home.username = "ajhalili2006";
              home.homeDirectory = "/home/ajhalili2006";
            }
          ];
          specialArgs = {
            zen-browser = zen-browser;
          };
        };
      };

      # This is for external users who want to reproduce my configs as needed
      exportedConfigs = {
        meta = ./shared/meta.nix;
        base = {
          sshKeys = ./shared/ssh-keys.nix;
          hostsFile = ./shared/hosts-file.nix;
          systemd = ./shared/systemd.nix;
          networking = ./shared/networking.nix;
          locale = ./shared/locale.nix;
          gnupg = ./shared/gnupg.nix;
          metaConfigs = ./shared/meta-configs.nix;
          shells = {
            bash = ./shared/shells/bash.nix;
            customPrompts = ./shared/shells/custom-prompts.nix;
          };
        };
        desktop = {
          kdePlasma = ./shared/desktop/kde-plasma.nix;
          base = ./shared/desktop/base.nix;
          flatpak = ./shared/desktop/flatpak.nix;
          _1password = ./shared/desktop/1password.nix;
        };
        server = {
          devenv = ./shared/server/devenv.nix;
          ssh = ./shared/server/ssh.nix;
          firewall = ./shared/server/firewall.nix;
          tailscale = ./shared/server/tailscale.nix;
          cockpit = ./shared/server/cockpit.nix;
        };
      };
    };
}
