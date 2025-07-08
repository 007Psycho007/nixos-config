# /etc/nixos/flake.nix
{
  description = "flake for main";

  inputs = {

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    home-manager = {
          url = "github:nix-community/home-manager/release-25.05";
          inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.5.2";

  };

  outputs = inputs@{ self, nix-flatpak, nixpkgs, home-manager,... }: {
    nixosConfigurations = {
      main = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          nix-flatpak.nixosModules.nix-flatpak
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {inherit inputs;};
            home-manager.users.psycho.imports =  [
              ./home.nix
              ./home-manager/hypr/hypr.nix
              ./home-manager/hypr/hypr-local.nix
              ./home-manager/hypr/hyprlock.nix
              ./home-manager/hypr/hyprpaper.nix
              ./home-manager/tmux/tmux.nix
              ./home-manager/starship/starship.nix
              ./home-manager/swaync/swaync.nix
            ];
          }
        ];
      };
    };
  };
}
