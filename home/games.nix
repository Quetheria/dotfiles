{config, pkgs, ... }:


{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;

  };

  programs.prism-launcher.enable = true;

}
