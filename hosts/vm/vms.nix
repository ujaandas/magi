{ db, ... }:
let
  vmdir = "/home/homelab/homelab/vms";
in
{
  microvm = {
    autostart = [
      "db"
      # "auth"
      # "proxy"
    ];
    vms = {
      db = {
        flake = db;
        updateFlake = "path:${vmdir}/db";
      };
    };
  };
}
