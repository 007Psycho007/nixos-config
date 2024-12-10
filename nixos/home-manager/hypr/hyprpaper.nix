{ inputs, pkgs, ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;

      preload =
        [ "~/.config/files/wallpaper.png" ];

      wallpaper = [
        ", ~/.config/files/wallpaper.png"
      ];
    };
  };
}
