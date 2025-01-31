{ config, pkgs, lib, inputs, ... }:

{

  # hardware things  
  services.pulseaudio.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

  };
  

  hardware.bluetooth.enable = true;



}
