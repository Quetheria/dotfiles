{
  config,
  pkgs,
  lib,
  input,
  ...
}: {
  networking.hostName = "nixos";

  networking.networkmanager.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    ports = [23323];
    settings = {
      PasswordAuthentication = false;
      AllowUsers = null; # Allows all users by default. Can be [ "user1" "user2" ]
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
    };
  };

  services.tailscale.enable = true;
  # tailscale
  networking.nameservers = ["100.100.100.100" "1.1.1.1" "1.0.0.1"];
  networking.search = ["tailaba8fe.ts.net"];

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [23323];
  networking.useDHCP = false;
  networking.interfaces.wlp2s0.useDHCP = true;
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  services.resolved = {
    enable = true;
    dnssec = "true";
    domains = ["~."];
    fallbackDns = [
      "1.1.1.1"
      "1.0.0.1"
    ];
    dnsovertls = "true";
  };
}
