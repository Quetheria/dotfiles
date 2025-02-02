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

  home.file = {
    background = {
      enable = true;
      executable = false;
      source = /home/cessna/dotfiles/home/assets/images/space.jpg;
      target = ".config/sway/space.jpg";
    };

    bar = {
      enable = true;
      executable = true;
      source = /home/cessna/dotfiles/home/assets/scripts/bar.sh;
      target = ".config/sway/bar.sh";
    };

    greet = {
      enable = true;
      executable = true;
      source = /home/cessna/dotfiles/home/assets/scripts/bar.sh;
      target = ".config/sway/greet.sh";
    };
  };

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
