# /etc/nixos/flake.nix
{
  description = "flake for main";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager = {
          url = "github:nix-community/home-manager/release-24.11";
          inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = inputs@{ self, nixpkgs, home-manager,... }: {
    nixosConfigurations = {
      main = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {inherit inputs;};
            home-manager.users.psycho.imports =  [
              ./home.nix
              ./home-manager/hypr/hypr.nix
              ./home-manager/hypr/hyprlock.nix
              ./home-manager/hypr/hyprpaper.nix
              ./home-manager/tmux/tmux.nix
              ./home-manager/starship/starship.nix
            ];
          }
        ];
      };
    };
  };
}
