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
  # and vbox kernel modules; 
  # vboxnetflt 40960 0 - Live 0x0000000000000000 (O)
  # vboxnetadp 32768 0 - Live 0x0000000000000000 (O)
  # vboxdrv 651264 2 vboxnetflt,vboxnetadp, Live 0x0000000000000000 (O)

  # previous configuration.nix had
  # kvm_intel             425984  0
  # kvm                  1327104  1 kvm_intel
  # irqbypass              12288  1 kvm

  # and
  # vboxnetflt             40960  0
  # vboxnetadp             32768  0
  # vboxdrv               651264  2 vboxnetadp,vboxnetflt

  # VirtualBox fails on current derivation
  # wiki (https://wiki.nixos.org/wiki/VirtualBox) refers to this error code (NS_ERROR_FAILURE (0X80004005)
  # as being a result of installation via environment.systemPackages and virtualisation.*
  # simultaneously, this is not our current case, need to investigate more

  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = ["cessna"];
}
