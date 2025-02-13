{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  # hardware things
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  hardware.bluetooth.enable = true;
}
