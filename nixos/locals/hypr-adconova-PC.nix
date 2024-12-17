{ inputs, pkgs, ... }:
{
  
    wayland.windowManager.hyprland = {
      settings = {
        monitor = [
          "DP-10, 1920x1080, 0x0, 1"
          "DP-4, 1920x1080, 1920x0, 1"
          "eDP-1, 1920x1080,3840x0,1"  
        ];
      };
    };
}
