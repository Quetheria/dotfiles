{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    # tailscale, ssh some nm config switches
    ./networking.nix
    # bluetooth + alsa
    ./sound.nix
    # docker virtualbox, etc
    ./virtualization.nix

    # lower level things grub etc + random config suff
    ./boot-etc.nix
    ./options.nix
  ];
}
