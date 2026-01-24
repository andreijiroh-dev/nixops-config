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

    # NixOS hardware stuff
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # vscode-server setup
    vscode-server = {
      url = "github:nix-community/nixos-vscode-server";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };
    nix4vscode = {
      url = "github:nix-community/nix4vscode";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.systems.follows = "systems";
    };

    # Firefox and friends
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nix-ld
    nix-ld = {
      url = "github:Mic92/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # agenix and friends for SecretOps
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.systems.follows = "systems";
    };
    agenix-rekey = {
      url = "github:oddlama/agenix-rekey";
      # Make sure to override the nixpkgs version to follow your flake,
      # otherwise derivation paths can mismatch (when using storageMode = "derivation"),
      # resulting in the rekeyed secrets not being found!
      inputs.nixpkgs.follows = "nixpkgs";
    };

    chaotic = {
      url = "https://flakehub.com/f/chaotic-cx/nyx/*.tar.gz";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
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
      nix4vscode,
      firefox-addons,
      agenix,
      agenix-rekey,
      chaotic,
    }:
    let
      dev-pkgs = import ./pkgs;

      # Reusable overlay function for any system
      overlayFor = system: final: prev: {
        coolify-compose = prev.callPackage ./pkgs/coolify-compose.nix { };
        detect-vscode-for-git = prev.callPackage ./pkgs/detect-vscode-for-git.nix { };
        ssh-agent-loader = prev.callPackage ./pkgs/ssh-agent-loader.nix { };
      };
    in
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        # Packages for this system
        packages = {
          coolify-compose = pkgs.callPackage ./pkgs/coolify-compose.nix { };
          detect-vscode-for-git = pkgs.callPackage ./pkgs/detect-vscode-for-git.nix { };
          ssh-agent-loader = pkgs.callPackage ./pkgs/ssh-agent-loader.nix { };

          # Optionally make one the default to support `nix profile add .#`
          default = pkgs.callPackage ./pkgs/coolify-compose.nix { };
        };

        # If you want app-style outputs, you can also define apps here:
        # apps.default = {
        #   type = "app";
        #   program = "${self.packages.${system}.coolify-compose}/bin/coolify-compose";
        # };

        # Keep nixosConfigurations and homeConfigurations outside of eachDefaultSystem
        # or gate them by `system` if needed; shown below outside the lambda.
      }
    )
    // {
      # Top-level overlays for downstream consumers
      overlays = {
        # System-aware default overlay that works regardless of the system
        default =
          final: prev:
          let
            sys = final.system or prev.stdenv.system or "x86_64-linux";
          in
          (overlayFor sys) final prev;

        # Per-system overlays for compatibility
        x86_64-linux = overlayFor "x86_64-linux";
        aarch64-linux = overlayFor "aarch64-linux";
        x86_64-darwin = overlayFor "x86_64-darwin";
        aarch64-darwin = overlayFor "aarch64-darwin";
      };

      nixosConfigurations = {
        recoverykit-amd64 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            (
              { ... }:
              {
                _module.args = { inherit self nix4vscode; };
              }
            )
            # nix flake modules first
            nix-ld.nixosModules.nix-ld
            determinate.nixosModules.default
            home-manager.nixosModules.home-manager
            vscode-server.nixosModules.default

            # and then the configs
            ./shared/meta.nix
            ./hosts/recoverykit/configuration.nix
            "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
          ];

          specialArgs = {
            inherit zen-browser nix4vscode self;
          };
        };

        portable-amd64-256gb = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            (
              { ... }:
              {
                _module.args = { inherit self nix4vscode; };
              }
            )
            # nix flake modules first
            nix-ld.nixosModules.nix-ld
            determinate.nixosModules.default
            home-manager.nixosModules.home-manager
            vscode-server.nixosModules.default

            # and then the configs
            ./shared/meta.nix
            ./hosts/portable/amd64/configuration.nix
          ];

          specialArgs = {
            inherit zen-browser self;
          };
        };

        lairland = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            (
              { ... }:
              {
                _module.args = { inherit self nix4vscode; };
              }
            )
            # nix flake modules first
            nix-ld.nixosModules.nix-ld
            determinate.nixosModules.default
            home-manager.nixosModules.home-manager
            vscode-server.nixosModules.default
            chaotic.nixosModules.default

            # and then the configs
            ./shared/meta.nix
            ./hosts/lairland/configuration.nix
          ];

          specialArgs = {
            inherit zen-browser self chaotic;
          };
        };

        stellapent-cier = nixpkgs.lib.nixosSystem {
          # for some reason, zen-browser needs to be imported before nixos-hardware
          # otherwise, it fails to build with some missing dependencies
          system = "x86_64-linux";
          modules = [
            (
              { ... }:
              {
                _module.args = { inherit self nix4vscode; };
              }
            )
            nix-ld.nixosModules.nix-ld
            determinate.nixosModules.default
            home-manager.nixosModules.home-manager
            vscode-server.nixosModules.default
            chaotic.nixosModules.default
            ./shared/meta.nix
            ./hosts/stellapent-cier/configuration.nix
          ];
          specialArgs = {
            inherit
              zen-browser
              nix4vscode
              self
              chaotic
              ;
          };
        };

        live-cd = nixpkgs.lib.nixosSystem {
          system = builtins.currentSystem;
          modules = [
            (
              { ... }:
              {
                _module.args = { inherit self nix4vscode; };
              }
            )
            nix-ld.nixosModules.nix-ld
            determinate.nixosModules.default
            home-manager.nixosModules.home-manager
            vscode-server.nixosModules.default
            chaotic.nixosModules.default
            ./hosts/live-cd/kde-plasma.nix
          ];
          specialArgs = {
            inherit
              zen-browser
              nix4vscode
              self
              chaotic
              nixpkgs
              ;
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
          extraSpecialArgs = {
            inherit
              self
              dev-pkgs
              zen-browser
              nix4vscode
              chaotic
              ;
          };
          modules = [
            {
              nixpkgs = {
                overlays = [
                  self.overlays.default
                  nix4vscode.overlays.default
                ];
                config = {
                  allowUnfree = true;
                  # https://github.com/nix-community/home-manager/issues/2942
                  allowUnfreePredicate = (_: true);
                };
              };
            }
            zen-browser.homeModules.beta
            chaotic.homeManagerModules.default
            ./shared/home-manager/main.nix
            {
              home = {
                username = "gildedguy";
                homeDirectory = "/home/gildedguy";
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
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = {
            inherit
              self
              dev-pkgs
              zen-browser
              nix4vscode
              chaotic
              ;
          };
          modules = [
            {
              nixpkgs = {
                overlays = [
                  self.overlays.default
                  nix4vscode.overlays.default
                ];
                config = {
                  allowUnfree = true;
                  # https://github.com/nix-community/home-manager/issues/2942
                  allowUnfreePredicate = (_: true);
                };
              };
            }
            zen-browser.homeModules.beta
            chaotic.homeManagerModules.default
            ./shared/home-manager/nogui.nix
            {
              home.username = "ajhalili2006";
              home.homeDirectory = "/home/ajhalili2006";
            }
          ];
        };

        # Usage
        # - From GitHub:
        #  nix run home-manager/master -- switch --flake github:andreijiroh-dev/nixops-config#arm64-plain
        # - Locally:
        #  nix run home-manager/master -- switch --flake .#arm64-plain
        arm64-plain = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-linux;
          extraSpecialArgs = {
            inherit
              self
              dev-pkgs
              zen-browser
              nix4vscode
              chaotic
              ;
          };
          modules = [
            {
              nixpkgs = {
                overlays = [
                  self.overlays.default
                  nix4vscode.overlays.default
                ];
                config = {
                  allowUnfree = true;
                  # https://github.com/nix-community/home-manager/issues/2942
                  allowUnfreePredicate = (_: true);
                };
              };
            }
            zen-browser.homeModules.beta
            chaotic.homeManagerModules.default
            ./shared/home-manager/nogui.nix
            {
              home.username = "ajhalili2006";
              home.homeDirectory = "/home/ajhalili2006";
            }
          ];
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
          metaConfigs = ./shared/nix.nix;
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
