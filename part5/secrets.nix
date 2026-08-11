{ config, pkgs, ... }:
{
  # sops-nix decrypts secrets at activation into /run/secrets, owned by root.
  imports = [
    "${builtins.fetchTarball "https://github.com/Mic92/sops-nix/archive/master.tar.gz"}/modules/sops"
  ];

  sops.defaultSopsFile = ./secrets/secrets.yaml;
  sops.age.keyFile = "/var/lib/sops-nix/key.txt";
  sops.secrets.api_token = { };
}
