{ config, pkgs, inputs, ... }:
{ 
  home.username = "cessna";
  home.homeDirectory = "/home/cessna";


    


    # 
  programs.home-manager.enable = true;
   /* The home.stateVersion option does not have a default and must be set */
  home.stateVersion = "18.09";
   /* Here goes the rest of your home-manager config, e.g. home.packages = [ pkgs.foo ]; */
  
  import = [
    ./sway/sway.nix
    ./games.nix
    ./alacritty/alacritty.nix
    ./fish/fish.nix
    ./neovim/neovim.nix
    ./firefox/firefox.nix
    ./flameshot/flameshot.nix
    ./fonts.nix
    ./vesktop/vesktop.nix
  ];
    


  
}

