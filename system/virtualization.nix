{
  config,
  pkgs,
  lib,
  ...
}: {
  # this might not need to be a separate file
  virtualisation.waydroid.enable = true;
  virtualisation.docker.enable = true;

  #TODO 
  # this derivation has kvm kernel units
  #kvm_intel 438272 0 - Live 0x0000000000000000
  #kvm 1380352 1 kvm_intel, Live 0x0000000000000000
  # previous configuration.nix had TODO
  # this breaks VirtualBox
  # wiki (https://wiki.nixos.org/wiki/VirtualBox) refers to this error code (NS_ERROR_FAILURE (0X80004005) 
  # as being a result of installation via environment.systemPackages and virtualisation.*
  # simultaneously, this is not our current case, need to investigate more

  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "cessna" ];
  userDefaults.extraGroups = ["vboxusers"];
}

