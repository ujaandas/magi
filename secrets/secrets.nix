let
  vm-ooj = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEBil3FzXGvZkdYDp+aVkdR7c8Puld/EkumZmjp/4fdT ujaandas03@gmail.com";
  vm-system = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOGNZec+i+8JUzF6OIZkozl9FaN75bah8xX7TX4+TXER root@homelab";
  vm-root = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGjAWoqQYGYE9OsJTTYesDt1xm89rVSMVZUiW07UWsvI root@nixos";
in
{
  "pocketid.age".publicKeys = [
    vm-ooj
    vm-system
    vm-root
  ];
}
