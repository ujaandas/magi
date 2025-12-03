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

  services.pocket-id = {
    enable = true;
    settings = {
      APP_URL = "http://localhost:3000";
      PORT = 3000;
      TRUST_PROXY = false;
      ANALYTICS_DISABLED = true;
      DB_PROVIDER = "postgres";
      DB_CONNECTION_STRING = "postgresql://pocketid@192.168.100.2:5432/pocketid";
      KEYS_STORAGE = "database";
      # ENCRYPTION_KEY_FILE = "$CREDENTIALS_DIRECTORY/POCKETID";
    };
  };

  systemd = {
    services.pocket-id = {
      serviceConfig = {
        LoadCredential = [ "POCKETID" ];
        Environment = [ ''ENCRYPTION_KEY=$CREDENTIALS_DIRECTORY/POCKETID'' ];
        # ExecStartPre = ''${pkgs.bash}/bin/bash -c 'cat "$CREDENTIALS_DIRECTORY/POCKETID"' '';
      };
    };

    tmpfiles.rules = [
      "d /var/lib/pocket-id 0755 pocket-id pocket-id -"
    ];
  };

  networking = {
    hostName = "auth";
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
        Address = [ "192.168.100.3/24" ];
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
