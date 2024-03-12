{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./crypt.nix
    ];

  environment.systemPackages = with pkgs; [
    chromium
    citrix_workspace
    rocketchat-desktop
  ];
}
