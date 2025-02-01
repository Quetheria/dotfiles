# Global font configuration
{
  config,
  options,
  lib,
  pkgs,
  ...
}: {
  config.home.packages = with pkgs; [
    martian-mono
    nerd-fonts.symbols-only
    ubuntu-sans
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    fira-code
    fira-code-symbols
  ];
  config.fonts = {
    fontconfig = {
      enable = true;
      defaultFonts = {
        emoji = ["Noto Color Emoji"];
        monospace = ["Martian Mono"];
        sansSerif = ["Ubuntu Nerd Font"];
        serif = ["Liberation Serif"];
      };
    };
  };
}
