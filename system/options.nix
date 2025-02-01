{
  config,
  options,
  lib,
  pkgs,
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
    config.allowUnfree = true;
    hostPlatform.system = "x86_64-linux";
  };

  options = {
    dotfiles = {
      dir = lib.mkOption {type = types.path;
            default = (removePrefix "/mnt"
        (findFirst pathExists (toString ../../.) [
          "/mnt/etc/dotfiles"
          "/etc/dotfiles"
          "/home/cessna/dotfiles"
        ]));
            description = "Directory of the dotfiles";};
      assetDir = lib.mkOption {type = types.path; 
            default = "${config.dotfiles.dir}/home/assets";
            description = "Path to Assets";};
      scriptDir = lib.mkOption {type = types.path; 
            default = "${config.dotfiles.dir}/home/assets/scripts";
            description =  "Path to scripts";};
      imageDir = lib.mkOption {type = types.path;
            default = "${config.dotfiles.dir}/home/assets/images";
            description = "Path to images";};
    };
  };
}
