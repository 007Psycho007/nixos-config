{ config, pkgs, ... }:


{
  imports =
    [
      <home-manager/nixos>
    ];
  
  home-manager.users.psycho = {
    home.homeDirectory = "/home/psycho";

    home.file.".config/qtile".source = ./home-manager/qtile;
    home.file."/.config/starship/transient.toml".source = ./home-manager/starship/transient.toml;

    programs.kitty = {
        enable = true;
        font.name = "Source Code Pro";
        shellIntegration.enableZshIntegration = true;
        extraConfig = ''
                      cursor_shape beam
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
                      '';
    };

    programs.rofi = {
      enable = true;
      font = "Source Code Pro Bold 12";
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

    programs.starship = {
      
      enable = true;
      enableFishIntegration = true;
      settings = {
        add_newline = false;
        format = "[ $os ](bg:8 fg:blue)[](fg:8 bg:white)[ $username ](fg:black bg:white)[](fg:white bg:8)[ $directory ](fg:white bg:8)[$git_branch$git_status](fg:white bg:8)[$golang](fg:white bg:8)[$python](fg:white bg:8)[$lua](fg:white bg:8)[$terraform](fg:white bg:8)[$kubernetes](fg:white bg:8)[](fg:8)[$fill](fg:white)[](fg:8)[$status](fg:white bg:8)[$conda](fg:white bg:8)[$nix_shell](fg:white bg:8)
 [ $character](fg:green) ";
        
        continuation_prompt = "      [│](fg:blue)  ";
        os = {
          format = "$symbol";
          style = "bold blue";
          disabled = false;
          symbols = {
            Arch = "";
            NixOS = ""
          };
        };

        username = {
          style_user = "black bold";
          style_root = "red bold";
          format = "$user";
          disabled = false;
          show_always = true;
        };

        directory = {
          truncation_length = 3;
          truncation_symbol = "…/";
          truncate_to_repo = true;
          format = "$path $read_only";
          home_symbol = " ~";
          read_only = "";
          read_only_style = "red";
        };
        
        git_status = {
          conflicted = " =$count";
          ahead = " ⇡$count";
          behind = " ⇣$count";
          diverged = " ⇕$count";
          up_to_date = "✓";
          untracked = " ?$count";
          stashed = " $$count";
          renamed = " »$count";
          deleted = " $count";
          staged = " +$count";
          modified = " !$count";
          format = " [$all_status](fg:red bg:8) ";
        };

        conda = {
          symbol = "";
          style = "yellow";
          format = " [$symbol $environment](fg:yellow bg:8) ";
          ignore_base = false;
        };

        aws = {
          symbol = "";
          format = " [$symbol $profile](fg:yellow bg:8) ";
        };

        kubernetes = {
          symbol = "";
          format = " [$symbol $context](fg:blue bg:8) ";
        };

        lua = {
          symbol = "";
          format = " [$symbol $version](fg:blue bg:8) ";
        };
        
        golang = {
          symbol = "";
          format = " [$symbol $version](fg:blue bg:8) ";
        };

        python = {
          symbol = "";
          format = " [$symbol $version](fg:yellow bg:8) ";
        };

        terraform = {
          symbol = "";
          format = " [$symbol $version](fg:blue bg:8) ";
        };

        fill = {
          symbol = "─";
          style = "bold white";
        };

        time = {
          disabled = false;
          style = "bold bright-black";
          format = "[$time]($style)";
        };

        status = {
          symbol = "[](fg:red bg:8) ";
          success_symbol = "[](fg:green bg:8) ";
          format = " $symbol$status ";
          disabled = false;
        };

        nix_shell = {
          symbol = "";
          format = " [$symbol $name](fg:blue bg:8) ";
        };

        character = {
          format = "$symbol";
          vicmd_symbol = "";
        };
      };
    };

    programs.fish = {
        enable = true;
        interactiveShellInit = "function starship_transient_prompt_func
  starship module character
end
starship init fish | source
enable_transience";
    };

    home.stateVersion = "21.11";
  };
} 
