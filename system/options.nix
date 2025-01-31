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
  nix = {
    settings = {
      experimental-features = mkDefault "nix-command flakes";
      auto-optimise-store = mkDefault true;
    };
  };
  nixpkgs = {
    hostPlatform.system = "x86_64-linux";
  };

  options = {
    dotfiles = {
      dir = mkOption types.path (removePrefix "/mnt"
        (findFirst pathExists (toString ../../.) [
          "/mnt/etc/dotfiles"
          "/etc/dotfiles"
          "/home/cessna/dotfiles"
        ])) "Directory of the dotfiles";
      assetDir = mkOption types.path "${config.dotfiles.dir}/home/assets" "Path to Assets";
      scriptDir = mkOption types.path "${config.dotfiles.dir}/home/assets/scripts" "Path to scripts";
      imagesDir = mkOption types.path "${config.dotfiles.dir}/home/assets/images" "Path to images";
    };
  };
}
