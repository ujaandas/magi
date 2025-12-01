{ config, ... }:
{
  age.secrets.pocketid = {
    file = "/home/homelab/homelab/secrets/pocketid.age";
    owner = "pocket-id";
    group = "pocket-id";
    # mode = "0400";
  };

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
      ENCRYPTION_KEY_FILE = config.age.secrets.pocketid.path;
    };
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/pocket-id 0755 pocket-id pocket-id -"
  ];
}
