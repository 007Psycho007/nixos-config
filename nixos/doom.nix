{ pkgs, ... }:

let
  doom-emacs = pkgs.callPackage (builtins.fetchTarball {
    url = https://github.com/nix-community/nix-doom-emacs/archive/master.tar.gz;
  }) {
    doomPrivateDir = ./home-manager/doom;  # Directory containing your config.el, init.el
                                # and packages.el files
  };
in {
  home-manager.users.psycho.home.packages = [ doom-emacs ];
}
