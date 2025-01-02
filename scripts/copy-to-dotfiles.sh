#!/usr/bin/env bash
set -xe

# SPDX-License-Identifier: MPL
#
# This script is specific to @ajhalili2006's dotfiles repository, mainly
# to deploy changes of shared/home-manager/main.nix in this repository
# to .config/home-manager/meta.nix in the dotfiles@nixpkgs repo. (For context
# the meta.nix itself is where the bulk of my customizations go by, and the
# hone.nix will be specific to what host am I with help from Git branches.)
NIXOS_CONFIG_DIR=${NIXOS_CONFIG_DIR:-"$HOME/.config/nixos"}

cp -vr flake.* shared hosts "$NIXOS_CONFIG_DIR/"
cp -vr shared/home-manager/main.nix "$HOME/.config/home-manager/meta.nix"