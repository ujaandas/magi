{ db, ... }:
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
        # updateFlake = "file://${toString ../../vms/db}";
      };
    };
  };
}
