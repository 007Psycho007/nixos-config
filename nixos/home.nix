{ inputs, pkgs, ... }:
{
    home.username = "psycho";
    home.homeDirectory = "/home/psycho";

    xdg.configFile.qtile.source = ./home-manager/qtile;
    xdg.configFile.waybar.source = ./home-manager/waybar;
    xdg.configFile.files.source = ./home-manager/files;
    xdg.configFile.nvim.source = ./home-manager/nvim;
    xdg.configFile.scripts.source = ./home-manager/scripts;
    
    home.file."emacsinit" = {
      source = ./home-manager/emacs/init.el;
      target = ".emacs.d/init.el";
    };

    home.packages = with pkgs; [
      (writeShellScriptBin "vim" ''
        kitty --app-id "nvim" -e nvim "$@" > /dev/null 2>&1 &
      '')
    ];
    programs.ssh = {
        enable = true;
        matchBlocks = {
          "vm.linklair.local" = {
            hostname = "192.168.0.2";
            user = "root";
          };
          "github.com" = {
            hostname = "github.com";
            user = "git";
            identitiesOnly = true;
          };
        };
      };

    programs.git = {
      enable = true;
      userName  = "Jan";
      userEmail = "jan.peterhaensel@adconova.com";
    };

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
                      modify_font underline_position 9
                      modify_font underline_thickness 150%
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

    programs.fish = {
        enable = true;
        interactiveShellInit = "function starship_transient_prompt_func
                                starship module time
                              end
                              export TERM='xterm-kitty'
                              alias ssh='kitty +kitten ssh'
                              starship init fish | source
                              enable_transience
                              fish_vi_key_bindings
                              any-nix-shell fish | source
                              set fish_greeting";
      plugins = [
        {
          name = "sudope";
          src = pkgs.fetchFromGitHub {
            owner = "oh-my-fish";
            repo = "plugin-sudope";
            rev = "83919a6";
	          sha256 = "pD4rNuqg6TG22L9m8425CO2iqcYm8JaAEXIVa0H/v/U=";
          };
        }
      ];
      shellAliases = {
        ns = "nix-shell --extra-experimental-features flakes";
      };
    };
    
    programs.qutebrowser = {
      enable = true;
      extraConfig = (builtins.readFile ./home-manager/qutebrowser/config.py);
    };

    programs.lazygit.enable = true;

    programs.lsd = {
        enable = true;
      };

    programs.neovim = {
      enable = true;
      # package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
      extraLuaPackages = ps: [ ps.magick];
      extraPackages = [ pkgs.imagemagick ];
      vimdiffAlias = true;
      withPython3 = true;
      withNodeJs = true;
      extraConfig = "";
    };

  # ...other config, other config...

    services.emacs = {
      enable = true;
      package = pkgs.emacs;
      client = {
        enable = true;
        arguments = [ "--no-wait" "-c" ];
      };
    };


  home.stateVersion = "23.11";
} 
