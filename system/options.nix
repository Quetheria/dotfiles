{
  config,
  options,
  lib,
  ...
}:
# near 100% taken from https://github.com/sylk0s/dotfiles/tree/nix
let
  inherit (builtins) toString;
  inherit (lib) mkIf types findFirst pathExists removePrefix;
in {
  config.nix = {
    settings = {
      experimental-features = lib.mkDefault "nix-command flakes";
      auto-optimise-store = lib.mkDefault true;
    };
  };
  config.nixpkgs = {
    hostPlatform.system = "x86_64-linux";
  };

  options = {
    dotfiles = {
      dir = lib.mkOption types.path (removePrefix "/mnt"
        (findFirst pathExists (toString ../../.) [
          "/mnt/etc/dotfiles"
          "/etc/dotfiles"
          "/home/cessna/dotfiles"
        ])) "Directory of the dotfiles";
      assetDir = lib.mkOption types.path "${config.dotfiles.dir}/home/assets" "Path to Assets";
      scriptDir = lib.mkOption types.path "${config.dotfiles.dir}/home/assets/scripts" "Path to scripts";
      imagesDir = lib.mkOption types.path "${config.dotfiles.dir}/home/assets/images" "Path to images";
    };
  };
}
