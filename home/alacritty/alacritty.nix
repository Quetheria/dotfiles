{
  config,
  options,
  lib,
  pkgs,
  ...
}: {
  programs.alacritty = {
    enable = true;

    settings = {
      window = {
        padding = {
          x = 2;
          y = 2;
        };
        dynamic_padding = true;
      };

      scrolling.history = 10000;

      mouse.bindings = [
        {
          mouse = "Middle";
          action = "PasteSelection";
        }
      ];

      keyboard.bindings = [
        {
          key = "N";
          mods = "Control|Shift";
          action = "CreateNewWindow";
        }
        {
          key = "Escape";
          mods = "Control";
          action = "ToggleViMode";
        }
      ];

      font = {
        normal = {
          family = "Martian Mono";
          style = "Regular";
        };
        bold = {
          family = "Martian Mono";
          style = "Bold";
        };

        italic = {
          family = "Martian Mono";
          style = "Italic";
        };
        size = 10;
      };

      # just all of cattpuccin-mocha
      colors.vi_mode_cursor = {
        text = "#1e1e2e";
        cursor = "#b4befe";
      };

      colors.search.matches = {
        foreground = "#1e1e2e";
        background = "#a6adc8";
      };

      colors.search.focused_match = {
        foreground = "#1e1e2e";
        background = "#a6e3a1";
      };

      colors.footer_bar = {
        foreground = "#1e1e2e";
        background = "#a6adc8";
      };

      colors.hints.start = {
        foreground = "#1e1e2e";
        background = "#f9e2af";
      };

      colors.hints.end = {
        foreground = "#1e1e2e";
        background = "#a6adc8";
      };

      colors.selection = {
        text = "#1e1e2e";
        background = "#f5e0dc";
      };

      colors.normal = {
        black = "#45475a";
        red = "#f38ba8";
        green = "#a6e3a1";
        yellow = "#f9e2af";
        blue = "#89b4fa";
        magenta = "#f5c2e7";
        cyan = "#94e2d5";
        white = "#bac2de";
      };

      colors.bright = {
        black = "#585b70";
        red = "#f38ba8";
        green = "#a6e3a1";
        yellow = "#f9e2af";
        blue = "#89b4fa";
        magenta = "#f5c2e7";
        cyan = "#94e2d5";
        white = "#a6adc8";
      };

      colors.indexed_colors = {
        index = 16;
        color = "#fab387";
      };

      colors.indexed_colors = {
        index = 17;
        color = "#f5e0dc";
      };
    };
  };
}
