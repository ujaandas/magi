{
  config,
  lib,
  pkgs,
  ...
}:
let
  domain = "ujaan.me";
in
{
  imports = [
    ./microvm-configuration.nix
  ];

  services = {
    openssh.enable = true;

    caddy = {
      enable = true;
      email = "ujaandas03@gmail.com";
      extraConfig = ''
        {
          admin off
        }

        pocketid.${domain} {
          reverse_proxy 192.168.100.3:3000
        }
      '';
    };

    dnsmasq = {
      enable = true;
      settings = {
        listen-address = "192.168.100.4";
        bind-interfaces = true;
        server = [ "1.1.1.1" ];
        address = [
          "/pocketid.${domain}/192.168.100.4"
        ];
      };
    };
  };

  networking = {
    hostName = "proxy";
    useNetworkd = true;
    firewall.allowedTCPPorts = [
      22
      80
      443
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

  system.stateVersion = "24.11";
}
