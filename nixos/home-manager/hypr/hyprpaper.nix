{ inputs, pkgs, ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;

      preload =
        [ "~/.config/files/wall.jpg" ];

      wallpaper = [
        ", ~/.config/files/wall.jpg"
      ];
    };
  };
}
