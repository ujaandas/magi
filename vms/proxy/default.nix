{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./microvm-configuration.nix
  ];

  networking = {
    hostName = "proxy";
    useNetworkd = true;
    firewall.allowedTCPPorts = [
      22
    ];
  };

  systemd.network = {
    enable = true;
    networks."20-lan" = {
      matchConfig.Type = "ether";
      networkConfig = {
        Address = [ "192.168.100.4/24" ];
        Gateway = "192.168.100.1";
        DNS = [
          "192.168.100.1"
          "1.1.1.1"
        ];
        DHCP = "no";
      };
    };
  };

  users.users.default = {
    initialPassword = "password";
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  nix = {
    enable = true;
    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };
    settings = {
      experimental-features = "nix-command flakes";
      warn-dirty = false;
    };
    channel.enable = false;
  };

  services.openssh.enable = true;

  system.stateVersion = "24.11";
}
