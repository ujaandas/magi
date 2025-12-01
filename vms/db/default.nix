{
  imports = [
    ./microvm-configuration.nix
  ];

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
