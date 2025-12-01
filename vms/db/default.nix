{ lib, pkgs, ... }:
{
  imports = [
    ./microvm-configuration.nix
  ];

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_15;
    ensureDatabases = [ "pocketid" ];
    ensureUsers = [
      {
        name = "pocketid";
        ensureDBOwnership = true;
      }
    ];
    settings.listen_addresses = lib.mkForce "*";

    authentication = lib.mkOverride 10 ''
      # Allow local connections
      local   all         all                     trust
      # Allow LAN subnet connections
      host    pocketid    pocketid   192.168.100.0/24   scram-sha-256
    '';
  };

  networking = {
    hostName = "db";
    useNetworkd = true;
    firewall.allowedTCPPorts = [
      22
      5432
    ];
  };

  systemd.network.enable = true;

  systemd.network.networks."20-lan" = {
    matchConfig.Type = "ether";
    networkConfig = {
      Address = [ "192.168.100.2/24" ];
      Gateway = "192.168.100.1";
      DNS = [
        "192.168.100.1"
        "1.1.1.1"
      ];
      DHCP = "no";
    };
  };

  users.users.default = {
    initialPassword = "password";
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  services.openssh.enable = true;

  system.stateVersion = "24.11";
}
