# Part 6 - home-manager and remote deployment

## home-manager

`home.nix` manages the user's environment (packages, git config, shell aliases)
declaratively, applied by the same `nixos-rebuild switch`. Import it from
`configuration.nix`.

```sh
git config --get user.name   # Obsernetics Lab
type ll                      # ll is aliased to `eza -l --icons'
```

## Remote deployment

`deploy/` is a flake with one `nixosConfiguration` per machine. Build and
activate a remote host from your workstation:

```sh
cd deploy
nixos-rebuild switch --flake .#web01 \
  --target-host nixos@web01 --use-remote-sudo
```

The system is built and activated on the remote host over SSH. Verify on the
target: the active generation is `nixos-system-web01`, the hostname is `web01`,
and nginx serves the page declared in `web01.nix`.
