{
  config,
  pkgs,
  lib,
  ...
}: {
  # this might not need to be a seperate file
  virtualisation.waydroid.enable = true;
  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = true;
}
