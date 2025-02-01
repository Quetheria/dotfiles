{
  config,
  options,
  lib,
  pkgs,
  ...
}: {
  

  #programs.powerline.enable = true;
  # powerline go doesn't work on fish
  # and vanilla powerline cant be configured with hm
  # maybe we fork it/write something custom
  #    programs.powerline-go = {
  #        enable = true;
  #        modules = [
  #          "host"
  #          "ssh"
  #          "cwd"
  #          "gitlite"
  #          "jobs"
  #          "exit"
  #        ]
}
