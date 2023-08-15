```sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz home-manager
sudo nix-channel --update
sudo cp ./* /etc/nixos/
nixos-rebuild-switch```
