{ config, pkgs, ... }:


{
  imports =
    [ # Include the results of the hardware scan.
      <home-manager/nixos>
    ];
  programs.home-manager.enable = true;
  
  home-manager.users."psycho" = {
      home = "/home/psycho"
    }


  home.stateVersion = "21.11";
}
