#!/bin/sh
sudo cp -r ./nixos/configuration.nix /etc/nixos/
sudo cp -r ./nixos/doom.nix /etc/nixos/
sudo cp -r ./nixos/home.nix /etc/nixos/
sudo cp -r ./nixos/locals/$(hostname).nix /etc/nixos/local.nix

sudo rm -rf /etc/nixos/home-manager/
sudo cp -r ./nixos/home-manager/ /etc/nixos/home-manager/
sudo nixos-rebuild switch


