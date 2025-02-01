{
  config,
  pkgs,
  inputs,
  home-manager,
  ...
}: {


  home.homeDirectory = "/home/cessna";

  #
  programs.home-manager.enable = true;
  /*
  The home.stateVersion option does not have a default and must be set
  */
  home.stateVersion = "24.11";
  /*
  Here goes the rest of your home-manager config, e.g. home.packages = [ pkgs.foo ];
  */

  imports = [
    ./sway/sway.nix
    ./alacritty/alacritty.nix
    ./fish/fish.nix
    ./neovim/neovim.nix
    ./firefox/firefox.nix
    ./flameshot/flameshot.nix
    ./fonts.nix
    ./powerline/powerline.nix 
  ];
}
