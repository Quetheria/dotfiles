# Edit this configuration file to define what should be installed on

# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
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

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  services.gnome.gnome-keyring.enable = true;
  # Enable the KDE Plasma Desktop Environment.

  virtualisation.waydroid.enable = true;
  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "cessna" ];
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };


  # bluetooth stuff
  hardware.bluetooth.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  programs.fish.enable = true;  
  users.users.cessna = {
    isNormalUser = true;
    description = "Cessna";
    extraGroups = ["video" "networkmanager" "wheel" "docker"];
    shell = pkgs.fish;
    packages = with pkgs; [
    fish
    firefox
    neovim
    ripgrep
    hugo
    obsidian
    
    flameshot
    powerline
    powerline-fonts
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;


  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    openssh
    wireshark
    git
    linux-manual
    man-pages
    pciutils
    light
    xdg-desktop-portal
    wine
    xdg-desktop-portal-wlr
  ];
specialisation = {
    xorg.configuration = { 
        services.xserver = {
            enable = true;
            desktopManager = {
                xterm.enable = false;
                xfce.enable = true;
            };
        };
    };
    wayland.configuration = {

        
        environment.systemPackages = with pkgs; [
            grim # screenshot 
            slurp # screenshot 
            mako # notification system developed by swaywm maintainer
            wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
            xwayland
            wl-mirror
        ];
        #sway
        programs.sway = {
            enable = true;
            wrapperFeatures.gtk = true;
        };

        systemd.services.greetd = {
            unitConfig = {
                After = lib.mkOverride 0 [ "multi-user.target" ];
            };
            serviceConfig = {
                Type = "idle";
            };
        };

        services.greetd = {                                                      
            enable = true;                                                         
            settings = {                                                           
                terminal = {
	                vt = 2;
                };
                default_session = {                                                  
                    command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd /home/cessna/.config/sway/greet.sh";
                    user = "greeter";                                                  
                };                                                                   
            };                                                                     
        };
    };
  };
  services.udev.extraRules = 
    let
      mkRule = as: lib.concatStringsSep ", " as;
      mkRules = rs: lib.concatStringsSep "\n" rs;
    in mkRules ([( mkRule [
      # hdparm powersaving rules
      ''ACTION=="add|change"''
      ''SUBSYSTEM=="block"''
      ''KERNEL=="sd[a-z]"''
      ''ATTR{queue/rotational}=="1"''
      ''RUN+="${pkgs.hdparm}/bin/hdparm -B 90 -S 41 /dev/%k"''])

     ( mkRule [
      # brightness modification from non-root users
    ''ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", MODE="0666", RUN+="${pkgs.coreutils}/bin/chmod a+w /sys/class/backlight/%k/brightness"''
    ])]);

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };


  # Enable the OpenSSH daemon.
  services.openssh = {
  	enable = true;
  	ports = [ 23323 ];
  	settings = {
    		PasswordAuthentication = true;
    		AllowUsers = null; # Allows all users by default. Can be [ "user1" "user2" ]
    		UseDns = true;
    		X11Forwarding = false;
    		PermitRootLogin = "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
  	};
  };


  
  services.tailscale.enable = true;
  # tailscale
  networking.nameservers = ["100.100.100.100" "1.1.1.1" "1.0.0.1" ];
  networking.search = ["tailaba8fe.ts.net"];

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 23323 ];
  networking.useDHCP = false;
  networking.interfaces.wlp2s0.useDHCP = true; 
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  services.resolved = {
    enable = true;
    dnssec = "true";
    domains = [ "~." ];
    fallbackDns = [
      "1.1.1.1"
      "1.0.0.1"
    ];
    dnsovertls = "true";
  };

  # obs kernel settings
  boot.extraModulePackages = with config.boot.kernelPackages; [
        v4l2loopback
  ];
  boot.kernelModules = [ "v4l2loopback" ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';
  boot.resumeDevice = "/dev/sda2";
  security.polkit.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
