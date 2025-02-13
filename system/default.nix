{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  programs.fish.enable = true;
  users.users.cessna = {
    isNormalUser = true;
    description = "Cessna";
    extraGroups = ["video" "networkmanager" "wheel" "docker"];
    shell = pkgs.fish;

    packages = with pkgs; [
      ripgrep
      git
      grim
      fish
      firefox
      neovim
      steam-run
      htop
      file
      bat
      light
      eza
      vesktop
      powerline
      prismlauncher
      libnotify
    ];
  };

  imports = [
    ./options.nix
    ./hardware-configuration.nix
    # tailscale, ssh some nm config switches
    ./networking.nix
    # bluetooth + alsa
    ./sound.nix
    # docker virtualbox, etc
    ./virtualization.nix
    ./games.nix
    # lower level things grub etc + random config suff
    ./boot-etc.nix
  ];
}
