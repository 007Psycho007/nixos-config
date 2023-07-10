{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  home.username = "psycho";
  home.homeDirectory = "/home/psycho";
  
  home.file.".config/qtile".source = ./home-manager/qtile;


  programs.zsh = {
    enable = true;
  };
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.11";
}
