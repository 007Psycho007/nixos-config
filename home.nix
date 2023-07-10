{ config, pkgs, ... }:


{
  imports =
    [ # Include the results of the hardware scan.
      <home-manager/nixos>
    ];
  
  home-manager.users.psycho = {
      home.homeDirectory = "/home/psycho";
      home.stateVersion = "21.11"
    };

}
