{
  config,
  osConfig,
  options,
  lib,
  pkgs,
  ...
}: 


{
    programs.mako.enable;
    services.kanshi = {
        enable = true;
        profiles = {
              undocked = {
                outputs = [
                  {
                    criteria = "eDP-1";
                  }
                ];
              };
              docked = {
                outputs = [
                  {
                    criteria = "eDP-1";
                    scale = 1.25;
                  }
                  {
                    criteria = "Samsung Electric Company LS27C33xG H9TX704640";
                    postition = "1920,1920";
                    scale = 1;

                  }
                ];
              };
            };
    };


    
    programs.sway = {
        enable = true;
        checkConfig = true;
    
        
        config = {
            modifier = "Mod4";
            terminal = "alacritty";


            startup = [
                {command = "exec systemctl --user import-environment DISPLAY WAYLAND_DISPLAY SWAYSOCK"}

                {command = "exec mako"}
                {command = "exec hash dbus-update-activation-environment 2>/dev/null && \
                dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK"}
                
                {command = "exec swayidle -w \
          timeout 300 'swaylock -f -ue -c 000000 -i ${osConfig.dotfiles.imageDir}/space.jpg' \
          timeout 600 'swaymsg \"output * power off\"' resume 'swaymsg \"output * power on\"' \
          before-sleep 'swaylock -f -ue -c 000000 -i ${osConfig.dotfilesimageDir}/space.jpg'"}];


            };
                
            # catpuccin-mocha.
            # yes theres a nix object for this, no i didn't know that when I wrote this
            let 
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

               in  {

                    colors = { 
                        focused           = {
                            title = ${lavender};
                            background = ${base};
                            text = ${text};  
                            indicator = ${rosewater};
                            border = ${lavender};
                        };
                        focused_inactive = {
                            title = ${overlay0};
                            background = ${base};
                            text = ${text};
                           indicator = ${rosewater};
                            border ${overlay0};
                        };
                        unfocused       = {
                            title = ${overlay0};
                            background = ${base};
                            text = ${text};
                            indicator = ${rosewater};
                            border ${overlay0};
                        };
                        urgent      = {
                            title = ${peach};
                            background = ${base};
                            text = ${peach};
                            indicator = ${overlay0};
                            border ${peach};
                        };
                        placeholder    = {
                            title = ${overlay0};
                            background = ${base};
                            text = ${text};
                            indicator = ${overlay0};
                            border ${overlay0};
                        };
                        background = ${base};
        
            
            };

            bars = [
                        {
                            colors = {
                                background         = ${base};
                                statusline         = ${text};
                                focusedStatusline = ${text};
                                focusedSeparator  = ${base};
                            
                                focusedWorkspace  = {
                                    border = ${base};
                                    bg = ${mauve};
                                    text = ${crust};
                                };
                                activeWorkspace   = {
                                    border = ${base};
                                    bg = ${surface2};
                                    text = ${text};
                                };
                                inactiveWorkspace = {
                                    border = ${base};
                                    bg = ${base};
                                    text = ${text};
                                };
                                urgentWorkspace   = {
                                    border = ${base};
                                    bg = ${red};
                                    text = ${crust};
                                };
                            
   r                        };
                                
                            hiddenState = true;
                            mode = "dock";
                            position = "bottom";


                            command = "\${pkgs.swaybar}/bin/swaybar";
                            statusCommand = "while ${osConfig.dotfiles.scriptDir}/bar.sh; do sleep 7; done";
                            trayOutput = "*";

                            workspaceButtons = true;
                            workspaceNumber = true;
                            
                            }
                        ];
                        };

            keybindings = {
            let
                modifier = config.wayland.windowManager.sway.config.modifier;
            in lib.mkOptionDefault {

              "Ctrl+Alt+t" =  "exec ${config.wayland.windowManager.sway.config.terminal}";

              "${modifier}+Shift+q" = "kill";

              "${modifier}+l" = "exec swaylock -ue -i ${imageDir}/space.jpg";

              "${modifier}+m" = "${config.wayland.windowManager.sway.config.menu}";

              "${modifier}+Shift+c" = "reload";

              "Print" = "exec flameshot launcher";

              "XF86MonBrightnessDown" =  "exec light -U 10";
              "XF86MonBrightnessUp" =  "exec light -A 10";

              "${modifier}+Shift+e" "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -B 'Yes, exit sway' 'swaymsg exit'";
                
              
              "${modifier}+Ctrl+D" = "workspace next";
              "${modifier}+Ctrl+A" = "workspace prev";

              "${modifier}+Shift+A" =  "move left";
              "${modifier}+Shift+S" =  "move down";
              "${modifier}+Shift+W" =  "move up";
              "${modifier}+Shift+D" =  "move right";
            
              

        `    };
        };


    };
        


}
