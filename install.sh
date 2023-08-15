#!/bin/sh
sudo cp -r ./nixos/* /etc/nixos/
sudo nixos-rebuild switch
