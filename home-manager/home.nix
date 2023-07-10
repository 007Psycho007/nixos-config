{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.home-manager.path = https://github.com/rycee/home-manager/archive/release-18.03.tar.gz;
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "psycho";
  home.homeDirectory = "/home/psycho";
  
  home.file.".config/qtile".source = ~/home-manager/configs/qtile;

  programs.zsh = {
    enable = true;
  }
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";
}
