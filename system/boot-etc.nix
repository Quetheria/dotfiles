{
  config,
  pkgs,
  lib,
  ...
}:
#TODO make this less of a mess
{
  # grub
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  services.tlp = {
    enable = true;
    settings = {
      INTEL_GPU_MIN_FREQ_ON_AC = 300;
      INTEL_GPU_MIN_FREQ_ON_BAT = 300;
      INTEL_GPU_MAX_FREQ_ON_AC = 1050;
      INTEL_GPU_MAX_FREQ_ON_BAT = 600;
      INTEL_GPU_BOOST_FREQ_ON_AC = 1050;
      INTEL_GPU_BOOST_FREQ_ON_BAT = 1050;
      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 30;
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;
      CPU_HWP_DYN_BOOST_ON_AC = 1;
      CPU_HWP_DYN_BOOST_ON_BAT = 0;
      USB_EXCLUDE_BTUSB = 1;
    };
  };

  # tz and i18n
  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # swaylock
  services.gnome.gnome-keyring.enable = true;

  # home manager sway nonsense
  programs.sway.enable = true;
  programs.sway.package = null;

  services.greetd = {
    enable = true;
    settings = {
      terminal = {
        vt = 2;
      };
      default_session = {
        command = ''
          ${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway
        '';
        user = "greeter";
      };
    };
  };

  # power management things
  services.udev.extraRules = let
    mkRule = as: lib.concatStringsSep ", " as;
    mkRules = rs: lib.concatStringsSep "\n" rs;
  in
    mkRules [
      (mkRule [
        # hdparm powersaving rules
        ''ACTION=="add|change"''
        ''SUBSYSTEM=="block"''
        ''KERNEL=="sd[a-z]"''
        ''ATTR{queue/rotational}=="1"''
        ''RUN+="${pkgs.hdparm}/bin/hdparm -B 90 -S 41 /dev/%k"''
      ])

      (mkRule [
        # brightness modification from non-root users
        ''ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", MODE="0666", RUN+="${pkgs.coreutils}/bin/chmod a+w /sys/class/backlight/%k/brightness"''
      ])
    ];

  system.stateVersion = "24.05";
}
