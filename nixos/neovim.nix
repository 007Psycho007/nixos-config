{ config, pkgs, ... }:

{
  imports =
    [
      <home-manager/nixos>
    ];
  
  home-manager.users.psycho = {
  
    programs.neovim = {
      enable = true;
      vimAlias = true;
      vimdiffAlias = true;
      withPython3 = true;
      withNodeJs = true;
      extraConfig = "";
    };
  };

}
