# Part 5 - NixOS in practice: services, users, networking, secrets

Split the system into modules imported from `configuration.nix`:

```nix
imports = [ ./hardware-configuration.nix ./web.nix ./secrets.nix ];
```

- `web.nix` - nginx virtual host, a single opened firewall port, an extra
  `deploy` user, and a custom `systemd` oneshot service. All declarative.
- `secrets.nix` - secret management with sops-nix.

## Secrets with sops-nix

Secrets stay encrypted in git and are decrypted only at activation, into
`/run/secrets`, readable by root only. One-time setup:

```sh
# a machine key
sudo mkdir -p /var/lib/sops-nix
sudo age-keygen -o /var/lib/sops-nix/key.txt
RECIP=$(sudo age-keygen -y /var/lib/sops-nix/key.txt)

# encrypt a secret to that key
printf 'api_token: s3cr3t\n' > plain.yaml
sops --age "$RECIP" --encrypt plain.yaml > secrets/secrets.yaml && rm plain.yaml
```

Then `sops.secrets.api_token = {};` exposes it at `/run/secrets/api_token` after
`nixos-rebuild switch`. Never commit `key.txt`.
