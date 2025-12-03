{ db, auth, ... }:
let
  vmdir = "/home/homelab/homelab/vms";
in
{
  age.secrets.pocketid = {
    file = "/home/homelab/homelab/secrets/pocketid.age";
    owner = "root";
    group = "kvm";
    mode = "0440";
  };

  microvm = {
    autostart = [
      "db"
      "auth"
      # "proxy"
    ];
    vms = {
      db = {
        flake = db;
        updateFlake = "path:${vmdir}/db";
        restartIfChanged = true;
      };
      auth = {
        flake = auth;
        updateFlake = "path:${vmdir}/auth";
        restartIfChanged = true;
      };
    };
  };
}
