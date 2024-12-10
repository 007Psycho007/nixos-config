{ inputs, pkgs, ... }:
{
  
    wayland.windowManager.hyprland = {
      settings = {
        monitor = [
          "eDP-1, 1920x1080,0x0,1"  
          "DP-1, 1920x1080, 1920x0, 1"
        ];
      };
    };
}
