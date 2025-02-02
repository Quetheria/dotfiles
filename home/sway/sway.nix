{
  config,
  options,
  lib,
  inputs,
  pkgs,
  ...
}: let
  rosewater = "#f5e0dc";
  flamingo = "#f2cdcd";
  pink = "#f5c2e7";
  mauve = "#cba6f7";
  red = "#f38ba8";
  maroon = "#eba0ac";
  peach = "#fab387";
  yellow = "#f9e2af";
  green = "#a6e3a1";
  teal = "#94e2d5";
  sky = "#89dceb";
  sapphire = "#74c7ec";
  blue = "#89b4fa";
  lavender = "#b4befe";
  text = "#cdd6f4";
  subtext1 = "#bac2de";
  subtext0 = "#a6adc8";
  overlay2 = "#9399b2";
  overlay1 = "#7f849c";
  overlay0 = "#6c7086";
  surface2 = "#585b70";
  surface1 = "#45475a";
  surface0 = "#313244";
  base = "#1e1e2e";
  mantle = "#181825";
  crust = "#11111b";
in {
  services.mako.enable = true;
  services.kanshi = {
    enable = true;
    settings = [
      {
        profile.name = "undocked";
        profile.outputs = [
          {
            criteria = "eDP-1";
          }
        ];
      }
      {
        profile.name = "docked";
        profile.outputs = [
          {
            criteria = "eDP-1";
            scale = 1.25;
          }
          {
            criteria = "Samsung Electric Company LS27C33xG H9TX704640";
            position = "1920,1920";
            scale = 1.0;
          }
        ];
      }
    ];
  };

  programs.rofi.enable = true;
  programs.swaylock.enable = true;

  wayland.windowManager.sway = {
    enable = true;
    checkConfig = true;

    config = {
      modifier = "Mod4";
      terminal = "alacritty";
      menu = "${pkgs.rofi}/bin/rofi -show drun";
      startup = [
        {command = "exec systemctl --user import-environment DISPLAY WAYLAND_DISPLAY SWAYSOCK";}

        {command = "exec mako";}

        # this was for something in my original config, but it fails the build now
        #      {command = "exec hash dbus-update-activation-environment 2>/dev/null && \
        #              dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK";}
      ];

      # catpuccin-mocha.
      # yes theres a nix object for this, no i didn't know that when I wrote this

      colors = {
        focused = {
          childBorder = "${lavender}";
          background = "${base}";
          text = "${text}";
          indicator = "${rosewater}";
          border = "${lavender}";
        };
        focusedInactive = {
          childBorder = "${overlay0}";
          background = "${base}";
          text = "${text}";
          indicator = "${rosewater}";
          border = "${overlay0}";
        };
        unfocused = {
          childBorder = "${overlay0}";
          background = "${base}";
          text = "${text}";
          indicator = "${rosewater}";
          border = "${overlay0}";
        };
        urgent = {
          childBorder = "${peach}";
          background = "${base}";
          text = "${peach}";
          indicator = "${overlay0}";
          border = "${peach}";
        };
        placeholder = {
          childBorder = "${overlay0}";
          background = "${base}";
          text = "${text}";
          indicator = "${overlay0}";
          border = "${overlay0}";
        };
        background = "${base}";
      };

      bars = [
        {
          colors = {
            background = "${base}";
            statusline = "${text}";
            focusedStatusline = "${text}";
            focusedSeparator = "${base}";

            focusedWorkspace = {
              border = "${base}";
              background = "${mauve}";
              text = "${crust}";
            };
            activeWorkspace = {
              border = "${base}";
              background = "${surface2}";
              text = "${text}";
            };
            inactiveWorkspace = {
              border = "${base}";
              background = "${base}";
              text = "${text}";
            };
            urgentWorkspace = {
              border = "${base}";
              background = "${red}";
              text = "${crust}";
            };
          };

          hiddenState = "hide";
          mode = "dock";
          position = "bottom";

          command = "\${pkgs.swaybar}/bin/swaybar";
          statusCommand = "while /home/cessna/.config/sway/bar.sh; do sleep 7; done";
          trayOutput = "*";

          workspaceButtons = true;
          workspaceNumbers = true;
        }
      ];

      keybindings = let
        modifier = config.wayland.windowManager.sway.config.modifier;
      in
        lib.mkOptionDefault {
          "Ctrl+Alt+t" = "exec ${config.wayland.windowManager.sway.config.terminal}";

          "${modifier}+D" = "focus right";
          "${modifier}+W" = "focus up";

          "${modifier}+Shift+q" = "kill";

          "${modifier}+L" = "exec swaylock -ue -i /home/cessna/.config/sway/space.jpg";

          "${modifier}+M" = "${config.wayland.windowManager.sway.config.menu}";

          "${modifier}+Shift+C" = "reload";

          "Print" = "exec flameshot launcher";

          "XF86MonBrightnessDown" = "exec light -U 10";
          "XF86MonBrightnessUp" = "exec light -A 10";

          "${modifier}+Shift+e" = "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -B 'Yes, exit sway' 'swaymsg exit'";

          "${modifier}+Ctrl+D" = "workspace next";
          "${modifier}+Ctrl+A" = "workspace prev";

          "${modifier}+Shift+A" = "move left";
          "${modifier}+Shift+S" = "move down";
          "${modifier}+Shift+W" = "move up";
          "${modifier}+Shift+D" = "move right";
        };
    };
  };

  services.swayidle = {
    enable = true;
    events = [
      {
        event = "before-sleep";
        command = "swaylock -f -ue -c 000000 -i /home/cessna/.config/sway/space.jpg'";
      }
    ];

    timeouts = [
      {
        timeout = 300;
        command = "'swaylock -f -ue -c 000000 -i /home/cessna/.config/sway/space.jpg'";
      }
      {
        timeout = 600;
        command = "swaymsg 'output * power off'";
        resumeCommand = "swaymsg 'output * power on'";
      }
    ];
  };
}
