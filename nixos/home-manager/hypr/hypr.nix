{ inputs, pkgs, ... }:
{
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = true;
      settings = {

        exec-once= [
          "waybar"
          "kitty"
          "pavucontrol"
        ];

        "$terminal" = "kitty";
        "$menu" = "rofi -show run";


        "$mod" = "SUPER"; # Sets "Windows" key as main modifier

        monitor = [
          "eDP-1, 1920x1080,0x0,1"  
        ];
        general = {
          gaps_in = 4;
          gaps_out = 8;

          border_size = 2;

          # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
          "col.active_border" = "rgb(61AFEF) rgb(98C379) 45deg";
          "col.inactive_border" = "rgb(282C34) rgb(393f4a)";

          # Set to true enable resizing windows by clicking and dragging on borders and gaps
          resize_on_border = false;

          # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
          allow_tearing = false;

          layout = "dwindle";
        };
        dwindle = {
          preserve_split = true;
          force_split = 2;
          default_split_ratio = 1.2;
        };
        decoration = {
          rounding = 8;
        };
        input = {
          follow_mouse = 2;
          kb_options = "caps:escape";
        };
        windowrulev2 = [
          "workspace 4, class:^(discord)$"
          "workspace 2, class:^(firefox)$"
          "workspace 2, class:^(qutebrowser)$"
          "workspace 1, class:^(kitty)$"
          "workspace 6, class:^(org.pulseaudio.pavucontrol)$"
          "workspace 6, class:^(streamcontroller)$"
          "workspace 5, class:^(pavucontrol)$"
          "workspace 10, class:^(Shadow PC)$"
          "workspace 10, class:^(Shadow PC - Display)$"
          "workspace 9, class:^(nvim)$"
          "workspace 7, class:^(steam)$"
          "workspace 4, class:^(chromium)$"
          "workspace 8, class:^(obsidian)$"
        ];

        bindm = [
           "$mod, mouse:272, movewindow"
        ];
        bind = [
            "$mod, mouse:272, movewindow"
            "$mod SHIFT, Q, killactive"
            "$mod , RETURN, exec, $terminal"
            "$mod , D, exec, $menu"
            "$mod , G, exec, ~/.config/scripts/dmenu/menu.sh"
            "$mod , V, togglefloating"
            "$mod , P, pseudo"
            "$mod , X, exec, hyprlock"
            "$mod , S, togglesplit"
            # Movement
            "$mod , H, movefocus, l"
            "$mod , L, movefocus, r"
            "$mod , K, movefocus, u"
            "$mod , J, movefocus, d"
            "$mod SHIFT, H, movecurrentworkspacetomonitor, l"
            "$mod SHIFT, L, movecurrentworkspacetomonitor, r"
            # Media Keys
            ", XF86AudioNext, exec, playerctl next"
            ", XF86AudioPause, exec, playerctl play-pause"
            ", XF86AudioPlay, exec, playerctl play-pause"
            ", XF86AudioPrev, exec, playerctl previous"
            "$mod, 0, workspace, 10"
            "$mod SHIFT, 0, movetoworkspace, 10"

          ]
          ++ (
            # workspaces
            # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
            builtins.concatLists (builtins.genList (i:
                let ws = i + 1;
                in [
                  "$mod, code:1${toString i}, workspace, ${toString ws}"
                  "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
                ]
              )
              9)
          );
      };
    };
}
