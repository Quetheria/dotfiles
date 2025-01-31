# Global font configuration
{
  config,
  options,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "MartainMono"
        "NerdFontsSymbolsOnly"
        "Ubuntu"
      ];
    })
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation-serif
    fira-code
    fira-code-symbols
  ];

  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = ["Ubuntu Nerd Font"];
        serif = ["Liberation Serif"];
        monospace = ["Martian Mono"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };
}
