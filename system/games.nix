{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    (lutris.override {
      extraLibraries = pkgs: [
        #TODO install games/check deps
      ];
      extraPkgs = pkgs: [
      ];
    })
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
}
