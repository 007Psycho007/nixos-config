{ config, pkgs, ... }:


{
  imports =
    [ # Include the results of the hardware scan.
      <home-manager/nixos>
    ];
  
  home-manager.users.psycho = {
    home.homeDirectory = "/home/psycho";
    home.file.".config/qtile".source = ./home-manager/qtile;
      
    programs.kitty = {
        enable = true;
        font.name = "Source Code Pro";
        shellIntegration.enableZshIntegration = true;
        extraConfig = ''
                      foreground #979eab
                      background #282c34
                      cursor #cccccc
                      color0 #282c34
                      color1 #e06c75
                      color2 #98c379
                      color3 #e5c07b
                      color4 #61afef
                      color5 #be5046
                      color6 #56b6c2
                      color7 #979eab
                      color8 #393e48
                      color9 #d19a66
                      color10 #56b6c2
                      color11 #e5c07b
                      color12 #61afef
                      color13 #be5046
                      color14 #56b6c2
                      color15 #abb2bf
                      selection_foreground #282c34
                      selection_background #979eab
                      background_opacity 0.95
                      ;
    };

    programs.rofi = {
      enable = true;
      font = "Source Code Pro";
      theme = ./home-manager/rofi/onedark.rasi;
      terminal = "kitty";
      extraConfig = {
        display-drun = "Applications:";
        display-run = "Command:";
        display-window = "Windows:";
        drun-display-format = "{icon} {name}";
        modi = "window,run,drun";
        show-icons = false;
        kb-row-up = "Up,Control+k,Shift+Tab,Shift+ISO_Left_Tab";
        kb-row-down = "Down,Control+j";
        kb-accept-entry = "Control+m,Return,KP_Enter";
        kb-remove-to-eol = "Control+Shift+e";
        kb-mode-next = "Shift+Right,Control+Tab";
        kb-mode-previous = "Shift+Left,Control+Shift+Tab";
        kb-remove-char-back = "BackSpace";
      };
    };


    home.stateVersion = "21.11";
  };

}
