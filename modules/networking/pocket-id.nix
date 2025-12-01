{
  services.pocket-id = {
    enable = true;
    settings = {
      APP_URL = "http://localhost:3000";
      PORT = 3000;
      TRUST_PROXY = false;
      ANALYTICS_DISABLED = true;
    };
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/pocket-id 0755 pocket-id pocket-id -"
  ];
}
