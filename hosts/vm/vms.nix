{
  db,
  auth,
  proxy,
  ...
}:
let
  vmdir = "/home/homelab/homelab/vms";
  secretdir = "/home/homelab/homelab/secrets";
in
{
  age.secrets = {
    pocketid = {
      file = "${secretdir}/pocketid.age";
      owner = "root";
      group = "kvm";
      mode = "0440";
    };

    cloudflare = {
      file = "${secretdir}/cloudflare.age";
      owner = "root";
      group = "kvm";
      mode = "0440";
    };
  };

  microvm = {
    autostart = [
      "db"
      "auth"
      "proxy"
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
      proxy = {
        flake = proxy;
        updateFlake = "path:${vmdir}/proxy";
        restartIfChanged = true;
      };
    };
  };
}
