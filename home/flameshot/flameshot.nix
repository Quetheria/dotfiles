{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  flameshotGrim = pkgs.flameshot.overrideAttrs (oldAttrs: {
    src = pkgs.fetchFromGitHub {
      owner = "flameshot-org";
      repo = "flameshot";
      rev = "119df557f5947a57425fc926baffcf26fed5f117";
      sha256 = "sha256-OLRtF/yjHDN+sIbgilBZ6sBZ3FO6K533kFC1L2peugc=";
    };
    cmakeFlags = [
      "-DUSE_WAYLAND_CLIPBOARD=1"
      "-DUSE_WAYLAND_GRIM=1"
    ];
    buildInputs = oldAttrs.buildInputs ++ [pkgs.libsForQt5.kguiaddons];
  });
in {
  services.flameshot = {
    enable = true;
    package = "${flameshotGrim}";

    settings = {
      General = {
        contrastOpacity = 188;
        filenamePattern = "%Y-%m-%d_%H-%M-%S";
        savePath = "/home/cessna/Pictures/screenshots";
      };
    };
  };
}
